###########################################################################
# Save your R Project and start a new one e.g. day3
# 
# Download the data file 
# http://uclspp.github.io/PUBLG100/data/hsb2.xlsx 
# into your project folder which will be set as your working directory


# Verify that your working directory is set correctly
# 
getwd()


## ------------------------------------------------------------------------
# You only need to do this once to download the package
# once downloaded you can load it using the library command
# install.packages("readxl")

## ------------------------------------------------------------------------
library(readxl)

## ------------------------------------------------------------------------
student_data <- read_excel("hsb2.xlsx")

library('dplyr')

# select
# select function let's us select a subset of variables (columns) of our data
# notice we can refer to column names and don't need to use dataframe$colname format:
student_grades <- select(student_data, read, write,  math, science)
student_grades
# select everything but read and write
student_data2 <- select(student_data, -read, -write)
# select some columns and rename schtype to school_type 
student_data2 <- select(student_data, female, race, school_type=schtyp)

# filter
# filter function let's us filter in similar way to subset
high_reading <- filter(student_data, read>50)
# filter lets us select on multiple conditions (equivalent to using an & to combine conditions)
high_reading_writing <- filter(student_data, read>50, write>50)
head(high_reading_writing)

# mutate
# allows us to add new columns to the data based on existing columns
# e.g. we form an average language score from reading and writine
# and an overall score by averaging all score columns
student_data <- mutate(student_data, lang = (read+write)/2, overall = (read + write + math + science + socst)/5 )

# arrange
# arrange function provides an easy way to sort by column
# ascending order
student_data_sorted <- arrange(student_data,read)
# descending order
student_data_sorted <- arrange(student_data,desc(read))

# group_by
# allows us to form groups for analysis
student_data$racial_group <- factor(student_data$race, 
                                    labels = c("Black", "Asian", "Hispanic", "White")) 
student_data_by_racial_group <- group_by(student_data, racial_group)

# allows us to summarise columns (by groups if defined)
summarise(student_data_by_racial_group, n_students = n()) 
summarise(student_data_by_racial_group, mean_read = mean(read), max_read = max(read), min_read = min(read), sd_read = sd(read)) 


