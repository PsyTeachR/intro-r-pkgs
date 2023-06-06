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
