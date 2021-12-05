# `runner` an R package for running operations.


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
