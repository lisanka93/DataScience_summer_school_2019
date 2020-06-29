#
load("section_e.Rda")

#e1
model1 <- glm(diabetes~log_glucagon_rs+mass_rs,data=train_data,family=binomial)

#e2
prob_medical_data <- predict(model1,type="resp",newdata = test_data)
pred_medical_data <- ifelse(prob_medical_data>0.5, "pos", "neg")

#e3
table(predicted=pred_medical_data, actual=test_data$diabetes)

#e4
30+24
# 54 positive cases

#e5
# 30 cases correctly predicted

# e6
TPR = 30/54
#0.556


#e7
pred_medical_data <- ifelse(prob_medical_data>0.3, "pos", "neg")
prob_medical_data <- predict(model1,type="resp",newdata = test_data)
table(predicted=pred_medical_data, actual=test_data$diabetes)

# e8
TPR = 45/54
#0.83

#e9
#This correclty indentifies more people at risk of diabetes so 
# that preventative actin could be taken

#e10 misclassification rate has increased (we predict more positive
# cases that are acutally negative)

#e11
train_data_x <- dplyr::select(train_data, log_glucagon_rs, mass_rs)
test_data_x <- dplyr::select(test_data, log_glucagon_rs, mass_rs)
train_data_y <- train_data$diabetes
test_data_y <- test_data$diabetes

#e12
pred_knn <- knn(train = train_data_x, test = test_data_x, cl = train_data_y,k = 9)
#table(predicted=pred_knn, actual=test_data$diabetes)

#e13
mcr <- sum(pred_knn!=test_data_y)/length(test_data_y)
# 0.2038 

#e14
K_values = c( seq(2,12,2), seq(15,55,5), seq(60,200,10) )
m_vals <- rep(0,30)
for (i in 1:30){
  pred_knn <- knn(train = train_data_x, test = test_data_x, cl = train_data_y,k = K_values[i])
  m_vals[i] = sum(pred_knn!=test_data$diabetes)/length(test_data_y)
}
plot(K_values,m_vals)

#e15
K_values = c( seq(2,12,2), seq(15,55,5), seq(60,200,10) )
m_vals <- rep(0,30)
sd_vals <- rep(0,30)

for (i in 1:30){
  missclass_vals <- rep(0,20)
  for (j in 1:20){
    train_rows <- sample(1:392,235)
    train_data <- medical_data[train_rows,]
    test_data <- medical_data[-train_rows,]
    train_data_x <- dplyr::select(train_data, log_glucagon_rs, mass_rs)
    test_data_x <- dplyr::select(test_data, log_glucagon_rs, mass_rs)
    train_data_y <- unlist(train_data$diabetes)
    test_data_y <- unlist(test_data$diabetes)
    pred_knn <- knn(train = train_data_x, test = test_data_x, cl = train_data_y,k = K_values[i])
    missclass_vals[j] <- sum(pred_knn!=test_data$diabetes)/length(test_data_y)
  }
  m_vals[i]<-mean(missclass_vals)
  sd_vals[i]<-sd(missclass_vals)
}
plot(K_values,m_vals,ylim=c(0.10,0.50))
points(K_values,m_vals+sd_vals,pch=3)
points(K_values,m_vals-sd_vals,pch=3)

