## code to prepare `DATASET` dataset goes here

library(usethis)
library(dsairtable)
library(tidyverse)
library(hdtype)

at <- at_base(Sys.getenv("AIRTABLE_APP"))
table <- "options"
opts0 <- at_table(at, table)

# unique opts names?
#opts |> distinct(name)
dups <- opts0 |> group_by(name) |> filter(n() > 1) |> pull(name)
if(length(dups) > 0) stop("Duplicated names")
unique(opts0$status)
opts <- opts0 |> filter(status == "ok")
na_hdtype <- opts |> filter(is.na(hdtype))
if(nrow(na_hdtype) > 0) stop("hdtype is NA")

if(any(is.na(opts$default))) stop("NAs found in default")



hdtypes <- unique(opts$hdtype)
standard_hdtypes <- c("Cat", "Num", "Txt", "Chk", "Img", "Seq",
                      "Lst[Clr]")

non_standard_hdtypes <- hdtypes[!hdtypes %in% standard_hdtypes]
non_standard_hdtypes

# Temp solution: non_standard_hdtypes as Txt
opts <- opts |>
  mutate(hdtype = if_else(hdtype %in% non_standard_hdtypes, "Txt", hdtype))


opts$default[opts$default == "NULL"] <- NA
opts2 <- opts |>
  select(name, default, hdtype, condition, category) |>
  arrange(name)
options <- opts2


## Todo
# Install fonts locally if not available. Define hdtype vectors

lst_clr <- function(dflt){
  # op <- l[[52]]
  # dflt <- op$default
  str_split(dflt, ", ")[[1]]
}


l <- transpose(options)
default <- map(l, function(op){
  #op <- l[[52]]
  hdtype <- op$hdtype
  if(hdtype == "Lst[Clr]")
    hdtype <- "lst_clr"
  opt <- list()
  default <- do.call(hdtype, list(op$default))
  opt$default <- hdtype::as_basetype(default)
  opt$condition <- op$condition
  opt
}) |> set_names(options$name)



# Opt categories
cats_df <- opts |>
  select(category, name) |>
  unnest(category) |>
  arrange(category)

cats <- cats_df |>
  group_split(category) |>
  map(~.$name)

cats_keys <- cats_df |>
  group_by(category) |>
  group_keys() |>
  pull(category)
categories <- cats |> set_names(cats_keys)




usethis::use_data(default, categories, options,
                  overwrite = TRUE, internal = FALSE)



