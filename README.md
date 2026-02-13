
  <img src="images/Salmon.png" alt="Project banner" width="500">
</p>


# SuperSalmon: Beginer R tutorial
A fun intro to the R programming language on salmon populations for absolute beginers. We will be analyzing salmon population data from the [Gisasa Weir Dam in Alaska](https://catalog.data.gov/dataset/age-sex-and-length-of-chum-salmon-and-chinook-salmon-sampled-at-the-gisasa-weir-between-19-291e2).
<p align="center">

## Requirements
-Please dowwnload R and Rstudio from the following [link](https://posit.co/download/rstudio-desktop/).


##  1 Downloading repository 
You will first download this repository from Github, this will give you acess to all the data and code on your computer. 
  <img src="images/download.png" width="400">
</p>

##  2 Download data and installing packages 
One you have the repository downloaded to my computer I will open the first script in Rstudio. We first will need to install the R packages ( these are basically the tools that allow you to do data analysis in R) and set paths to our data essentially telling the program where the data we are trying to analyze is. In this tutorial we will recommending you run scripts line by line for learning ( although in the future you can run the whole thing at once). You do this by highlighting the line with your curser and hit run.   <img src="images/run.png" width="400">

In script 1 you will first see this section with several "install.package" command. You will need to delete the "#" sign, which allow you to comment out code (i.e., not run it). You only need to install a package onces, after it is in isntalled if you choose to run the script again you can comment it out with a "#" or delete it the "install.package" lines . [Here is more information on R packages](https://r-pkgs.org/)

```R
#1 in R we have to install packages 
#(these are the analysis tools we use for our analysis)
#install.packages(dplyr)
#install.packages("ggplot2")
#install.packages("lubridate")

#Once they are installed we do not need to install 
#them again we just need to load the into the library 

library(dplyr)
library(lubridate)

```
Now that you have loaded your packages you need to tell R were your data is. In script 1 you can see where I originally read the data in. This will be base on where you downloaded it. 
```R
#2 Now we will load in data 
#depending on where you cloned the repository on your computer you might have to adjust this)

data <- read.csv("C:/Users/madib98.stu/Documents/GitHub/SuperSalmon/data/salmon_data.csv")

```

You can find the location of your data by looking in your folder system.
 <img src="images/dataloation.png" width="400">

 So in this case the lines in script on would be changed to the code below. ( remember when adding file paths the dashes always need to go this way / not \)
```R
#2 Now we will load in data 
#depending on where you cloned the repository on your computer you might have to adjust this)

data <- read.csv("C:/Users/madib98.stu/Desktop/SuperSalmon-main/data/salmon_data.csv")

```
Yay! now that have you have loaded you data and packages you can run the tutorial line by line to learn some basic data management skills.
## 3 Analyzing data 
Go to [Script 2](2_NFI_extract.py) and download grid .gpkg from this repository  set set desired paths on local machine for NFI data, desired indices to extract, and  were you want csv containing indices to output (if you have already matched your nfi data to gpkg you can comment this part out)
```python
nfi_path = Path(r"C:\Users\mabrown\Desktop\
```


## 4 Try on your own  
Now that you have run through this tutorial, I would encourage you to come up with one of your own research questions you would like to understand of the data and trying using your own skills to answer it. Try creating a blank script deciding your needed package, reading in your data, and creating one visualization to answer your questions.
