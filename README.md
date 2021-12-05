# `ie` short hand if-else.

# Motivation

Reason to create this package is to simplify code to check the object and replace
if it does not match some expectations. Following code illustrates typical 
situation when x needs to be included in the call twice.
```r
# basic syntax
if (fun(x)) x else y
```

Real case might look much different where `x` might be a more complicated call.
```r
# possible case 
x <- seq_len(3)
if (identical(x[x %% 2 != 0], integer(0))) x[x %% 2 != 0] else 1L
```

`ie` package simplifies the above with requirement to include `x` only once in 
the call. The more complex `x` in the call the bigger benefit to apply `ie` 
function.  
```r
ie(identical, x[x %% 2 != 0], integer(0), 1L)
```

`ie` works as follows, first argument (`fun`) is function which should return a 
single logical value. Second argument is considered as a positive-replacement 
which is returned if function returns `TRUE`. `.else` is a negative-replacement, 
returned when function returns `FALSE`

![](man/figures/ie_uml.jpg)

Single example
```r
ie(is.null, NULL, 1L)
# NULL

nie(is.null, NULL, 1L)
# [1] 1
```

Multiple arguments examples
```r
# if-else
ie(grepl, x = "some text", pattern = "word", .else = "does not contain a word")
# [1] "doesn't contain a word"

# negative if-else
nie(grepl, x = "some text", pattern = "word", .else = "does not contain a word")
# [1] "some text"
```
