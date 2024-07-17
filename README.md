# test-numerical-comparisons

A look at numerical comparisons in different languages to determine how a quant analytics platform should behave.
In specific, this repo is looking at equality, ordering, and hashing of unusual floating point numbers
in different programming languages used for numerical computing.

## TL;DR

1. Types of equality:
    1. **Value equality:** Compare the mathematical value of two numbers.
    2. **Object identity:** Compare the object identity of two numbers.
    3. **Bitwise equality:** Compare the bitwise representation of two numbers.
2. Contexts to consider:
    1. **Equality:** `==`, `!=`, `isequal`, `===`
    2. **Ordering:** `<`, `<=`, `>`, `>=` 
    3. **Sorting:** `sort`
    4. **Hashing:** `hashCode`
    5. **Uniquing:** `unique`
    6. **Filtering:** `where`
    7. **UI:** How the UI displays the numbers. 

Things to consider:
1. Mathematical users expect value equality.  e.g. `-0.0` and `0.0` are equal.
1. For stable sorts, value and bitwise equality produce different sort orders.  Math users probably expect value equality.
1. For grouping and hashing, math users expect value equality.  They would be very surprised if `-0.0` and `0.0` were treated as different key values.
1. For uniquing, math users expect value equality.  They would be very surprised if both `-0.0` and `0.0` were in the unique set.
1. For filtering, math users expect value equality.  They would be very surprised if `X == 0.0` did not return `-0.0` values.
1. A UI, should display either display (1) both `-0.0` and `0.0` or (2) only `0.0`.  It should not display them both as `-0.0`.
1. The value of NaN is indeterminate.  For example, is `sqrt(-1) > 0/0`?  As a result, NaN vs NaN comparisons are unordered (e.g. `NaN == NaN` is false, `NaN > NaN` is false).
1. For stable sorts, if NaNs are not treated as equal to themselves, the sort order will be unstable.
1. For grouping and hashing, mathematical users would expect NaNs to be treated as equal to themselves so that they can be used as a key when grouping.
1. For uniquing, mathematical users would expect NaNs to be treated as equal to themselves and not appear multiple times in the unique set.
1. For filtering, mathematical users would expect NaNs to be treated as equal to themselves so that matching values are returned.
1. IEEE754 specifies `+NaN` and `-NaN`.  Java does not support `-NaN`, and all NaNs are treated as positive.
6. 

## IEEE754

