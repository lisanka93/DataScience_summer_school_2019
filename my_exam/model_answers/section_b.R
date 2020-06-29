load("section_b.Rda")

#b1
sum(sales$soda)

#b2
max(sales$wraps)

#b3
library(dplyr)
sara_sales <- filter(sales,staff=="Harry")$total_sales
mean(sara_sales)

#b4
harry_sales <- filter(sales,staff=="Sara")$total_sales
mean(harry_sales)

#b5
t.test(harry_sales,sara_sales)

#b6
# p value is greater than 0.05 so we can't reject the null hypothesis
# that there is no difference in average sales

#b7
range(sales$humidity)

#b8
model1<-lm(coffee~temp,data=sales)
model2<-lm(coffee~humidity,data=sales)
model3<-lm(coffee~wind,data=sales)

#b9
library(texreg)
screenreg(list(model1,model2,model3))

#b10
as temperature rises by 1 degree the number of coffees decreases by 0.59
there is evidence at the 0.001 significance level that the 
null hypothesis (no linear trend between coffee and temperature) can be rejected

as humidity rises by 1 unit the number of coffees increases by 0.40
there is evidence at the 0.001 significance level that the 
null hypothesis (no linear trend between coffee and humidity) can be rejected

as windspeed rises by 1 unit the number of coffees decreases by 0.39
however this result is not significant at a 0.05 significance level so we cannot
reject the null hypothesis there is no linear trend.


#b11
humidity_vals = data.frame(humidity=c(30,80))
predict(model2,newdata = humidity_vals)
