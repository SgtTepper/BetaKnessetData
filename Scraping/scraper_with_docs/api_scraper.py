import sqlite3
import time
from pathlib import Path

import requests
import sqlalchemy

from law_docs_fetcher import extract_docs
import votes_db
from votes_db import VoteDocs, VoteInfo


db_path = Path(__file__).parent / "votes.db"
db = votes_db.get(db_path)


def scrape_raw_votes(start_id_to_check=1, max_id_to_check=40_000):
    known_votes = [
        x[0] for x in db.query().with_entities(votes_db.ScrapeData.VoteId).all()
    ]
    while 1:
        try:
            for vote_id in range(start_id_to_check, max_id_to_check):
                if vote_id in known_votes:
                    continue
                url = f"https://www.knesset.gov.il/WebSiteApi/knessetapi/Votes/GetVoteDetails/{vote_id}"
                res = requests.get(url)

                votes_db.save_raw_vote(res, vote_id, db)
                print(vote_id)
                db.commit()
            break
        except Exception as ex:
            try:
                if "30" in str(res.content.decode()):
                    print("sleeping 35 seconds too many requests to the api")
                    time.sleep(35)
            except:
                pass
            print(ex)
            print("sleeping 3 seconds")
            time.sleep(3)


def get_law_docs():
    global db
    known_docs_ids = set(
        [x[0] for x in db.query().with_entities(VoteDocs.DocsId).all()]
    )
    docs_id_to_vote_id = dict(
        [
            (str(x[0]), x[1])
            for x in db.query().with_entities(VoteInfo.FK_ItemID, VoteInfo.VoteId).all()
        ]
    )

    docs_to_extract = set(docs_id_to_vote_id.keys()) - known_docs_ids
    for docs_id in docs_to_extract:
        res = extract_docs(docs_id)
        for url, name in res:
            vd = VoteDocs(
                VoteId=docs_id_to_vote_id[docs_id],
                DocsId=docs_id,
                Name=name,
                Url=url,
                Status="Found",
            )
            db.add(vd)
        if not res:
            vd = VoteDocs(
                VoteId=docs_id_to_vote_id[docs_id],
                DocsId=docs_id,
                Name="",
                Url="",
                Status="Documents not found",
            )
            db.add(vd)
        try:
            db.commit()
        except (sqlalchemy.exc.IntegrityError, sqlite3.IntegrityError) as ex:
            print("failed to add record", docs_id)
            print(ex)

        except Exception as ex:
            print("unknown fail on adding docs_id", docs_id)
            print(ex)
            if (
                "This Session's transaction has been rolled back due to a previous exception during flush"
                in str(ex)
            ):
                db = votes_db.get(db_path)


if __name__ == "__main__":
    # scrapping the raw data of votes
    scrape_raw_votes()
    # parsing the raw votes data in the database
    votes_db.construct_parsed_tables(db)
    # enriching the votes data with documents related to votes
    get_law_docs()
