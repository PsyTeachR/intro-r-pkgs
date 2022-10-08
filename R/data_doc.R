#' Create data documentation
#'
#' @param data the dataset
#' @param filename the file to save the documentation to (outputs text if NULL)
#' @param title The title of the dataset
#' @param description The description of the dataset
#' @param vars A named list or vector of the column descriptions
#' @param data_URL The URL for the data source
#' @param dataname The name of the data (taken from the data argument if not set)
#'
#' @return Saves to file or text output
#' @export
#'
#' @examples
#' data_doc(iris)
#'
#' # define some, but not all columns
#' data_doc(iris, vars = c(Sepal.Length = "Length of Sepal"))
data_doc <- function(data,
                     filename = NULL,
                     title = "Data Title",
                     description = "Data Description",
                     vars = list(),
                     data_URL = "",
                     dataname = NULL) {
  nrow <- nrow(data)
  ncol <- ncol(data)
  if (is.null(dataname)) dataname <- deparse(substitute(data))

  cnames <- colnames(data)
  if (!length(vars)) vars <- cnames
  if (is.null(names(vars))) names(vars) <- cnames
  # check for missing vars
  defined_names <- intersect(cnames, names(vars))
  undefined_names <- setdiff(cnames, names(vars))
  vars <- setNames(c(vars[defined_names], undefined_names),
                   c(defined_names, undefined_names))
  vars <- vars[cnames] # ensure in same order as data

  if (length(undefined_names)) {
    message("These columns were not defined: ", paste(undefined_names, collapse = ", "))
  }

  items <- glue::glue("#'   \\item{[colname]}{[coldesc]}",
             colname = names(vars),
             coldesc = vars,
             .open = "[",
             .close = "]")
  items <- paste(items, collapse = "\n")

  doc <- glue::glue(.open = '[', .close = ']',
     "#' [title].\n",
     "#' \n",
     "#' [description]\n",
     "#' \n",
     "#' @format A data frame with [nrow] rows and [ncol] variables:\n",
     "#' \\describe{\n",
     '[items]\n',
     "#' }\n",
     "#' @source \\url{[data_URL]}\n",
     "\"[dataname]\""
  )

  if (is.null(filename)) {
    cat(doc)
  } else if (file.exists(filename)) {
    old_file_contents <- readLines(filename)
    write(c(old_file_contents, "\n\n", doc), filename)
    message("Documentation appended to ", filename)
  } else {
    write(doc, filename)
    message("Documentation written to ", filename)
  }
}



