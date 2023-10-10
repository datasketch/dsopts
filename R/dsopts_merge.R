
#' Merge Default and User-Defined Options
#'
#' This function merges user-defined options with the default options from the `dsopts` package.
#' If a category is specified, only options from that category are considered.
#' User-defined options overwrite the default ones.
#'
#' @param ... User-defined options to merge with the defaults.
#' @param category A character string specifying the category of options to merge.
#' If NULL (the default), all categories are considered.
#'
#' @return A named list of merged options. If a category is specified, only options
#' from that category are returned.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Assuming 'my_option' as a valid option name and 'my_category' as a valid option category
#' merged_opts <- dsopts_merge(my_option = 'my_value', category = 'my_category')
#' }
dsopts_merge <- function(..., categories = NULL){
  args <- list(...)
  # str(args)
  if(length(args) > 0){
    nms_opts <- c(names(args)[names(args) != "opts"],
                  names(args$opts))
    if(!all( nms_opts %in% dsopts_available())){
      not_in <- dstools::which_not_in(nms_opts,dsopts_available())
      stop("Undefined dsoption: ", dstools::collapse(not_in),
           ". See dsopts_available(category)")
    }
  }
  opts_list <- args$opts

  str(opts_list$tooltip_template)

  args$opts <- NULL
  defaults <- dsopts_default(categories = categories)

  str(defaults$tooltip_template)

  args_opts <- modifyList(args, opts_list %||% list(), keep.null = TRUE)

  str(args_opts$tooltip_template)

  opts <- modifyList(defaults, args_opts, keep.null = TRUE)
  opts
}



