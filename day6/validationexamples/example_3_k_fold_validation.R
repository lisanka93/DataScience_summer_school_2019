# k-fold validation example

set.seed(101)

# Let's create a population with some
# variable of interest Y. We have an
# input variable X that has mean 800, stdev 10
# and 10000 members
N <- 10000
X <- rnorm(N,mean=800,sd=10)

# Let's make the true relationship that 
# Y and X are positively correlated.
# with population regression relationship
# Y = 0.5*X + e
# where e is the variance in Y that is not explained
# by the variation in X
# assume this is fairly large 
# e.g. mean = 0 but sd = 20
e <- rnorm(N,mean=0,sd=20)

# now we can calculate Y
Y = 0.5*X + e

# Store into data.frame
data.pop = data.frame(Y,X,e)

# Suppose a data scientist wants to explore the
# relationship between Y and X. However they don't have
# access to the full population sample, and need
# to infer it from a random sample of 40 points 
n=40
sampled_rows <- sample(1:N,n )
data.sample <- data.pop[sampled_rows,]

# fit linear regression
model <- lm(Y~X,data=data.sample)

# create diagnostic plots for fit
# plot(model)

plot(Y~X,data=data.sample)
abline(model)

summary(model)
# R^2 = 0.06 means 6% of total variance in Y can be accounted for 
# by variation in X. True value for population is (10*10)/(50*50) = 0.04.

# The line:
# X              1.1677     0.5932   1.968   0.0539 .
# means we fitted slope as 1.1677, (true value is 1)
# Note X coefficient is "not significant" at the 1% alpha level even though 
# it *is* a model input. The significance means we just can't rule out that
# fitting this line if true relationship is Y and X are uncorrelated.

# The quality of the model can be estimated by the MSE 
# mean squared error of the prediction. This can
# be found by finding the RSS (sum of squared residuals)
# and dividing by n or mean squared residual.
# quickway: MSE_model <- mean(resid(model)^2)
# alternatively:
sample_predict <- predict(model) 
MSE_model <- mean((data.sample$Y - sample_predict)^2)

# set number of folds
# typically choose 5 or 10
# k = n performs LOOCV
k <- 10

# allocate each row to a fold
# using rep which can repeat sequence 1 to k
# down the rows to the end of the data frame
data.sample$fold <- rep(1:k,length.out=n)
# create a column to store the CV predictions
data.sample$cv_pred <- NA

# In k-fold cross validation we remove each fold from the data in turn, and
# calculate the MSE error for the remaining fold

for(i in 1:k){
  # we train on k-1 folds
  # first we select the training set
  training_rows <- which(data.sample$fold != i)
  training_data <- data.sample[training_rows,] 
  # and perform the fit on it
  cv_model <- lm(Y~X,data=training_data) 
  # we then use this fit to predict the remaining fold 
  # that was not used in the fit.
  # so we select this fold to be the validation set
  validation_rows <-which(data.sample$fold == i)
  validation_data <- data.sample[validation_rows,] 
  
  # and use the model to predict the output
  cv_pred <- predict(cv_model,newdata=validation_data) 
  # and store the predictions in our dataframe 
  data.sample[validation_rows,]$cv_pred <- cv_pred 
}
# after performing this procedure k times we have made predictions
# for every fold (having excluded it from the fit used for its prediction)

# to produce the final estimate we need to find the MSE
# for our validation predictions
MSE_CV <- mean((data.sample$Y - data.sample$cv_pred)^2,na.rm=T)

# we might compare the MSE_sample and MSE_CV with
# true MSE for the model on the full population:
pop_predict <- predict(model, newdata=data.pop) 
MSE_pop <- mean((data.pop$Y - pop_predict)^2)

cat(MSE_model," ",MSE_CV," ",MSE_pop,"\n")

# alternatively there is a function to do all this for us!
#install.packages("cvTools")
library(cvTools) #run the above line if you don't have this library
cvFit(model, data = data.sample, y = data.sample$Y, K = 5)
# This returns sqrt(MSE) or RMSE value

# notes:
# values for CV differ each time as folds are allocated at random
# so the value changes too
# k = 1 is equivalent to LOOCV
# standard choice is to choose k=5 or 10
# cvFit can repeat the CV with many random fold allocations 
# this will reduce the variablilty in MSE_CV estimate
# To do this we use argument R=... 
# e.g.
# cvFit(model, data = data.sample, y = data.sample$Y, K = 5, R=100)
