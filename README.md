# test-numerical-comparisons
Look at numerical comparisons in different languages so that they can be compared against IEEE754.

## IEEE754

Details of IEEE754 can be found at [IEEE754](https://en.wikipedia.org/wiki/IEEE_754).

Notes:
1. [NaN comparisons are unordered](https://en.wikipedia.org/wiki/IEEE_754#Comparison_predicates)
2. [`-0.0` and `0.0` are equal](https://en.wikipedia.org/wiki/IEEE_754#Comparison_predicates)
3. [`-0.0` is less than `0.0`](https://en.wikipedia.org/wiki/IEEE_754#Total-ordering_predicate)
4. [`-NaN < -Inf` and `+Inf < +NaN`](https://en.wikipedia.org/wiki/IEEE_754#Total-ordering_predicate)
5. [`min(+0.0, -0.0) = min(-0.0, +0.0) = -0.0 or 0.0`](https://en.wikipedia.org/wiki/IEEE_754-2008_revision#Min_and_max)
6. [`max(+0.0, -0.0) = max(-0.0, +0.0) = +0.0 or 0.0`](https://en.wikipedia.org/wiki/IEEE_754-2008_revision#Min_and_max)
7. [The result of `min(x, NaN)` or `max(x, NaN)` may vary depending on the IEEE754 revision.](https://en.wikipedia.org/wiki/IEEE_754-2008_revision#Min_and_max)
8. [There are quiet and signaling NaNs.  For our langagues, quiet NaNs are used.](https://en.wikipedia.org/wiki/IEEE_754#NaNs)

## Java

> :warning: **WARNING:** Java does not support IEE754 `-NaN`.  All NaNs are treated as positive.

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

| lang   | v1 | v2 | == | != | > | >= | < | <= | hashCode== |
|--- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
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

# Deephaven

> :warning: **WARNING:** The Deephaven UI seems to be strange with how it displays zeros.  Both plus and 
> minus zero are represented as `-0.0`.  Note the comparison results in this screenshot.
> ![Deephaven](assets/deephaven_ui_zeros.png)

|   v1 |   v2 | Eq    | Ne    | Gt    | Ge    | Lt    | Le    | Hc    |
|-----:|-----:|:------|:------|:------|:------|:------|:------|:------|
|   -0 |   -0 | True  | False | False | True  | False | True  | True  |
|   -0 |    0 | True  | False | False | False | True  | True  | False |
|   -0 |  nan | False | True  | False | False | True  | True  | False |
|   -0 |  nan | False | True  | False | False | True  | True  | False |
|   -0 |  inf | False | True  | False | False | True  | True  | False |
|   -0 | -inf | False | True  | True  | True  | False | False | False |
|    0 |   -0 | True  | False | True  | True  | False | False | False |
|    0 |    0 | True  | False | False | True  | False | True  | True  |
|    0 |  nan | False | True  | False | False | True  | True  | False |
|    0 |  nan | False | True  | False | False | True  | True  | False |
|    0 |  inf | False | True  | False | False | True  | True  | False |
|    0 | -inf | False | True  | True  | True  | False | False | False |
|  nan |   -0 | False | True  | True  | True  | False | False | False |
|  nan |    0 | False | True  | True  | True  | False | False | False |
|  nan |  nan | False | True  | False | True  | False | True  | True  |
|  nan |  nan | False | True  | False | True  | False | True  | True  |
|  nan |  inf | False | True  | True  | True  | False | False | False |
|  nan | -inf | False | True  | True  | True  | False | False | False |
|  nan |   -0 | False | True  | True  | True  | False | False | False |
|  nan |    0 | False | True  | True  | True  | False | False | False |
|  nan |  nan | False | True  | False | True  | False | True  | True  |
|  nan |  nan | False | True  | False | True  | False | True  | True  |
|  nan |  inf | False | True  | True  | True  | False | False | False |
|  nan | -inf | False | True  | True  | True  | False | False | False |
|  inf |   -0 | False | True  | True  | True  | False | False | False |
|  inf |    0 | False | True  | True  | True  | False | False | False |
|  inf |  nan | False | True  | False | False | True  | True  | False |
|  inf |  nan | False | True  | False | False | True  | True  | False |
|  inf |  inf | True  | False | False | True  | False | True  | True  |
|  inf | -inf | False | True  | True  | True  | False | False | False |
| -inf |   -0 | False | True  | False | False | True  | True  | False |
| -inf |    0 | False | True  | False | False | True  | True  | False |
| -inf |  nan | False | True  | False | False | True  | True  | False |
| -inf |  nan | False | True  | False | False | True  | True  | False |
| -inf |  inf | False | True  | False | False | True  | True  | False |
| -inf | -inf | True  | False | False | True  | False | True  | True  |

