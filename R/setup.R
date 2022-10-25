# book-specific code to include on every page

# devtools::install_github("psyteachr/glossary)
library(glossary)
glossary::reset_glossary()

# default knitr options
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

suppressPackageStartupMessages({
  library(webexercises)
})

knitr::knit_hooks$set(webex.hide = function(before, options, envir) {
  if (before) {
    if (is.character(options$webex.hide)) {
      hide(options$webex.hide)
    } else {
      hide()
    }
  } else {
    unhide()
  }
})
