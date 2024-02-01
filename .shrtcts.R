#' Open Chat Background Job
#'
#' Keep writing in the source and console windows but loose the insert and new file functionality of Open Chat.
#'
#' @interactive
#' @shortcut Ctrl+C+B
function(){
  chattr:::chattr_app(as_job = TRUE)
}


#' Restart Rstudio
#'
#' Completely restart Rstudio (not just R) so you can do things like reload shrtcts!
#'
#' @interactive
#' @shortcut Shift+Cmd+9
usethis:::restart_rstudio

#' Load fpr for testing changes
#'
#' Save a sec and go
#'
#' @interactive
#' @shortcut Shift+Cmd+-
function(){
  library(conflicted)
  library(fpr)
  library(devtools)
  library(tidyverse)
  library(sf)
}
#' Load devtools
#'
#' Save a sec and go
#'
#' @interactive
#' @shortcut Shift+Cmd+8
function(){
  library(devtools)
  library(tidyverse)
}

# Open Chat Interactive
#'
#' Maintains insert and new file functionality of Open Chat and may be run by different chattr.yml calls...(not sure).
#'
#' @interactive
#' @shortcut Ctrl+Shift+c
function(){
  chattr:::chattr_app()
}