Details of IEEE754 can be found on [Wikipedia](https://en.wikipedia.org/wiki/IEEE_754).

1. [NaN comparisons are unordered](https://en.wikipedia.org/wiki/IEEE_754#Comparison_predicates)
2. [`-0.0` and `0.0` are equal](https://en.wikipedia.org/wiki/IEEE_754#Comparison_predicates)
3. [`-0.0` is less than `0.0`](https://en.wikipedia.org/wiki/IEEE_754#Total-ordering_predicate)
4. [`-NaN < -Inf` and `+Inf < +NaN`](https://en.wikipedia.org/wiki/IEEE_754#Total-ordering_predicate)
5. [`min(+0.0, -0.0) = min(-0.0, +0.0) = -0.0 or 0.0`](https://en.wikipedia.org/wiki/IEEE_754-2008_revision#Min_and_max)
6. [`max(+0.0, -0.0) = max(-0.0, +0.0) = +0.0 or 0.0`](https://en.wikipedia.org/wiki/IEEE_754-2008_revision#Min_and_max)
7. [The result of `min(x, NaN)` or `max(x, NaN)` may vary depending on the IEEE754 revision.](https://en.wikipedia.org/wiki/IEEE_754-2008_revision#Min_and_max)
8. [There are quiet and signaling NaNs.  For our langagues, quiet NaNs are used.](https://en.wikipedia.org/wiki/IEEE_754#NaNs)

### Why are NaN values not equal in IEEE754?

> **NOTE:** AI summary.

NaN (Not a Number) values are not equal to themselves or any other value in IEEE 754 floating-point arithmetic for 
several important reasons:

1. **Representation of undefined operations:** NaN is used to represent the result of undefined mathematical operations like 0/0 or sqrt(-1). Since these operations don't have a well-defined numerical result, it wouldn't make sense for NaNs resulting from different undefined operations to be considered equal.
2. **Propagation of errors:** The inequality of NaN to itself allows errors to propagate through calculations. If a NaN is produced at any step, comparing it to other values (including itself) will always return false, helping to identify and track error conditions.
3. **Multiple NaN representations:** There are actually many different bit patterns that can represent NaN in IEEE 754. While they all indicate an invalid or undefined result, they can carry different information about the specific operation that produced them.
4. **Consistency with other comparisons:** Since NaN is considered unordered with respect to all other floating-point values (including itself), having NaN == NaN be false maintains consistency with other comparison operations involving NaN.
5. **Special handling in algorithms:** The behavior of NaN in comparisons allows for special handling in sorting and other algorithms. For example, it ensures that NaNs are treated as distinct values for sorting, uniquing, and hashing purposes.

## Java

> :warning: **WARNING:** Java does not support IEE754 `-NaN`.  All NaNs are treated as positive.

> **NOTE:** `equals` is using [`Double.equals`](https://docs.oracle.com/javase/8/docs/api/java/lang/Double.html#equals-java.lang.Object-).

:warning: **WARNING:** **[`Double.equals`](https://docs.oracle.com/javase/8/docs/api/java/lang/Double.html#equals-java.lang.Object-) does not test for value equality**.  If `d1` and `d2` both represent `Double.NaN`, then the `equals` method returns true, even though `Double.NaN==Double.NaN` has the value false. If `d1` represents `+0.0` while `d2` represents `-0.0`, or vice versa, the `equal` test has the value false, even though `+0.0==-0.0` has the value true.  This method is used by [`Arryas.equals`](https://docs.oracle.com/javase/8/docs/api/java/util/Arrays.html#equals-double:A-double:A-).

:warning: **WARNING:** **[`Double.compareTo`](https://docs.oracle.com/javase/8/docs/api/java/lang/Double.html#compareTo-java.lang.Double-) does not produce a stable sort for `0.0` and `-0.0`.**  `Double.NaN` is considered by this method to be equal to itself and greater than all other double values (including `Double.POSITIVE_INFINITY`). `0.0d` is considered by this method to be greater than `-0.0d`.  This method is used by [`Arrays.sort`](https://docs.oracle.com/javase/8/docs/api/java/util/Arrays.html#sort-double:A-).


| lang | v1 | v2 | == | != | > | >= | < | <= | hashCode== | equals | 
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Java | -0.00 | -0.00 | True | False | False | True | False | True | True | True | 
| Java | -0.00 | 0.00 | True | False | False | True | False | True | False | False | 
| Java | -0.00 | NaN | False | True | False | False | False | False | False | False | 
| Java | -0.00 | NaN | False | True | False | False | False | False | False | False | 
| Java | -0.00 | Infinity | False | True | False | False | True | True | False | False | 
| Java | -0.00 | -Infinity | False | True | True | True | False | False | False | False | 
| Java | 0.00 | -0.00 | True | False | False | True | False | True | False | False | 
| Java | 0.00 | 0.00 | True | False | False | True | False | True | True | True | 
| Java | 0.00 | NaN | False | True | False | False | False | False | False | False | 
| Java | 0.00 | NaN | False | True | False | False | False | False | False | False | 
| Java | 0.00 | Infinity | False | True | False | False | True | True | False | False | 
| Java | 0.00 | -Infinity | False | True | True | True | False | False | False | False | 
| Java | NaN | -0.00 | False | True | False | False | False | False | False | False | 
| Java | NaN | 0.00 | False | True | False | False | False | False | False | False | 
| Java | NaN | NaN | False | True | False | False | False | False | True | True | 
| Java | NaN | NaN | False | True | False | False | False | False | True | True | 
| Java | NaN | Infinity | False | True | False | False | False | False | False | False | 
| Java | NaN | -Infinity | False | True | False | False | False | False | False | False | 
| Java | NaN | -0.00 | False | True | False | False | False | False | False | False | 
| Java | NaN | 0.00 | False | True | False | False | False | False | False | False | 
| Java | NaN | NaN | False | True | False | False | False | False | True | True | 
| Java | NaN | NaN | False | True | False | False | False | False | True | True | 
| Java | NaN | Infinity | False | True | False | False | False | False | False | False | 
| Java | NaN | -Infinity | False | True | False | False | False | False | False | False | 
| Java | Infinity | -0.00 | False | True | True | True | False | False | False | False | 
| Java | Infinity | 0.00 | False | True | True | True | False | False | False | False | 
| Java | Infinity | NaN | False | True | False | False | False | False | False | False | 
| Java | Infinity | NaN | False | True | False | False | False | False | False | False | 
| Java | Infinity | Infinity | True | False | False | True | False | True | True | True | 
| Java | Infinity | -Infinity | False | True | True | True | False | False | False | False | 
| Java | -Infinity | -0.00 | False | True | False | False | True | True | False | False | 
| Java | -Infinity | 0.00 | False | True | False | False | True | True | False | False | 
| Java | -Infinity | NaN | False | True | False | False | False | False | False | False | 
| Java | -Infinity | NaN | False | True | False | False | False | False | False | False | 
| Java | -Infinity | Infinity | False | True | False | False | True | True | False | False | 
| Java | -Infinity | -Infinity | True | False | False | True | False | True | True | True |

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

## R

> **NOTE:** `digest::digest` was used to calculate the hash code for R.

> :warning: **WARNING:** When NaN is involved in an R comparison, the result is `NA`, the R equivalent of `null`.

| lang | v1 | v2 | == | != | > | >= | < | <= | hashCode== | 
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | 
| R | -0.0 | -0.0 | TRUE | FALSE | FALSE | TRUE | FALSE | TRUE | TRUE | 
| R | -0.0 | 0.0 | TRUE | FALSE | FALSE | TRUE | FALSE | TRUE | FALSE | 
| R | -0.0 | NaN | NA | NA | NA | NA | NA | NA | FALSE | 
| R | -0.0 | -NaN | NA | NA | NA | NA | NA | NA | FALSE | 
| R | -0.0 | Inf | FALSE | TRUE | FALSE | FALSE | TRUE | TRUE | FALSE | 
| R | -0.0 | -Inf | FALSE | TRUE | TRUE | TRUE | FALSE | FALSE | FALSE | 
| R | 0.0 | -0.0 | TRUE | FALSE | FALSE | TRUE | FALSE | TRUE | FALSE | 
| R | 0.0 | 0.0 | TRUE | FALSE | FALSE | TRUE | FALSE | TRUE | TRUE | 
| R | 0.0 | NaN | NA | NA | NA | NA | NA | NA | FALSE | 
| R | 0.0 | -NaN | NA | NA | NA | NA | NA | NA | FALSE | 
| R | 0.0 | Inf | FALSE | TRUE | FALSE | FALSE | TRUE | TRUE | FALSE | 
| R | 0.0 | -Inf | FALSE | TRUE | TRUE | TRUE | FALSE | FALSE | FALSE | 
| R | NaN | -0.0 | NA | NA | NA | NA | NA | NA | FALSE | 
| R | NaN | 0.0 | NA | NA | NA | NA | NA | NA | FALSE | 
| R | NaN | NaN | NA | NA | NA | NA | NA | NA | TRUE | 
| R | NaN | -NaN | NA | NA | NA | NA | NA | NA | FALSE | 
| R | NaN | Inf | NA | NA | NA | NA | NA | NA | FALSE | 
| R | NaN | -Inf | NA | NA | NA | NA | NA | NA | FALSE | 
| R | -NaN | -0.0 | NA | NA | NA | NA | NA | NA | FALSE | 
| R | -NaN | 0.0 | NA | NA | NA | NA | NA | NA | FALSE | 
| R | -NaN | NaN | NA | NA | NA | NA | NA | NA | FALSE | 
| R | -NaN | -NaN | NA | NA | NA | NA | NA | NA | TRUE | 
| R | -NaN | Inf | NA | NA | NA | NA | NA | NA | FALSE | 
| R | -NaN | -Inf | NA | NA | NA | NA | NA | NA | FALSE | 
| R | Inf | -0.0 | FALSE | TRUE | TRUE | TRUE | FALSE | FALSE | FALSE | 
| R | Inf | 0.0 | FALSE | TRUE | TRUE | TRUE | FALSE | FALSE | FALSE | 
| R | Inf | NaN | NA | NA | NA | NA | NA | NA | FALSE | 
| R | Inf | -NaN | NA | NA | NA | NA | NA | NA | FALSE | 
| R | Inf | Inf | TRUE | FALSE | FALSE | TRUE | FALSE | TRUE | TRUE | 
| R | Inf | -Inf | FALSE | TRUE | TRUE | TRUE | FALSE | FALSE | FALSE | 
| R | -Inf | -0.0 | FALSE | TRUE | FALSE | FALSE | TRUE | TRUE | FALSE | 
| R | -Inf | 0.0 | FALSE | TRUE | FALSE | FALSE | TRUE | TRUE | FALSE | 
| R | -Inf | NaN | NA | NA | NA | NA | NA | NA | FALSE | 
| R | -Inf | -NaN | NA | NA | NA | NA | NA | NA | FALSE | 
| R | -Inf | Inf | FALSE | TRUE | FALSE | FALSE | TRUE | TRUE | FALSE | 
| R | -Inf | -Inf | TRUE | FALSE | FALSE | TRUE | FALSE | TRUE | TRUE | 

## Julia

> **NOTE:** Julia has `==`, `===`, and `isequal` to compare floating point numbers.
> `==` is used for mathematical value equality, `===` is used for object identity, 
> while `isequal` is used for bitwise equality.

| Julia | v1 | v2 | == | != | > | >= | < | <= | hash== | isequal | === |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Julia | -0.0 | -0.0 | true | false | false | true | false | true | true | true | true |
| Julia | -0.0 | 0.0 | true | false | false | true | false | true | false | false | false |
| Julia | -0.0 | NaN | false | true | false | false | false | false | false | false | false |
| Julia | -0.0 | -NaN | false | true | false | false | false | false | false | false | false |
| Julia | -0.0 | Inf | false | true | false | false | true | true | false | false | false |
| Julia | -0.0 | -Inf | false | true | true | true | false | false | false | false | false |
| Julia | 0.0 | -0.0 | true | false | false | true | false | true | false | false | false |
| Julia | 0.0 | 0.0 | true | false | false | true | false | true | true | true | true |
| Julia | 0.0 | NaN | false | true | false | false | false | false | false | false | false |
| Julia | 0.0 | -NaN | false | true | false | false | false | false | false | false | false |
| Julia | 0.0 | Inf | false | true | false | false | true | true | false | false | false |
| Julia | 0.0 | -Inf | false | true | true | true | false | false | false | false | false |
| Julia | NaN | -0.0 | false | true | false | false | false | false | false | false | false |
| Julia | NaN | 0.0 | false | true | false | false | false | false | false | false | false |
| Julia | NaN | NaN | false | true | false | false | false | false | true | true | true |
| Julia | NaN | -NaN | false | true | false | false | false | false | false | false | false |
| Julia | NaN | Inf | false | true | false | false | false | false | false | false | false |
| Julia | NaN | -Inf | false | true | false | false | false | false | false | false | false |
| Julia | -NaN | -0.0 | false | true | false | false | false | false | false | false | false |
| Julia | -NaN | 0.0 | false | true | false | false | false | false | false | false | false |
| Julia | -NaN | NaN | false | true | false | false | false | false | false | false | false |
| Julia | -NaN | -NaN | false | true | false | false | false | false | true | true | true |
| Julia | -NaN | Inf | false | true | false | false | false | false | false | false | false |
| Julia | -NaN | -Inf | false | true | false | false | false | false | false | false | false |
| Julia | Inf | -0.0 | false | true | true | true | false | false | false | false | false |
| Julia | Inf | 0.0 | false | true | true | true | false | false | false | false | false |
| Julia | Inf | NaN | false | true | false | false | false | false | false | false | false |
| Julia | Inf | -NaN | false | true | false | false | false | false | false | false | false |
| Julia | Inf | Inf | true | false | false | true | false | true | true | true | true |
| Julia | Inf | -Inf | false | true | true | true | false | false | false | false | false |
| Julia | -Inf | -0.0 | false | true | false | false | true | true | false | false | false |
| Julia | -Inf | 0.0 | false | true | false | false | true | true | false | false | false |
| Julia | -Inf | NaN | false | true | false | false | false | false | false | false | false |
| Julia | -Inf | -NaN | false | true | false | false | false | false | false | false | false |
| Julia | -Inf | Inf | false | true | false | false | true | true | false | false | false |
| Julia | -Inf | -Inf | true | false | false | true | false | true | true | true | true |


## Deephaven

> **NOTE:** Version 0.34.3 was used for Deephaven.

> :warning: **WARNING:** The Deephaven UI seems to be strange with how it displays zeros.  Both plus and 
> minus zero are represented as `-0.0`.  Note the comparison results in this screenshot.
> ![Deephaven](assets/deephaven_ui_zeros.png)

> **NOTE:** Deephaven sort order appears to treat `-0.0` and `0.0` as equal.
> ![Deephaven](assets/deephaven_sort_order.png)

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

## KDB

> **NOTE:** KDB was not tested.  Information was obtained via AI search.

> :warning: **WARNING:** KDB does not support IEE754 `-NaN`.  All NaNs are treated as positive.

1. NaN values are equal to each other.
2. Nulls and NaNs are equal.
3. Any non-null value is considered greater than a null or NaN.