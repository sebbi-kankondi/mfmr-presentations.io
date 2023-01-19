#clear global environment
rm(list = ls())

#load multiple libraries function
source("C:/Users/Sebbitwo/Desktop/Academic/PhD/Write_Ups/multiple_libraries.R")
windowsFonts(A=windowsFont("TimesNewRoman"))


read_library(tidyverse, janitor, plotly, 
             ggplot2, htmlwidgets)

#load the tac_data file
tac_data <- read.csv("C:/Users/Sebbitwo/Documents/National Marine Aquarium/Presentations/data/tac_data.csv") %>% 
  clean_names() %>% 
  mutate(species = as.factor(species)) #convert species to factor

#sort the data so that the plot traces are arranged from front to back of the plot by average overall catch rate
tac_data_sorted <- tac_data %>%
  group_by(species) %>%
  mutate(mean_catch = mean(catch)) %>%
  ungroup() %>%
  arrange(desc(mean_catch))


#static-plot--------------------------------------------------

# Create a ggplot object
# mfmr_landings <- ggplot(data = tac_data, aes(x = year, y = catch)) + 
#   geom_area(aes(fill = species), alpha = 0.5) + 
#   ggtitle("Fish landings (kt) by species from 1947 to 2022") + 
#   xlab("Year") + 
#   ylab("Landings (kt)") + 
#   scale_x_continuous(breaks = c(1947, 1952, 1957, 1962, 1967, 1972, 1977, 1982,
#                                 1987, 1992, 1997, 2002, 2007, 2012, 2017, 2022)) +
#   theme_classic()
# mfmr_landings <- mfmr_landings +
#   theme(axis.text.x = element_text(angle = 270, hjust = 1))
# mfmr_landings <- mfmr_landings + 
#   scale_fill_manual(values = c("#0c1b33", "#a3320b", "#109648", "#f0e100", "#a28497", "#2f1000"), 
#                     labels = c("Anchovy", "Hake", "Horse Mackerel", "Monk", "Sardine", "Rock Lobster"))


# ggsave(filename = "C:/Users/Sebbitwo/Documents/National Marine Aquarium/Presentations/images/mfmr_landings.png", 
#        plot = mfmr_landings, width = 7, height = 5, dpi=300, units = "in")



# In this example, tac_data is the dataframe containing the catch data. The ggplot() function 
# is used to create a base plot object and the aes() function is used to specify the mapping of
# variables to aesthetics. The x and y aesthetics are mapped to the year and catch variables, 
# respectively. The group aesthetic is mapped to the species variable and the color aesthetic 
# is also mapped to the species variable. The geom_line() function is used to add lines to the
# plot and the geom_area() function is used to shade the area under each line. The alpha argument
# of geom_area is used to adjust the transparency of the shaded area. Finally, ggtitle, xlab and 
# ylab are used to add a title and labels to the x and y axis respectively. The theme_classic() function 
# is used to apply a classic theme to the plot. scale_x_continuous manually adds x-axis labels to the plot


#interactive-plot---------------------

# Create plotly area chart and store in object
mfmr_landings <- plot_ly(data = tac_data_sorted, x = ~year, y = ~catch, 
        type = "scatter", mode = "lines", fill = "tozeroy", color = ~species, 
        colors = c("#0c1b33", "#a3320b", "#109648", "#f0e100", "#a28497", "#2f1000"), 
        hoverinfo = "text",
        text = paste("Year: ", tac_data_sorted$year, "<br>",
                     "Catch: ", tac_data_sorted$catch, "<br>", "Species: ", tac_data_sorted$species)) %>% 
  layout(title = "Fish landings (kt) by species from 1947 to 2022",
         xaxis = list(title = "Year"),
         yaxis = list(title = "Landings (kt)"),
         legend = list(x = 1, y = 1, font = list(size = 12), width = 200))


# #save as html file
saveWidget(mfmr_landings, "C:/Users/Sebbitwo/Documents/National Marine Aquarium/Presentations/images/mfmr_landings.html")

