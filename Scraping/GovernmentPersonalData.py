import urllib.request
import pandas as pd
import requests
import json

base_url = 'https://knesset.gov.il/WebSiteApi/knessetapi/MKs/GetMksPrevious'

r = requests.get(base_url)
parsed = json.loads(r.content)
df = pd.DataFrame.from_records(parsed['MksPrevious'])
df.to_csv('GovernmentPersonalData.csv', encoding='utf-8-sig', index=False)

for index, row in df.iterrows():      
    urllib.request.urlretrieve(row['imgPath'], 'GovernmentImages/' + row['FullName'] + '.png')