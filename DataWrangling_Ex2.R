# load libraries
suppressMessages(library(dplyr))
library(tidyr)

# 0: download csv file and create local dataframe
titanic_original_df <- data.frame(read.csv("~/Springboard/3_2_DataWrangling_Ex2/titanic_original.csv"))



#1 Port of embarcation - replace missing values with "S"

titanic_original_df %>%
  mutate(embarked = sub("^$", "S", embarked)) #%>%
  #select(embarked, age)

#2 Age - calculate the mean of age and populate missing values

mean_age <- mean(titanic_original_df$age, na.rm = TRUE)

titanic_original_df <-  titanic_original_df %>%
  mutate(age = replace_na(age, mean_age)) 
  
#3 Fill the empty slots in boat column with NA or None

titanic_original_df <- titanic_original_df %>%
  mutate(boat = sub("^$", "None", boat))

#4 Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise.

titanic_original_df <- titanic_original_df %>%
   mutate(has_cabin_number = ifelse(cabin == "", 0, 1))

 View(titanic_original_df)

write.csv(titanic_original_df, "~/Springboard/3_2_DataWrangling_Ex2/titanic_clean.csv" )
