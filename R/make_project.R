# This creates a new project folder structure.
# This function will be called when the user invokes
# the New Project wizard using the project template defined in the template file
# at:
#
#   inst/rstudio/templates/project/make_project.dcf
#
# The function itself just echos its inputs and outputs to a file called INDEX,
# which is then opened by RStudio when the new project is opened.
make_project <- function(path, ...) {

  if (dir.exists(path)){
    stop("Directory already exists", call. = FALSE)
  }

  # create project directory
  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  # sub folders
  folders = c("Figures", "Data", "Data_raw", "Code", "Reports",
              "Documentation", "Output")

  # create sub directories
  for (i in folders){
    dir.create(paste(path, i, sep= "/"))
  }

  # create README.md
  today <- Sys.Date()
  project <- basename(path)
  txt <- paste(c(
    paste("# Project:", project,"\n"),
    "## Authors:",
    "List project participants and their contact info.\n",
    " * Leo Thomas <lthomas@wesleyan.edu>",
    " * Yhusuan Zhang <yzhang@wesleyan.edu>\n",
    paste("## Date:", format(today, format="%B %d, %Y"), "\n"),
    "## Purpose:",
    "Describe the purpose of this project. What are the goals?\n",
    "## Data Sources:",
    "Describe the data source, including web links were appropriate.\n",
    "## Stakeholders:",
    "List all stakeholders and clients, their contact info, and roles.\n",
    " * Magda Withers <mwithers@wesleyan.edu> (professor)",
    " * Clair Lieb <clieb@vitaminsr.com> (CEO Vitamins R Us)\n",
    "## Milestones:",
    "List all major due dates:\n",
    " * First project team meeting (date)",
    " * Project proposal due (date)",
    " * Data analyses completed (date)",
    " * Presentation prepared (date)",
    " * Report completed (date)"
  ), collapse = "\n")
  cat(txt, file = paste(path, "README.md", sep="/"))

  # create INSTRUCTIONS
  txt <-
"INSTRUCTIONS

The QAC Project Skeleton is provided to help you organize your
research projects and enhance research reproducability.

Fill out the README.md file, then use the folders as indicated below.

===============
Data_raw Folder
===============

Place your original data files in this folder.
Treat this as a read-only folder.
All revised/modified data should go in the Data folder.

===========
Data Folder
===========

Place your processed data files in this folder.
ALL data modifications should be performed within a script
(this step is vital for reproducability).

====================
Documentation Folder
====================

Place project documentation in this folder. This may including
* project proposal
* codebook
* questionnaires (if data gathered by survey)
* any links (URLs) to information about the dataset
* relevant correspondece
* any other useful information

========
Code Folder
========

Place your R code (scripts and/or notebooks) in this folder.

Number them sequentially in the order they should be run
to recreate all the analyses and results in your study.

eg.    01dataprep.R
       02analyses.R
       ...

Be consistent in style and naming conventions.
See the tidyverse style guide (https://style.tidyverse.org/index.html)
or the Google style guide (https://google.github.io/styleguide/Rguide.html)

==============
Figures Folder
==============

Place all publication-ready plots and images in this folder.

=============
Output Folder
=============

This is a place to store analysis results. If you are using R notebooks,
store your html files here. If your programs create models that take
a long time to calculate, store the models here.

==============
Reports Folder
==============

Store
* reports
* manuscripts
* slide presenations.


Additional Steps:
================
You may want to place your project under version control.
If you did not specify this at project creation, select
Tools > Project Options > Git/SVN  and set Version control to Git.
See 'Happy Git with R' (https://happygitwithr.com/) for more details.

To learn more about reproducable research, see
'A Beginner's Guide to Conducting Reproducible Research'
(https://esajournals.onlinelibrary.wiley.com/doi/full/10.1002/bes2.1801)
"

  cat(txt, file = paste(path, "INSTRUCTIONS.txt", sep="/"))

  dots <- list(...)
  if(dots$git){
    if (system("git --version") == 0){
      git2r::init(path)
    } else {
      print("git not installed")
    }
  }

}


