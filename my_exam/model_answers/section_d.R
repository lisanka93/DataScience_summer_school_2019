load("section_d.Rda")

#d1
hist(medical_data$glucagon)
hist(medical_data$log_glucagon)

#d2
#log glucagon because the data is normally distributed  
# in line with the assumptions of logistic regression
# and LDA

#d3 
medical_data$log_glucagon <- log(medical_data$glucagon)

#d4
plot(log_glucagon~mass,medical_data,col=unclass(medical_data$diabetes),
     ylim=c(-3,4), xlim=c(10,80), 
     main="Cases of medical_data Onset", 
     ylab="log(Glucagon) ug/ml", xlab = "Mass kg")
legend(x=60, y=4,c("negative","positive"),col=c(1,2),pch=c(1,1))

#d5 Yes because the red and black points are seperated, positives
# tended to have higher glucagon and masses

#d6 
medical_data$log_glucagon_rs <- scale(medical_data $log_glucagon)
medical_data$mass_rs <- scale(medical_data $mass)

mean(medical_data$log_glucagon_rs)
mean(medical_data$mass_rs)

sd(medical_data$log_glucagon_rs)
sd(medical_data$mass_rs)

# mean is zero and sd is 1 for the rescaled columns

#d7
set.seed(1)
floor(0.6*392)
train_rows <- sample(1:392,235)
train_data <- medical_data[train_rows,]
test_data <- medical_data[-train_rows,]

