load("section_b.Rda")

#c1
table(sales$pizza)

#c2
lm.min<-lm(pizza~1,data=sales)
lm.max<-lm(pizza~.,data=sales)
library(MASS)
scp <- list(lower = lm.min, upper = lm.max)
lm.selected<- stepAIC(lm.min, scope = scp, direction = "forward")

#c3 
summary(lm.selected)
plot(lm.selected)
# it has high leverage

#c4
print(sales[18,])

#c5
# although the sales of pizza is the highest on this day there does not seem 
# to be anything too unusual about the sales on this day, so I would not
# consider it an outlier

#c6
summary(lm.selected)
RSS <- sum(resid(lm.selected)^2)
RSS
#81.71237

#c7
rmse <- sqrt(RSS/(43-11))
rmse
#1.597971

#c8
# the number of degrees of freedom of the model
# number of fitted parameters in the model
# (one for each of the predictor columns + intercept)

# c9
# RMSE as it is in the same units as the prediction
# and indicates the standard error

# c10
lm.day<-lm(pizza~weekday,data=sales)

# c11
# Each coefficient is the average additional number of pizza sales
# on that weekday relative to Friday which acts as a baseline
# (mean pizza sales on Friday given by the intercept 2.2)


# c12
anova(lm.day,lm.selected)

#c13
# p value is significant at the 0.01 level so we can reject the 
# null hypothesis that all coefficients in the larger model
# are consistent with a value of zero

# c14 
# pizza sales is predicted by using values like total sales 
# sodas and dessert sales which cannot be known in advance
lm.day.weather<-lm(pizza~weekday+humidity+wind+temp,data=sales)

#c15 we use cross validation to estimate our model performance
# on new data 
# estimated values like adjusted Rsquared and estimated RMSE rely on 
# the assumptions of linear regression (normal residuals after fitting etc)
# so may not be accurate when these are nt met

#c16 R gives us the number of repeats with different fold allcations.
# repeating the cross validation and averaging can reduce the variability in the 
# in our result and provide an error range estimate on the measurement

#c17 We can use up to the number of rows (equivalent to LOOCV)

#c18
library(cvTools)
cv1<-cvFit(lm.day,y=sales$pizza,data=sales,k=10,R=100)
cv2<-cvFit(lm.day.weather,y=sales$pizza,data=sales,k=10,R=100)
cv1$cv
cv2$cv
cv1$se
cv2$se

#c19 In this case although the model with more predictors has slightly 
# better performance by cross validation the standard error
# suggests this is not a statistically  significant improvement 
# and so we would favour the simpler model using weekday only 
          