local({r <- getOption("repos")
r["CRAN"] <- "https://cloud.r-project.org"
options(repos=r)
})

install.packages("readr",type="binary")
install.packages("tidyr",type="binary")
install.packages("dplyr",type="binary")
install.packages("MASS",type="binary")
install.packages("caret",type="binary")
install.packages("texreg",type="binary")
install.packages("randomForest",type="binary")
install.packages("class",type="binary")
install.packages("haven",type="binary")
install.packages("readxl",type="binary")
install.packages("glmnet",type="binary")
install.packages("caret",type="binary")
install.packages("corrplot",type="binary")
install.packages("leaps",type="binary")
install.packages("cvTools",type="binary")
install.packages("car",type="binary")
install.packages("ISLR",type="binary")
install.packages("rmarkdown",type="binary")

if (R.Version()$minor>"6.0"){
  install.packages("tree")
} else if (grepl("apple",R.Version()$platform)){
  install.packages("https://cran.r-project.org/bin/macosx/el-capitan/contrib/3.5/tree_1.0-39.tgz"
                   ,repos=NULL,type="binary")
} else {
  install.packages("https://cran.r-project.org/bin/windows/contrib/3.5/tree_1.0-39.zip"
                   ,repos=NULL,type="binary")
}
