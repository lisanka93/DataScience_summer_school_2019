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
# You only need to do this the first time you 
install.packages("readxl")

## ------------------------------------------------------------------------
library(readxl)

## ------------------------------------------------------------------------
student_data <- read_excel("hsb2.xlsx")

## ------------------------------------------------------------------------
names(student_data)

## ------------------------------------------------------------------------
dim(student_data)

## ------------------------------------------------------------------------
head(student_data, n = 10)

## ------------------------------------------------------------------------
hist(student_data$science, main = "Histogram of Science Scores", xlab = "Science Score")

## ------------------------------------------------------------------------
attach(student_data)
hist(science, main = "Histogram of Science Scores", xlab = "Science Score")
detach(student_data)

## ------------------------------------------------------------------------
with(student_data,
	hist(science, main = "Histogram of Science Scores", xlab = "Science Score")
	)

## ------------------------------------------------------------------------
sum(student_data$science) / length(student_data$science)

## ------------------------------------------------------------------------
science_mean <- mean(student_data$science)
science_mean

## ------------------------------------------------------------------------
science_median <- median(student_data$science)
science_median

## ------------------------------------------------------------------------
science_scores <- table(student_data$science)
science_scores

## ------------------------------------------------------------------------
sorted_science_scores <- sort(science_scores, decreasing = TRUE)
sorted_science_scores

## ------------------------------------------------------------------------
science_mode <- sorted_science_scores[1]
science_mode

## ------------------------------------------------------------------------
max(student_data$science)
which.max(student_data$science)

## ------------------------------------------------------------------------
top_science_student <- which.max(student_data$science)
top_science_student_id <- student_data[top_science_student,]$id
top_science_student_id

## ------------------------------------------------------------------------
science_range <- range(student_data$science)
diff(science_range)

## ------------------------------------------------------------------------
var(student_data$science)

## ------------------------------------------------------------------------
sd(student_data$science)

## ------------------------------------------------------------------------
quantile(student_data$science, c(0.25, 0.5, 0.75))

## ------------------------------------------------------------------------
student_data$gender <- factor(student_data$female, 
                              labels = c("Male", "Female")) 

student_data$socioeconomic_status <- factor(student_data$ses, 
                                            labels = c("Low", "Middle", "High")) 

student_data$racial_group <- factor(student_data$race, 
                                    labels = c("Black", "Asian", "Hispanic", "White")) 

## ------------------------------------------------------------------------
head(student_data)

## ------------------------------------------------------------------------
table(student_data$gender)

## ------------------------------------------------------------------------
table(student_data$socioeconomic_status)

## ------------------------------------------------------------------------
table(student_data$socioeconomic_status, student_data$racial_group)

## ------------------------------------------------------------------------
boys <- subset(student_data, gender == "Male")
girls <- subset(student_data, gender == "Female")

## ------------------------------------------------------------------------
mean(boys$science)
mean(girls$science)

## ------------------------------------------------------------------------
# bar charts
barplot(table(student_data$socioeconomic_status))

## ------------------------------------------------------------------------
# science score by gender, race and socioeconomic status
par(mfrow=c(1,3))

# categorical variables are plotted as boxplots
plot(student_data$gender, student_data$science, 
     main = "Gender", las = 2)

plot(student_data$racial_group, student_data$science, 
     main = "Race", las = 2)

plot(student_data$socioeconomic_status, student_data$science, 
     main = "Socioeconomic Status", las = 2)

## ------------------------------------------------------------------------
par(mfrow=c(1,1))

plot(student_data$math~student_data$science, xlim=c(0,100), ylim=c(0,100))
myfit<-lm(math~science,data=student_data)
summary(myfit)
abline(myfit)

   
## ------------------------------------------------------------------------
pairs(~ read + write + math + science + socst, data = student_data)

## ------------------------------------------------------------------------
student_data$english <- apply(student_data[c("read", "write")], 1, mean)

## ------------------------------------------------------------------------
head(student_data)


