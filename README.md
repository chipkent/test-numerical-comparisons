# test-numerical-comparisons
Look at numerical comparisons in different languages so that they can be compared against IEEE754.




## Java

| lang | v1 | v2 | == | != | > | >= | < | <= | hashCode== | 
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Java | -0.00 | -0.00 | True | False | False | True | False | True | True | 
| Java | -0.00 | 0.00 | True | False | False | True | False | True | False | 
| Java | -0.00 | NaN | False | True | False | False | False | False | False | 
| Java | -0.00 | NaN | False | True | False | False | False | False | False | 
| Java | -0.00 | Infinity | False | True | False | False | True | True | False | 
| Java | -0.00 | -Infinity | False | True | True | True | False | False | False | 
| Java | 0.00 | -0.00 | True | False | False | True | False | True | False | 
| Java | 0.00 | 0.00 | True | False | False | True | False | True | True | 
| Java | 0.00 | NaN | False | True | False | False | False | False | False | 
| Java | 0.00 | NaN | False | True | False | False | False | False | False | 
| Java | 0.00 | Infinity | False | True | False | False | True | True | False | 
| Java | 0.00 | -Infinity | False | True | True | True | False | False | False | 
| Java | NaN | -0.00 | False | True | False | False | False | False | False | 
| Java | NaN | 0.00 | False | True | False | False | False | False | False | 
| Java | NaN | NaN | False | True | False | False | False | False | True | 
| Java | NaN | NaN | False | True | False | False | False | False | True | 
| Java | NaN | Infinity | False | True | False | False | False | False | False | 
| Java | NaN | -Infinity | False | True | False | False | False | False | False | 
| Java | NaN | -0.00 | False | True | False | False | False | False | False | 
| Java | NaN | 0.00 | False | True | False | False | False | False | False | 
| Java | NaN | NaN | False | True | False | False | False | False | True | 
| Java | NaN | NaN | False | True | False | False | False | False | True | 
| Java | NaN | Infinity | False | True | False | False | False | False | False | 
| Java | NaN | -Infinity | False | True | False | False | False | False | False | 
| Java | Infinity | -0.00 | False | True | True | True | False | False | False | 
| Java | Infinity | 0.00 | False | True | True | True | False | False | False | 
| Java | Infinity | NaN | False | True | False | False | False | False | False | 
| Java | Infinity | NaN | False | True | False | False | False | False | False | 
| Java | Infinity | Infinity | True | False | False | True | False | True | True | 
| Java | Infinity | -Infinity | False | True | True | True | False | False | False | 
| Java | -Infinity | -0.00 | False | True | False | False | True | True | False | 
| Java | -Infinity | 0.00 | False | True | False | False | True | True | False | 
| Java | -Infinity | NaN | False | True | False | False | False | False | False | 
| Java | -Infinity | NaN | False | True | False | False | False | False | False | 
| Java | -Infinity | Infinity | False | True | False | False | True | True | False | 
| Java | -Infinity | -Infinity | True | False | False | True | False | True | True | 

## Python

| lang | v1 | v2 | == | != | > | >= | < | <= | hashCode== |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Python | -0.0 | -0.0 | True | False | False | True | False | True | True |
| Python | -0.0 | 0.0 | True | False | False | True | False | True | False |
| Python | -0.0 | math.nan | False | True | False | False | False | False | False |
| Python | -0.0 | -math.nan | False | True | False | False | False | False | False |
| Python | -0.0 | math.inf | False | True | False | False | True | True | False |
| Python | -0.0 | -math.inf | False | True | True | True | False | False | False |
| Python | 0.0 | -0.0 | True | False | False | True | False | True | False |
| Python | 0.0 | 0.0 | True | False | False | True | False | True | True |
| Python | 0.0 | math.nan | False | True | False | False | False | False | False |
| Python | 0.0 | -math.nan | False | True | False | False | False | False | False |
| Python | 0.0 | math.inf | False | True | False | False | True | True | False |
| Python | 0.0 | -math.inf | False | True | True | True | False | False | False |
| Python | math.nan | -0.0 | False | True | False | False | False | False | False |
| Python | math.nan | 0.0 | False | True | False | False | False | False | False |
| Python | math.nan | math.nan | False | True | False | False | False | False | True |
| Python | math.nan | -math.nan | False | True | False | False | False | False | False |
| Python | math.nan | math.inf | False | True | False | False | False | False | False |
| Python | math.nan | -math.inf | False | True | False | False | False | False | False |
| Python | -math.nan | -0.0 | False | True | False | False | False | False | False |
| Python | -math.nan | 0.0 | False | True | False | False | False | False | False |
| Python | -math.nan | math.nan | False | True | False | False | False | False | False |
| Python | -math.nan | -math.nan | False | True | False | False | False | False | True |
| Python | -math.nan | math.inf | False | True | False | False | False | False | False |
| Python | -math.nan | -math.inf | False | True | False | False | False | False | False |
| Python | math.inf | -0.0 | False | True | True | True | False | False | False |
| Python | math.inf | 0.0 | False | True | True | True | False | False | False |
| Python | math.inf | math.nan | False | True | False | False | False | False | False |
| Python | math.inf | -math.nan | False | True | False | False | False | False | False |
| Python | math.inf | math.inf | True | False | False | True | False | True | True |
| Python | math.inf | -math.inf | False | True | True | True | False | False | False |
| Python | -math.inf | -0.0 | False | True | False | False | True | True | False |
| Python | -math.inf | 0.0 | False | True | False | False | True | True | False |
| Python | -math.inf | math.nan | False | True | False | False | False | False | False |
| Python | -math.inf | -math.nan | False | True | False | False | False | False | False |
| Python | -math.inf | math.inf | False | True | False | False | True | True | False |
| Python | -math.inf | -math.inf | True | False | False | True | False | True | True |


