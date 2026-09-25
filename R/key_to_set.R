# Index set from its character key
key_to_set <- function(key) {
  if (key %in% c("", "{}")) return(integer(0))
  as.integer(strsplit(key, ",", fixed = TRUE)[[1]])
}

