#!/bin/python


import json
import pandas as pd

with open('/home/rce9je/DS2002-json-practice/data/schacon.repos.json', 'r') as file:
    data = json.load(file)


need = [
    'name', 
    'html_url',
    'updated_at',
    'visibility',
    ]

ans = []
for i in range(len(data)):
    placeholder = []
    for c in need:
        placeholder.append(data[i][c])
    ans.append(placeholder)

#print(ans)

df = pd.DataFrame(ans)

df_export = df.head(5)
#print(df_export)

df_export.to_csv('chacon.csv', index=False, header=False)

