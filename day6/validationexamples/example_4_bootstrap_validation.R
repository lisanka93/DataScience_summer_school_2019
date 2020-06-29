# bootstrap validation example

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
# to infer it from a random sample of 200 points 
n <- 200
sampled_rows <- sample(1:N,n )
data.sample <- data.pop[sampled_rows,]

# in bootstrapping we resample this many times
R=1000
# on each resampled set we calculate and store
# the fit parameter of interest
# here let's store the fitted slope value
# and mean squared sum of residuals MSE 
coef_out <- rep(NA,R)
MSE_out <- rep(NA,R)
for (i in 1:R){
  resampled_rows <- sample(1:n,n,replace=TRUE )
  data.resampled <- data.sample[resampled_rows,]
  model <- lm(Y~X,data=data.resampled)
  coef_out[i] <- coef(model)[[2]]
  MSE_out[i] <- mean(resid(model)^2)
}

# examining the histograms of the variables of interest
# let's us estimate the possible distribution
# when testing new data
hist(coef_out)
hist(MSE_out)
mean(coef_out)
mean(MSE_out)

# compare to fit to original sample
model <- lm(Y~X,data=data.sample)
coef_sample <- coef(model)[[2]]
MSE_sample <- mean(resid(model)^2)

coef_sample
MSE_sample

# note this doesn't improve the fit, it justs gives us
# infomation on the distributions of the parameter 
# estimates