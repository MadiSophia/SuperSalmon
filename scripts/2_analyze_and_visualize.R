#1 in R we have to install packages 
#(these are the analysis tools we use for our analysis)
#install.packages(dplyr)
#install.packages("ggplot2")
#install.packages("lubridate")
install.packages(c("rstatix", "multcompView","cowplot","agricolae"))  # run once
#Once they are installed we do not need to install 
#them again we just need to load the into the library 

library(dplyr)
library(ggplot2)
library(lubridate)
library(dplyr)
library(lubridate)
library(rstatix)
library(multcompView)
library(ggplot2)
library(cowplot)

#this clears out previous data, essentially an erase buttom 
rm(list =ls())


#salmon data with updated dates from last time

data <- read.csv("C:/Users/madib98.stu/Documents/GitHub/SuperSalmon/data/salmon_data_clean.csv")
  
#1- Is there a difference in size between Chum and Chinook salmon?
#2- Is there a difference in salmon numbers over the years?
#3 Is there a statistically significant difference in salmon size over the years?

#Q1 Chum and Chinook size difference
#we are going to use a visualization tool called ggplot2

size_species <- ggplot(data, aes(x = Species, y = Length_mm)) +
  geom_boxplot(fill = "purple", color = "black") +
  labs(title = "Size Comparison: Chum vs Chinook Salmon",
       x = "Species",
       y = "Length (mm)") +
  theme_minimal()

plot(size_species)


#2- Is there is a difference in salmon numbers over the years?


# Make sure Date is Date format
data$Date <- as.Date(data$Date)

# Extract year
data <- data %>%
  mutate(Year = year(Date))

# Count fish per year per species
df_year <- data %>%
  group_by(Year, Species) %>%
  summarize(n = n(), .groups = "drop")


#Now we plot out salmon per year 
salmon_year <-ggplot(df_year, aes(x = factor(Year), y = n, fill = Species)) +
  geom_col(position = "dodge", color = "white", linewidth = 0.4) +  # white outlines
  
  # Show every other year label
  scale_x_discrete(breaks = function(x) x[seq(1, length(x), by = 2)]) +
  
  # Lilac & pink colors
  scale_fill_manual(values = c("chinook salmon" = "#C8A2C8",
                               "chum salmon"    = "#FFB6C1")) +
  
  # White background theme
  theme_classic() +
  
  labs(title = "Annual Salmon Counts by Species",
       x = "Year",
       y = "fish count")


plot(salmon_year)


#3 Is there a statistically significant difference in salmon size over the years?

# PREPARE DATA
data$Date <- as.Date(data$Date)
data <- data %>% mutate(
  Year = factor(year(Date)),
  Species = factor(Species)
)

# COLOR PALETTE
species_colors <- c("chinook salmon" = "#C8A2C8",
                    "chum salmon"    = "#FFB6C1")

# FUNCTION TO CALCULATE CLD LETTERS
get_cld <- function(df){
  kw <- kruskal.test(Length_mm ~ Year, data = df)
  if(kw$p.value < 0.05){
    dunn <- agricolae::kruskal(df$Length_mm, df$Year, group = TRUE)
    cld <- dunn$groups
    cld$Year <- rownames(cld)
    return(cld[, c("Year", "groups")])
  } else {
    years <- levels(df$Year)
    return(data.frame(Year = years, groups = "a"))
  }
}

# CREATE PLOTS FOR EACH SPECIES
p_list <- list()

for(sp in levels(data$Species)){
  
  sp_data <- data %>% filter(Species == sp)
  
  # Get CLD letters
  cld_df <- get_cld(sp_data)
  
  # Compute y-position for letters (just above max)
  medians <- sp_data %>% group_by(Year) %>% summarize(y = max(Length_mm, na.rm = TRUE) + 5)
  cld_df <- dplyr::left_join(cld_df, medians, by = "Year")
  
  # Create boxplot
  # Create boxplot with adjusted letters
  p <- ggplot(sp_data, aes(x = Year, y = Length_mm, fill = Species)) +
    geom_boxplot(color = "black") +
    scale_fill_manual(values = species_colors) +
    geom_text(data = cld_df, 
              aes(x = Year, y = y + 5, label = groups),  # raise letters higher
              vjust = 0, 
              size = 3,                                # smaller text
              inherit.aes = FALSE) +
    theme_classic() +
    labs(title = sp,
         x = "Year",
         y = "Length (mm)") +
    theme(
      legend.position = "none",
      plot.title = element_text(face = "italic"),
      axis.text.x = element_text(angle = 45, hjust = 1)
    ) +
    # Label every other year
    scale_x_discrete(breaks = levels(sp_data$Year)[seq(1, length(levels(sp_data$Year)), by = 2)])
  
  p_list[[sp]] <- p
}

# COMBINE WITH COWPLOT
combined_plot <- cowplot::plot_grid(plotlist = p_list, ncol = 1, align = "v")
plot(combined_plot)


#Yay now we can see which years are statically different from each other 
