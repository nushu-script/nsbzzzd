#!/usr/bin/env python3

import pandas
from collections import defaultdict
import json

d = defaultdict(list)
data = pandas.read_csv('data.csv')
for v, ks in zip(data['女书序号'], data['对应汉字']):
    for k in ks:
        d[k].append(v)
print(json.dumps(d, ensure_ascii=False, sort_keys=True).replace('], ', '],\n'))
