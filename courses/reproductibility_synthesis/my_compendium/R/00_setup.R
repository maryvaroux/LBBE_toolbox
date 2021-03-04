#################################################
# 
# 
#    __  ___                                       ___          
#   /  |/  /_ __  _______  __ _  ___  ___ ___  ___/ (_)_ ____ _ 
#  / /|_/ / // / / __/ _ \/  ' \/ _ \/ -_) _ \/ _  / / // /  ' \
# /_/  /_/\_, /  \__/\___/_/_/_/ .__/\__/_//_/\_,_/_/\_,_/_/_/_/
#        /___/                /_/                               
#   
# My Compendium
#
# 00_setup.R
#
# libraries and global variables
#
#################################################

#################################################
#
# Librairies
#
#################################################

#Create CRAN packages vector
cran_packages <- c(
  "devtools",
  "parallel",
  "dplyr",
  "crayon",
  "sf",
  "ggplot2"
)

n_i_p <- cran_packages[!(cran_packages %in% installed.packages())] # install package only if they aren't installed yet

lapply(n_i_p, install.packages, dependencies = TRUE) # install packages

#Check CRAN packages
if (sum(unlist(lapply(cran_packages, require, character.only = TRUE))) == length(cran_packages)) {
  
  cat("\n", emo::ji("computer"), ">>> All packages loaded !\n")
  
} else {
  
  cat("\n", emo::ji("warning"), ">>> Some packages failed to load !\n")
  
}


#################################################
#
# Create results folders
#
#################################################

#cretae forlder names
script_names <- list.files(path = file.path("R"), pattern = "^[0-9]{2}.+\\.R$")
script_names <- script_names[-1]
dir_names    <- gsub("\\.R", "", script_names)
dir_vars     <- stringr::str_extract(dir_names, "^[0-9]{2}[a-z]?")
dir_vars     <- paste0("res_dir_", dir_vars)

#create folders & folder names variables
sapply(1:length(dir_names), function(i) {
  
  dir.create(
    path          = file.path("res", dir_names[i]),
    showWarnings  = FALSE,
    recursive     = TRUE
  )
  
  assign(
    x      = dir_vars[i],
    value  = file.path("res", dir_names[i]),
    envir  = .GlobalEnv
  )
})

cat(">>> All folders created !\n")

#clean temporary variables
rm(list = c("script_names", "dir_names", "dir_vars", "cran_packages", "n_i_p"))
