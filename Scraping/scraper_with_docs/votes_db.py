import json
import time

from sqlalchemy import create_engine
from sqlalchemy import Column, Integer, String, Boolean, TIMESTAMP
from sqlalchemy.orm import declarative_base
from sqlalchemy.orm import sessionmaker
from dateutil import parser as date_parser


Base = declarative_base()


class VoteInfo(Base):
    __tablename__ = "VoteInfo"
    VoteId = Column(Integer, primary_key=True)
    VoteProtocolNo = Column(Integer)
    VoteDate = Column(TIMESTAMP)
    VoteDateStr = Column(String)
    VoteTimeStr = Column(String)
    VoteType = Column(String)
    VoteTypeId = Column(Integer)
    ItemTitle = Column(String)
    FK_ItemID = Column(Integer)
    FK_AssemblyID = Column(Integer)
    LU_ItemType = Column(Integer)
    SessionNumber = Column(Integer)
    FK_Knesset = Column(Integer)
    KnessetName = Column(String)
    Decision = Column(String)
    ChairmanName = Column(String)
    DescreetVoteType = Column(String, nullable=True)
    IsForAccepted = Column(Boolean)
    AcceptedText = Column(String)


class VoteCounters(Base):
    __tablename__ = "VoteCounters"
    VoteId = Column(Integer, primary_key=True)
    Title = Column(String, primary_key=True)
    countOfResult = Column(Integer)
    rn = Column(Integer, primary_key=True, default=-1)
    ColorName = Column(String)


class VoteDetails(Base):
    __tablename__ = "VoteDetails"
    VoteId = Column(String, primary_key=True)
    MkName = Column(String, primary_key=True)
    FactionName = Column(String, primary_key=True, nullable=True)
    VoteResultId = Column(Integer, primary_key=True)
    Title = Column(String, primary_key=True)


class VoteDocs(Base):
    __tablename__ = "VoteDocs"
    VoteId = Column(String, primary_key=True)
    DocsId = Column(String, primary_key=True)
    Status = Column(String, primary_key=True)
    Name = Column(String)
    Url = Column(String, primary_key=True)


class ScrapeData(Base):
    __tablename__ = "ScrapeData"
    VoteId = Column(Integer, primary_key=True)
    Data = Column(String)


def save_raw_vote(res, vote_id, db):
    try:
        data = res.json()
        if not data.get("VoteHeader"):
            return "empty vote"
        db.add(ScrapeData(VoteId=vote_id, Data=json.dumps(data)))
        return "done"
    except:
        print("failed", res.url)
        pass


def get(db_path):
    engine = create_engine(f"sqlite:///{db_path}?charset=utf8")
    Base.metadata.create_all(engine)
    Session = sessionmaker(bind=engine)
    Session.configure(bind=engine)
    db = Session()
    return db


def construct_parsed_tables(db):
    counter = 0
    known_votes = [x[0] for x in db.query().with_entities(VoteInfo.VoteId).all()]
    for data in db.query(ScrapeData).all():
        data: ScrapeData = data
        _id = data.VoteId
        if _id in known_votes:
            continue

        data_dict = json.loads(data.Data)
        while type(data_dict) == str:
            data_dict = json.loads(data_dict)
        if not data_dict["VoteHeader"]:
            continue
        if len(data_dict["VoteHeader"]) > 1 and _id != 37161:
            raise RuntimeError(f"vote_id {_id} contains more than 1 header")
        timestamp = date_parser.parse(data_dict["VoteHeader"][0]["VoteDate"])
        data_dict["VoteHeader"][0]["VoteDate"] = timestamp
        info = VoteInfo(**data_dict["VoteHeader"][0])
        db.add(info)
        for counters_dict in data_dict["VoteCounters"]:
            counters = VoteCounters(**counters_dict)
            counters.VoteId = _id
            db.add(counters)
        for details_dict in data_dict["VoteDetails"]:
            details = VoteDetails(**details_dict)
            details.VoteId = _id
            db.add(details)
        counter += 1
        if counter % 1000 == 0:
            print(counter)
            s = time.time()
            db.commit()
            print("done", time.time() - s)
    db.commit()
