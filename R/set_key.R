# Character key of an index set
set_key <- function(J) {
  if (length(J) == 0) return("{}")
  paste(sort(J), collapse = ",")
}

