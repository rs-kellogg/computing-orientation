############################
### Multiple Regression ###
### Example using KLC   ###
############################

# clean workspace
rm(list=ls())

# We will use some built-in data today. 
#install.packages("datasets")
library(datasets)

# This is data on swiss fertality rates in the late 1800s.  
data(swiss)

# We want to see whether certain conditions in Swiss provinces 
# influenced fertility rates:
#  a.) percentage of men employed in Agriculture
#  b.) majority Cathlolic vs. Protestant

################# Goals ######################
# 1. Run a OLS regression on the swiss dataset
# 2. Visualize the effects of multiple variables 
#    simultaneously
###############################################

##################
# 1. Multiple Linear Regression (with two variables)
##################

# Recode the Catholic percentage variable to indicate 
# majority Catholic provinces
swiss$Catholic <- ifelse(swiss$Catholic > 50, 1, 0)

# Note that we will later assume that provinces that are not
# majority Catholic are majority Protestant

# Look at the data by clicking on the dataset name in your 
# Workspace/Environment or by using the following command:
swiss

# We want to understand why some provinces had lower fertility 
# rates. We have several variables that can explain this: 
colnames(swiss)

# A simple linear regression looks at the effect of Agriculture
# on fertility
mod1 <- lm(Fertility~Agriculture, data=swiss)
summary(mod1)

# Multiple Regression is an extension of linear
# regression. Instead of y = a + b*x we now have 
# y = a + b1*x + b2*x. We refer to the things we 
# estimate (a, b1, and b2) as coefficients. We can 
# interpret these coefficients exactly like we did 
# before.  Multiple regression allows us to test 
# multiple statistical relationships at once. 

# Lets continue with the swiss example.  How can we test 
# if Agriculture and Catholicism matter simultaneously? 
mod2 <- lm( Fertility ~ Agriculture + Catholic, swiss)
summary(mod2)

##################
# 2. Plotting the Data
##################

# Now Let's Plot this data:

# create a pdf file
pdf("swiss.pdf")

# plot the data
plot(x = swiss$Agriculture, y = swiss$Fertility, pch = 20, 
     col = ifelse(swiss$Catholic == 1, "red", "blue"), 
     xlab = "Agriculture", ylab = "Fertility", 
     main = "Predictors of Fertility in Switzerland")
legend("topleft", legend = c("Catholic", "Protestant"),
       pch = 20, col = c("red", "blue"), cex=.9, 
       x.intersp=.5, y.intersp=.6, bty="n")
abline( a = 60.8322, b = 0.1242, col="blue")
abline( a = 60.8322+7.8843, b = 0.1242, col="red")

dev.off()

