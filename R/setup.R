# book-specific code to include on every page
library(stats) # prevents dplyr::filter problem

if (requireNamespace("glossary", quietly = TRUE)) {
  suppressPackageStartupMessages({
    library(glossary)
  })
  glossary_reset()
  glossary_path("psyteachr")
  glossary_popup("hover")
}

if (requireNamespace("webexercises", quietly = TRUE)) {
  suppressPackageStartupMessages({
    library(webexercises)
  })
}

# default knitr options
if (requireNamespace("knitr", quietly = TRUE)) {
  knitr::opts_chunk$set(
    echo       = TRUE,
    warning    = FALSE,
    message    = FALSE,
    results    = "hold",
    out.width  = '100%',
    fig.width  = 8,
    fig.height = 8,
    fig.align  = 'center',
    digits = 3
  )
}

glossary_table <- function(as_kable = TRUE) {
  glossary <- glossary_options("table")
  if (is.null(glossary))
    glossary <- list()
  term <- names(glossary)
  linked_term <- term
  if (!is.null(glossary_path()) && glossary_path() == "psyteachr") {
    lcterm <- gsub(" ", "-", tolower(term), fixed = TRUE)
    first_letter <- substr(lcterm, 1, 1)
    linked_term <- paste0(" [", lcterm, "](https://psyteachr.github.io/glossary/",
                          first_letter, "#", lcterm, "){target='_blank' class='glossary'} ")
  }
  if (is.null(term)) {
    data.frame()
  } else if (as_kable) {
    the_list <- data.frame(term = linked_term, definition = unlist(glossary))
    knitr::kable(the_list[order(term), ],
                 escape = FALSE,
                 row.names = FALSE, )
  } else {
    the_list <- data.frame(term = term, definition = unlist(glossary))
    the_list[order(term), ]
  }
}
