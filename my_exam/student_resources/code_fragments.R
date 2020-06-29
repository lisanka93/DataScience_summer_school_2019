lm_step = lm(pizza ~ weekday + humidity + staff + dessert + total_sales +  soda, data = sales)

medical_data$log_glucagon_rs <- scale(medical_data$log_glucagon)
medical_data$mass_rs <- scale(medical_data$mass)

K_values = c( seq(2,12,2), seq(15,55,5), seq(60,200,10) )