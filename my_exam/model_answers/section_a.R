#a1
library(readr)
sales<-read_csv("sales.csv")

#a2
names(sales)
#write_csv(sales,"sales.csv")

#a3
sales$wind <- sales$windspeed
sales$windspeed <- NULL

#a4
n1 <- nrow(sales)

#a5
sales<-sales[complete.cases(sales),]
n2 <- nrow(sales)
n2-n1
# 70 rows removed

#a6
sales$date <- NULL

#a7
sales$staff <- factor(sales$staff, levels=c(1,2,3,4), labels=c("Harry","Sara","Tom","Kate"))

#a8
sales$food <- sales$pizza + sales$pasta + sales$wraps
#sales$food <- NULL
