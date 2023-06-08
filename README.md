
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dsopts

<!-- badges: start -->
<!-- badges: end -->

The goal of dsopts is to provide the set of options used in datasketch
data visualization and processing packages

## Installation

You can install the development version of dsopts from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("datasketch/dsopts")
```

## Examples

To see all available options use: `dsopts_available()`

``` r
library(dsopts)
## basic example code

# See all available options for a category
dsopts_available("treemap")
#> [1] "treemap_direction"     "treemap_layers"        "treemap_layers_params"
#> [4] "treemap_layout"

# See all available options for a category
dsopts_available("zoom")
#> [1] "map_zoom_delta" "map_zoom_snap"  "x_max"          "y_max"         
#> [5] "zoom_level"     "zoom_max"       "zoom_min"       "zoom_show"

# Can handle multiple categories

# This returns the options with both categories
dsopts_available(c("map", "bubble"))
#> [1] "bubble_max"     "bubble_min"     "bubble_opacity"

# This returns the options with any of categories
dsopts_available(c("map", "bubble"), type = "any_of")
#>  [1] "border_opacity"         "bubble_max"             "bubble_min"            
#>  [4] "bubble_opacity"         "map_bubble_cluster"     "map_graticule"         
#>  [7] "map_graticule_interval" "map_name"               "map_name_layers_params"
#> [10] "map_popup"              "map_projection_params"  "map_zoom_delta"        
#> [13] "map_zoom_snap"          "zoom_level"
```

To get defaults

``` r

dsopts_default(categories = "donut")
#> $donut_width
#> [1] 2
#> 
#> $sort
#> [1] "no"
```

To override defaults

``` r

  dsopts_merge(donut_width = 1, categories = "donut")
#> $donut_width
#> [1] 1
#> 
#> $sort
#> [1] "no"
```

To override defaults with a list of options

``` r

  opts <- list(
    donut_width = 2
  )
  dsopts_merge(donut_width = 1, opts = opts, categories = "donut")
#> $donut_width
#> [1] 2
#> 
#> $sort
#> [1] "no"
```
