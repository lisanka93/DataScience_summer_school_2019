lm_step = lm(sandwich ~ day + cookies + temp + 
               sandwich_waste + wraps_waste + sales + 
               wraps, data=cafe_data)

db_all$glucose_rs <- scale(db_all$glucose)
db_all$log_insulin_rs <- scale(db_all$log_insulin)
