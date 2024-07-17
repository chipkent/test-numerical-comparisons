
from deephaven import new_table
from deephaven.column import string_col
from deephaven.pandas import to_pandas

values = ["-0.0", "+0.0", "NaN", "-NaN", "Infinity", "-Infinity"]
operations = {
    'Eq': 'v1 == v2',
    'Ne': 'v1 != v2',
    'Gt': 'v1 > v2',
    'Ge': 'v1 >= v2',
    'Lt': 'v1 < v2',
    'Le': 'v1 <= v2',
    'Hc': 'Double.hashCode(v1) == Double.hashCode(v2)'}

t = new_table([string_col("v1", values)]).update("v1=Double.parseDouble(v1)")

t = t.join(t.view("v2=v1"))

t = t.update([f'{name} = {query}' for name, query in operations.items()])

df = to_pandas(t)

import os
os.system("pip install tabulate")

print(df.to_markdown(index=False))

sdata = new_table([string_col("s1", values)]).update("v1=Double.parseDouble(s1)")
sa = sdata.sort("v1")
sd = sdata.sort_descending("v1")
