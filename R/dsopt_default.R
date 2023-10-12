
#' Retrieve Default Options for a Specific Category
#'
#' This function retrieves default options from the `dsopts` package for a specific category.
#' If no category is specified, it returns the default options for all categories.
#'
#' @param categories A character string specifying the category of options to retrieve.
#' If NULL (the default), all categories are considered.
#' @param type all_of or any_of when multiples categories are provided
#'
#' @return A named list of default options. If a category is specified, only options
#' from that category are returned.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Assuming 'category' as a valid option category
#' default_opts <- dsopts_default(category = 'my_category')
#' }
dsopts_default <- function(categories = NULL, type = "all_of"){

  opts <- dsopts::default
  nms <- names(opts)
  if(!is.null(categories)){
    if(!all(categories %in% dsopts_categories()))
      stop("Category not available. See `dsopts_categories`")
    opt_names <- dsopts_filter_categories(categories, type = type)
    opts <- opts[opt_names]
    nms <- names(opts)
  }
  opts <- purrr::map(opts, ~.$default) |>
    purrr::set_names(nms)

  # NAs to NULL
  lapply(opts, function(x){
    if(all(is.na(x))) return(NULL)
    x
  })
}


#' Retrieve Default Option
#'
#' This function retrieves the default value for a specified option from the `dsopts` package.
#'
#' @param opt A character string specifying the name of the option whose default value is to be retrieved.
#'
#' @return The default value of the specified option. If the option does not exist, returns NULL.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Assuming 'my_option' as a valid option name
#' default_opt <- dsopt_default(opt = 'my_option')
#' }
dsopt_default <- function(opt){
  opts <- dsopts_default()
  opts[[opt]]
}


#' Retrieve Available Options
#'
#' This function retrieves the available options from the `dsopts` package,
#' optionally filtered by specified categories.
#'
#' @param categories A vector of character strings specifying the categories of
#' options to retrieve. If NULL (the default), all categories are considered.
#' @param type A character string specifying the type of filter to apply when
#' categories are specified. Default is "all_of".
#'
#' @return A sorted vector of names of available options. If categories are
#' specified, only options from those categories are returned.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Assuming 'my_category' as a valid option category
#' available_opts <- dsopts_available(categories = 'my_category')
#' }
dsopts_available <- function(categories = NULL, type = "all_of"){
  opts <- dsopts::options
  if(is.null(categories)){
    opt_names <- sort(opts$name)
  }
  if(!is.null(categories)){
    if(!all(categories %in% dsopts_categories()))
      stop("Category not available. See `dsopts_categories`")
    opt_names <- dsopts_filter_categories(categories = categories, type = type)
  }
  sort(opt_names)
}




dsopts_filter_categories <- function(categories = NULL, type = "all_of"){
  opts <- dsopts::options
  if(!is.null(categories)){
    if(!all(categories %in% dsopts_categories())){
      not_in <- dstools::which_not_in(categories,dsopts_categories())
      stop("Category not available: ", dstools::collapse(not_in),
           ". See dsopts_categories()")
    }
    opts <- opts |>
      tidyr::unnest(category) |>
      dplyr::filter(category == categories)
    if(type == "all_of"){
      opts <- opts |>
        dplyr::group_by(name) |>
        dplyr::filter(dplyr::n() >= length(categories))
    }
  }
  sort(unique(opts$name))
}


dsopts_categories <- function(){
  unique(unlist(dsopts::options$category))
}
