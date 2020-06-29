#install.packages("readr")
library(readr)

# load into dataframe
group_info_df <- read_csv("example_group_info.csv")

# convert to dataframe
# (tibble format doesn't allow rownames)
group_info_df <- as.dataframe(group_info_df)

# to see the class of each column we can use the
# str() or structure function
str(group_info_df)

# name, sex, nationality are character
# age and grade are numerical
# owns_pet is logical

# force sex and nationality to be Factors (categories)
group_info_df$sex <- factor(group_info_df$sex)

# set row names to use first names
rownames(group_info_df) <- group_info_df$name

# print summary data
summary(group_info_df)

# to sort we need to find the row order using the order() function
# gives order of rows in ascending grade order
order(group_info_df$grade)

# use this to select the rows in order (and select all columns)
group_info_df <- group_info_df[order(group_info_df$grade), ]

n <- nrow(group_info_df)
subset_info <- group_info_df[(n-4):n,]
#or
subset_info <- group_info_df[3:7,] # selects rows 3,4,5,6,7 all columns

group_quant_info <- group_info_df[,c("age","grade")]
group_quant_info <- group_info_df[,c(3,5)]
group_quant_info <- data.frame(group_info_df$age, group_info_df$grade)

# try to plot owns pet
plot(group_info_df$owns_pet)
# we see it is treating this as a number
# for plotting it would be better to treat this as a factor
group_info_df$owns_pet <- factor(group_info_df$owns_pet)
# now will produce a bar plot
plot(group_info_df$owns_pet)

# using , to plot two columns means we
# are providing:
#     age as x-coordinates, 
#     grade as y-coordinates
plot(group_info_df$age, group_info_df$grade)

# using ~ to plot two columns means we
# are plotting:
#     age       as a function of grade
#   (y-coord)                   (x-coord)  
plot(group_info_df$age ~ group_info_df$grade)
