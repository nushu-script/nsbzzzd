#!/usr/bin/env python3

import pandas
from collections import defaultdict
import json

d = defaultdict(list)
data = pandas.read_csv('data.csv')
for v1, v2, ks in zip(data['女书序号'], data['发音'], data['对应汉字']):
    for k in ks:
        d[k].append((v1, v2))
with open('map.json', 'w') as fout:
	print(json.dumps(d, ensure_ascii=False, sort_keys=True).replace('], "', ']\n,"').replace(' ', ''), file=fout)
