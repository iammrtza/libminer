# R Library Summary

Provides a brief summary of the package libraries on your machine

## Usage

``` r
lib_summary(sizes = FALSE)
```

## Arguments

- sizes:

  Logical; if `TRUE`, also compute the total size on disk (in bytes) of
  the packages in each library. Defaults to `FALSE`.

## Value

A `data.frame` containing the count of packages in each of the user's
libraries, and optionally the total size on disk

## Examples

``` r
lib_summary()
#>                           Library n_packages
#> 1 /home/runner/work/_temp/Library         67
#> 2      /opt/R/4.6.1/lib/R/library         29
#> 3 /opt/R/4.6.1/lib/R/site-library          1
lib_summary(sizes = TRUE)
#>                           Library n_packages lib_size
#> 1 /home/runner/work/_temp/Library         67   73.35M
#> 2      /opt/R/4.6.1/lib/R/library         29   73.56M
#> 3 /opt/R/4.6.1/lib/R/site-library          1   19.01M
```
