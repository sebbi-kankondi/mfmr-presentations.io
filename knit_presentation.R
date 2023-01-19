#load multiple libraries function
source("C:/Users/Sebbitwo/Desktop/Academic/PhD/Write_Ups/multiple_libraries.R")
windowsFonts(A=windowsFont("TimesNewRoman"))

#set working directory to presentations folder
setwd("C:/Users/Sebbitwo/Documents/National Marine Aquarium/Presentations")



#knit the mfmr presentation

read_library(xaringanExtra, knitr, xaringan, rmarkdown)

# Render the presentation to html
render("presentation.Rmd")

