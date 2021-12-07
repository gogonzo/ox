# `ox` short hand if-else.

# <img src="man/figures/logo.jpg" align="right" />

<!-- badges: start -->
[![Check and deploy](https://github.com/gogonzo/ox/workflows/Check%20and%20deploy/badge.svg)](https://github.com/gogonzo/ox/actions)
[![](https://ci.appveyor.com/api/projects/status/github/gogonzo/ox?branch=master&svg=true)](https://ci.appveyor.com/project/gogonzo/ox)
[![](https://codecov.io/gh/gogonzo/ox/branch/main/graph/badge.svg)](https://codecov.io/gh/gogonzo/ox/branch/main)
<!-- badges: end -->

### Name

Symbolically, letter "O" and letter "X" represents opposite characteristics. 
Usually, "O" is associated with something positive while "X" symbolizes rejection.
This summarizes the meaning of the `ox::ox` which manages switching two values 
based on the TRUE/FALSE condition.

### Motivation

Reason to create this package is to simplify the code to check and replace the 
object if it does not satisfy given assumptions. Following code illustrates
typical situation when `x` is checked (possibly against `y`) to return `x` 
or `y`.
```r
# basic syntax
if (is.fun(x)) x else y
if (fun(x, y, ...)) x else y
```

`ox` package offers a different syntax for above base R calls, where `x` and
`y` can be used once in the call to produce the same output.
```r
ox(fun, x, .else = y)
ox(fun, x, y)
```

### `ox` syntax

`ox` has four arguments: 
- `.f`  a function which returns a single logical value.
- `...` named or unnamed arguments to be passed to `.f(...)` to evaluate.
- `.then` is a positive-replacement, returned when `.f` returns `TRUE`. 
By default, it's the first argument from `...`.
- `.elselse` is a negative-replacement, returned when `.f` returns `FALSE`.
By default, it's the last argument from `...`.

![](man/figures/uml1.jpg)

Consider simple where `x` checked if it's a character. If condition is `TRUE`
`ox` returns `x` (`.then`) otherwise `.else`. Since `.then` has not been 
specified directly `object = x` is considered as a default value to return when
`.f` returns `TRUE`. In this example `x` is a argument of `.f` and is returned
as `.then` in the same time.

```r
x <- "a"
y <- "b"

ox(.f = is, object = x, class2 = "character", .else = "b")
# [1] "a"
```

Another example illustrates the comparison between two values and return one 
matching the condition. In this case `y` is greater than `x` so it's returned.
Both `x` and `y` are used in the function and returned as `.then` and `.else` in
the same time.
```r
x <- 1
y <- 2

ox(`>`, x, y)
# [1] 2
```

### pipe operators
Syntax is also optimized to use pipe operators. For `magrittr::%>%` it's very 
convenient as one can use `.`. With `|>` one needs to specify `.f = <fun>` and 
`x` will go to the `ox` as first argument.
```r
library(magrittr)
x <- 4

x %>% ox(.f = `>`, 5)
# [1] 5

x %>% ox(`>`, ., 5)
# [1] 5

x |> ox(.f = `>`, 5)
# [1] 5
```

# vectorized `OX`
Instead of replacing `x` with some specific object one can also replace values
of the `x` for elements of the `x` matching a condition
```r
x <- c(NA, 1, NA)
y <- c(1, 2, 3)

# equivalent
x <- XO(is.na, x, .else = y)
```
![](man/figures/uml2.jpg)
