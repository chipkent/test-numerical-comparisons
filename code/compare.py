#!/usr/bin/env python3

import math

values = ["-0.0", "0.0", "math.nan", "-math.nan", "math.inf", "-math.inf"]
operations = ['==', '!=', '>', '>=', '<', '<=', 'hashCode==']

lang = 'Python'
h0 = 'lang'
h1 = 'v1'
h2 = 'v2'
heading = f'{h0:>12}, {h1:>12}, {h2:>12}'
for op in operations:
    heading += f',\t{op}'
print(heading)

for v1 in values:
    for v2 in values:
        result = f'{lang:>12}, {v1:>12}, {v2:>12}'
        for op in operations:
            rst = eval(f"{v1} {op} {v2}") if not op == 'hashCode==' else hash(v1) == hash(v2)
            result += f',\t{rst}'
        print(result)


# Create the table header
header = '| ' + ' | '.join(['lang', 'v1', 'v2'] + operations) + ' |'
print(header)

# Create the separator for the table header
separator = '| ' + ' | '.join(['---'] * (len(operations) + 3)) + ' |'
print(separator)

# Create the table rows
for v1 in values:
    for v2 in values:
        row = [lang, v1, v2]
        for op in operations:
            rst = eval(f"{v1} {op} {v2}") if not op == 'hashCode==' else hash(v1) == hash(v2)
            row.append(str(rst))
        print('| ' + ' | '.join(row) + ' |')