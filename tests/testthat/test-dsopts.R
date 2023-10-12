test_that("Options", {

  expect_equal(length(dsopts_available()), nrow(dsopts::options))

  expect_equal(dsopts_available("map"), names(dsopts_default("map")))

  expect_equal(length(dsopts::options$name),
              length(unique(dsopts::options$name)))

  categories <- c("dataprep")
  opts <- dsopts_default(categories = categories)

  expect_true(all(purrr::map_lgl(dstools::removeNulls(opts), ~ !is.na(.))))


  category <- "map"
  dsopts_default("map")

  opt <- "animation_duration"
  dsopt_default(opt)

})

test_that("Merge", {


  ###

  opts_custom <- dsopts_merge(agg = "SUMA", sort = NA, categories = "dataprep")
  expect_null(opts_custom$sort)

  expect_equal(opts_custom$agg, "SUMA")

  opts <- list(
    agg = "SUMA",
    sort = NA
  )
  opts_custom <- dsopts_merge(opts = opts, categories = "dataprep")
  expect_equal(opts_custom$agg, "SUMA")
  expect_null(opts_custom$sort)





  ###

  dsopts_merge(opacity = 0, categories = "map")

  m1 <- dsopts_merge(opacity = 0)
  m2 <- dsopts_merge(opts = list(opacity = 0))
  expect_equal(m1$opacity, m2$opacity)

  myopts <- list(title = "Hello", a = "AAA", b = "BBB")

  expect_error(dsopts_merge(opts = myopts))
  # "Undefined dsoption: a, b. See dsopts_available(category)"

  myfun <- function(x, ...){
    opts <- dsopts_merge(...)
    opts
  }

  expect_error(myfun(a = 0))


  myfun_opts <- myfun(x = 0, agg = "MyAgg")
  # expect_true(is_flat_list(myfun_opts))
  expect_equal(myfun_opts$agg,"MyAgg")



  o1 <- list(tooltip_template = "TPL")
  o2 <- dsopts_merge(opts = o1)
  expect_equal(o2$tooltip_template, o1$tooltip_template)


  ## Merge with fun and categories

  myfun_map <- function(x, ...){
    opts <- dsopts_merge(..., categories = "map")
    opts
  }

  opts_map <- myfun_map(background_color = 0)
  expect_equal(opts_map$background_color, 0)



})


test_that("Filter options", {

  categories <- c("map", "bubbles")
  expect_error(dsopts_filter_categories(categories),
               "Category not available: bubbles. See dsopts_categories()")

  categories <- c("map", "bubble")

  all_opt_cat <- dsopts_filter_categories(categories, type = "all_of")
  any_opt_cat <- dsopts_filter_categories(categories, type = "any_of")
  expect_true(length(all_opt_cat) < length(any_opt_cat))



  # dsopts_data()
  # dsopts_legend()
  # dsopts_maps()


})



