#1 in R we have to install packages 
#(these are the analysis tools we use for our analysis)
#install.packages(dplyr)
#install.packages("ggplot2")
#install.packages("lubridate")

#Once they are installed we do not need to install 
#them again we just need to load the into the library 

library(dplyr)
library(lubridate)

#this clears out previous data, essentially an erase button
rm(list =ls())


#2 Now we will load in data 
#depending on where you cloned the repository on your computer you might have to adjust this)

data <- read.csv("C:/Users/madib98.stu/Documents/GitHub/SuperSalmon/data/salmon_data.csv")


#3 Yay! now you have read in your data now lets see what it looks like
#this will appear in the console

print(head(data))


#4 we can also visualize columns individual like this 

#see species
print(data$Species)

#see length 
print(data$Length_mm)

#see dates
print(data$Date)



#5 now we will try a few basic data manipulations

#Lets say I just want chum salmon 

data_chum <- subset(data, Species == "chum salmon")

#Or look at data above a certain length greater or equal to 550mm ?

data_550 <- filter(data, Length_mm >= 550)

# Or above a certain date?

#Okay it gets a bit more complicated here

print(class(data$Date))

#We see that it is in currently in character format 
#this means it can't be filtered numerically

#so we will use a nice package for this called lurbidate to reformat
data$Date <- lubridate::mdy(data$Date)


#Now we can filter

# we can filter by a range 
data_spec <- data %>%
  filter(Date >= ymd("2000-07-01") & Date <= ymd("2007-07-04"))

#we can also do year, only 1998 
data_1998 <- filter(df, year(Date) == 1998)
print(head(data_1998))

#Only the month of June
data_june <- filter(df, month(Date) == 6)

print(head(data_june))

#Only the 1st day of each month
data_day1 <- filter(data, day(Date) == 1)

print(head(data_day1))

#6 We did this nice data manipulation, now I want to save for our future analysis

write.csv(data,"C:/Users/madib98.stu/Documents/GitHub/SuperSalmon/data/salmon_data_clean.csv")


#Yay! Now you have some basics of for data manipulation lets got to script 2 
#to visualize and do basic analysis

