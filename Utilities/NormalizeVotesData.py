import pandas as pd
import re

def replace_dictionary(text, replace_dict):    
    escaped_dict = dict((re.escape(k), v) for k, v in replace_dict.items()) 
    pattern = re.compile("|".join(escaped_dict.keys()))
    text = pattern.sub(lambda m: escaped_dict[re.escape(m.group(0))], text)
    return text

def fix_date(date_string):
    date_string = re.sub('\s\s+','\s', date_string)

    replacements = {
        u'\xa0\xa0': ' ',
        u'\u200f': '',
        u'יום\xa0': '',
        'יום', ""}
    
    date_terms = {
        "ינואר" : "01",
        "פברואר" : "02",
        "מרץ" : "03",
        "אפריל" : "04",
        "מאי" : "05",
        "יוני" : "06",
        "יולי" : "07",
        "אוגוסט" : "08",
        "ספטמבר" : "09",
        "אוקטובר" : "10",
        "נובמבר" : "11",
        "דצמבר" : "12"}
    
    date_string = replace_dictionary(date_string, replacements)    
    lst = str(date_string).strip().split(' ')
    return "{}/{}/{} {}".format(lst[1], date_terms[lst[2]], lst[3], lst[4])

def fix_rule(rule_string):
    return str(rule_string).replace('אי-אמון', 'אי אמון')

def fix_party(party_string):
    replacements = {
        'ש"ס-התאחדות ספרדים שומרי תורה': 'ש"ס',
        'ביתינו' : 'ביתנו',
        'יחד (ישראל חברתית דמוקרטית) והבחירה הדמוקרטית' : 'יחד והבחירה הדמוקרטית',
        'יחד  (ישראל חברתית דמוקרטית) והבחירה הדמוקרטית' : 'יחד והבחירה הדמוקרטית',
        'חד  (ישראל חברתית דמוקרטית) והבחירה הדמוקרטית' : 'יחד והבחירה הדמוקרטית',
        'יחד והבחירה הדמוקרטית (מרצ לשעבר)' : 'יחד והבחירה הדמוקרטית',
        'העצמאות ': 'העצמאות',
        'הליכוד' : 'ליכוד',
        'בל"ד-ברית לאומית דמוקרטית' : 'בל"ד'}

    return replace_dictionary(str(party_string), replacements)


db_path = r'./VotesDB.csv'
df = pd.read_csv(db_path, encoding='utf-8-sig')

df['Date'] = df['Date'].apply(fix_date)
df['Rule'] = df['Rule'].apply(fix_rule)
df['Party'] = df['Party'].apply(fix_party)
df['Type'] = df['Rule'].str.split('-', 1).str[0]
df['Rule'] = df['Rule'].str.split('-', 1).str[1]

df.to_csv(r'./NormalizedVotesDB.csv', encoding='utf-8-sig', index=False)