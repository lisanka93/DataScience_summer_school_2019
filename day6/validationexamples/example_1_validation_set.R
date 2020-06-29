# validation set example

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


# for validation set approach we split data into 
# training and test set
n_training = n%/%2 
# using %/% means integer division
# e.g. 3%/%2 = 1 not 1.5
# this is useful when we need whole numbers
data.training <- data.sample[1:n_training,]
data.test <- data.sample[n_training:n,]

# fit linear regression
model <- lm(Y~X,data=data.training)

# create diagnostic plots for fit
# plot(model)

plot(Y~X,data=data.training)
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
training_predict <- predict(model) 
MSE_model <- mean((data.training$Y - training_predict)^2)

# for our cross validation we test on the unfitted test data
test_predict <- predict(model, newdata=data.test) 
MSE_test <- mean((data.test$Y - test_predict)^2)

# we might compare the MSE_sample and MSE_CV with
# true MSE for the model on the full population:
pop_predict <- predict(model, newdata=data.pop) 
MSE_pop <- mean((data.pop$Y - pop_predict)^2)

# results
cat(MSE_model," ",MSE_test," ",MSE_pop,"\n")

# we should find MSE_test is larger than MSE_model
# and a better estimator for MSE_population
# however there is a lot of variation possible
# in the MSE_test - if we partitioned the data
# in to in a different way we would end up 
# with different values.

# also the fit will not be as good as a fit 
# compared to a fit that used the full dataset
# with twice the number of points.