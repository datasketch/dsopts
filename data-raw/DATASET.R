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
standard_hdtypes <- c("Cat", "Num", "Txt", "Chk", "Img", "Seq")

non_standard_hdtypes <- hdtypes[!hdtypes %in% standard_hdtypes]
non_standard_hdtypes

# Temp solution: non_standard_hdtypes as Txt
opts <- opts |>
  mutate(hdtype = if_else(hdtype %in% non_standard_hdtypes, "Txt", hdtype))


opts$default[opts$default == "NULL"] <- NA
default <- opts |>
  select(name, default, hdtype, condition)

## Todo
# Install fonts locally if not available. Define hdtype vectors

l <- transpose(default)
l <- map(l, function(op){
  #op <- l[[1]]
  hdtype <- op$hdtype
  opt <- list()
  default <- do.call(hdtype, list(op$default))
  opt$default <- hdtype::as_basetype(default)
  opt$condition <- op$condition
  opt

}) |> set_names(default$name)



# Opt categories
categories <- opts |>
  select(category, name) |>
  unnest(category) |>
  arrange(category)

cats <- categories |>
  group_split(category) |>
  map(~.$name)

cats_keys <- categories |>
  group_by(category) |>
  group_keys() |>
  pull(category)
cats <- cats |> set_names(cats_keys)



usethis::use_data(DATASET, overwrite = TRUE)
