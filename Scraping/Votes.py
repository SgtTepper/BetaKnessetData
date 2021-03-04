#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import requests
import numpy as np
import pandas as pd
import lxml.html as LH

base_url = "https://www.knesset.gov.il/vote/heb/Vote_Res_Map.asp"
search_url = "https://www.knesset.gov.il/vote/heb/vote_search.asp"

headers = {
    'accept': "*/*",
    'Accept-Language': "en-US,en;q=0.9,he;q=0.8",
    'Content-Type': "text/html; charset=utf-8",
    'Postman-Token': "bf182af5-4500-40d5-ad15-3c134a888bac",
    'User-Agent': "PostmanRuntime/7.23.0",
    'Cache-Control': "no-cache",
    'Host': "www.knesset.gov.il",
    'Cookie': "rbzid=3pd95R7URU86rXpLcSW6Ra5y7R+6rQJd+Zq4GzfBsQmN4IWmOGdJHGo8SHGdXWXQ4xWHDwF6VfujpVG2lYrjsO1n9SmX+qxSAzRJBFpLbP4=",
    'Accept-Encoding': "gzip, deflate",
    'Connection': "keep-alive",
    'cache-control': "no-cache"
}

latest_rule_id = 33461

for rule_id in range(latest_rule_id, 0, -1):
    
    query_string = {"vote_id_t": str(rule_id)}    
    response = requests.request("GET", base_url, headers=headers, params=query_string)
    root = LH.fromstring(response.content)
       
    if response.url != search_url:
        
        in_favor_name = [x.text_content() for x in
                         root.xpath('//tr[3]/td[2]/table/tr[2]/td/table[2]/tr/td[1]/table[1]/tr[2]/td/table/tr/td[2]') if
                         x.text_content() != '']

        in_favor_party = [x.text_content() for x in
                          root.xpath('//tr[3]/td[2]/table/tr[2]/td/table[2]/tr/td[1]/table[1]/tr[2]/td/table/tr/td[3]') if
                          x.text_content() != '']

        against_name = [x.text_content() for x in
                        root.xpath('//tr[3]/td[2]/table/tr[2]/td/table[2]/tr/td[2]/table[1]/tr[2]/td/table/tr/td[2]') if
                        x.text_content() != '']

        against_party = [x.text_content() for x in
                         root.xpath('//tr[3]/td[2]/table/tr[2]/td/table[2]/tr/td[2]/table[1]/tr[2]/td/table/tr/td[3]') if
                         x.text_content() != '']

        avoid_name = [x.text_content() for x in
                      root.xpath('//tr[3]/td[2]/table/tr[2]/td/table[2]/tr/td[1]/table[2]/tr[2]/td/table/tr/td[2]') if
                      x.text_content() != '']

        avoid_party = [x.text_content() for x in
                       root.xpath('//tr[3]/td[2]/table/tr[2]/td/table[2]/tr/td[1]/table[2]/tr[2]/td/table/tr/td[3]') if
                       x.text_content() != '']

        no_vote_name = [x.text_content() for x in
                      root.xpath('//tr[3]/td[2]/table/tr[2]/td/table[2]/tr/td[2]/table[2]/tr[2]/td/table/tr/td[2]') if
                      x.text_content() != '']

        no_vote_party = [x.text_content() for x in
                       root.xpath('//tr[3]/td[2]/table/tr[2]/td/table[2]/tr/td[2]/table[2]/tr[2]/td/table/tr/td[3]') if
                       x.text_content() != '']

        committee = root.xpath('//tr[3]/td[2]/table/tr[2]/td/center/table/tr[1]/td[2]')[0].text_content()

        meeting = root.xpath('//tr[3]/td[2]/table/tr[2]/td/center/table/tr[2]/td[2]')[0].text_content()

        date = root.xpath('//tr[3]/td[2]/table/tr[2]/td/center/table/tr[3]/td[2]')[0].text_content()

        rule = root.xpath('//tr[3]/td[2]/table/tr[2]/td/center/table/tr[4]/td[2]')[0].text_content()


        in_favor_df = pd.DataFrame(list(zip(in_favor_name, in_favor_party))[1:], columns=['Name', 'Party'])
        in_favor_df['Vote'] = 'בעד'

        against_df = pd.DataFrame(list(zip(against_name, against_party))[1:], columns=['Name', 'Party'])
        against_df['Vote'] = 'נגד'

        avoid_df = pd.DataFrame(list(zip(avoid_name, avoid_party))[1:], columns=['Name', 'Party'], )
        avoid_df['Vote'] = 'נמנע'

        no_vote_df = pd.DataFrame(list(zip(no_vote_name, no_vote_party))[1:], columns=['Name', 'Party'], )
        no_vote_df['Vote'] = 'לא הצביע'

        dataframes = [in_favor_df, against_df, avoid_df, no_vote_df]

        for df in dataframes:
            df.replace(' " ', np.nan, inplace=True)
            df.fillna(method='ffill', inplace=True)
            df['Rule'] = rule
            df['Date'] = date
            df['Committee'] = committee
            df['Meeting'] = meeting
            df['Id'] = 'https://www.knesset.gov.il/vote/heb/Vote_Res_Map.asp?vote_id_t='+str(rule_id)

        current_path = os.getcwd()

        pd.concat(dataframes).to_csv(f'{current_path}/{rule_id}.csv', encoding='utf-8-sig', index=False)
        print("downloaded data for rule id: ", rule_id)