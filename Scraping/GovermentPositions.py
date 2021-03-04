import requests
import json
import pandas as pd

base_url = 'https://www.knesset.gov.il/WebSiteApi/knessetapi/goverment?GovId='

dfs = []
for i in range(35, -1, -1):
    r = requests.get(base_url + str(i))
    parsed = json.loads(r.content)
    df = pd.DataFrame.from_records(parsed['GovermentPositions'])
    df['GovernmentNumber'] = i
    dfs.append(df)
    
pd.concat(dfs).to_csv('GovermentPositions.csv', encoding='utf-8-sig', index=False)