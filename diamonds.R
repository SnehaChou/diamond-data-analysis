# Team Information ----

## Siddharth Suresh
## Sneha Choudhary
## Suchetha Sharma
## Vidhi Gupta

# Context ----

### We are provided with inventory data from bluenile.com of the price of diamonds, given carat, cut, clarity and color. 
### The levels for the categorical attributes is as follows:
### Order of Cut: Good < Very Good < Ideal < Astor Ideal
### Order of Clarity: SI2 < SI1 < VS2 < VS1 < VVS2 < VVS1 < IF < FL
### Order of Color: J < I < H < G < F < E < D

# Required Packages ----

install.packages("MASS")
library("MASS")

install.packages("car")
library("car")

install.packages("ggplot2")
library("ggplot2")

install.packages("GGally")
library("GGally")

# UDF ----

tdist <- function(residuals, data, num_of_predictors) {
  x_grid <- seq(min(residuals)-0.5, max(residuals)+0.5, by = .01)
  dfRes <- nrow(data) - num_of_predictors - 1 # 1 for intercept
  hist(residuals, probability = T, breaks = 10, ylim = c(0,0.5))
  t_densities <- dt(x_grid, dfRes)
  points(x_grid, t_densities, type = "l", col = "blue")
}

# Load Dataset ----

diamonds_data <- read.csv('clean_diamond_data.csv')

## Using the dictionary available at bluenile.com, setting the lowest level as the base reference for the categorical Cs
diamonds_data <- within(diamonds_data, clarity <- relevel(clarity, ref = 'SI2')) ## SI2 is the lowest clarity
diamonds_data <- within(diamonds_data, color <- relevel(color, ref = 'J')) ## J is the lowest color grade
diamonds_data <- within(diamonds_data, cut <- relevel(cut, ref = 'Good')) ## Good is the lowest quality cut

# Frequency Distribution Chart ----

## Price - on entire dataset range($200 - $2,500,000)
ggplot(data = diamonds_data) + geom_histogram(binwidth = 100000, color="darkblue", fill="lightblue", aes(x = diamonds_data$price), na.rm = TRUE) + ggtitle("Diamond Price Distribution $200 - $2,500,000") + xlab("US Dollars") + ylab("Number of Diamonds")

## Price - on partial dataset range($200 - $50,000)
### The diamond concentration seems to be the most in this range
ggplot(data = diamonds_data) + geom_histogram(binwidth = 5000, color="darkblue", fill="lightblue", aes(x = diamonds_data$price), na.rm = TRUE) + ggtitle("Diamond Price Distribution between $200 - $50,000") + xlim(200, 50000) +ylim(0, 25000)+ xlab("US Dollars") + ylab("Number of Diamonds")

## Price - on partial dataset range($50,000 - $200,000)
### The diamond concentration seems to be very less in this range compared to ($200 - $50,000)
ggplot(data = diamonds_data) + geom_histogram(binwidth = 5000, color="darkblue", fill="lightblue", aes(x = diamonds_data$price), na.rm = TRUE) + ggtitle("Diamond Price Distribution between $50,000 - $200,000") + xlim(50000, 200000) +ylim(0, 500)+ xlab("US Dollars") + ylab("Number of Diamonds")

## Price - on partial dataset range($200,000 - $2,500,000)
### The diamond concentration seems to be very less in this range relative to the entire dataset
ggplot(data = diamonds_data) + geom_histogram(binwidth = 100000, color="darkblue", fill="lightblue", aes(x = diamonds_data$price), na.rm = TRUE) + ggtitle("Diamond Price Distribution between $200,000 - $2,500,000") + xlim(200000, 2500000) + xlab("US Dollars") + ylab("Number of Diamonds")

## Distribution of Diamonds based on 'Cut' attribute
ggplot(data = diamonds_data) + geom_bar(color="darkblue", fill="lightblue", aes(x = diamonds_data$cut)) + ggtitle("Diamond Cut Distribution") + xlab("Diamond Cut") + ylab("Number of Diamonds")

## Distribution of Diamonds based on 'Clarity' attribute
ggplot(data = diamonds_data) + geom_bar(color="darkblue", fill="lightblue", aes(x = diamonds_data$clarity)) + ggtitle("Diamond Clarity Distribution") + xlab("Diamond Clarity") + ylab("Number of Diamonds")

## Distribution of Diamonds based on 'Color' attribute
ggplot(data = diamonds_data) + geom_bar(color="darkblue", fill="lightblue", aes(x = diamonds_data$color)) + ggtitle("Diamond Color Distribution") + xlab("Diamond Color") + ylab("Number of Diamonds")

## Distribution of Diamonds based on 'Carat' attribute
ggplot(data = diamonds_data) + geom_freqpoly(binwidth = 0.5, aes(x = diamonds_data$carat), na.rm = TRUE) + ggtitle("Diamond Carat Distribution") + xlab("Diamond Carat") + ylab("Number of Diamonds")

# Price vs Carat Plots ----

## Price Vs Carat highlighting cut
ggplot(data = diamonds_data, aes(x = diamonds_data$carat, y = diamonds_data$price)) + geom_jitter(aes(color = cut)) + xlab("Carat") + ylab("Price") + ggtitle("Price vs Carat (Highlighting Cut)")

## Price Vs Carat highlighting clarity
ggplot(data = diamonds_data, aes(x = diamonds_data$carat, y = diamonds_data$price)) + geom_jitter(aes(color = clarity)) + xlab("Carat") + ylab("Price") + ggtitle("Price vs Carat (Highlighting Clarity)")

## Price Vs Carat highlighting color
ggplot(data = diamonds_data, aes(x = diamonds_data$carat, y = diamonds_data$price)) + geom_jitter(aes(color = color)) + xlab("Carat") + ylab("Price") + ggtitle("Price vs Carat (Highlighting Color)")

# Choosing Categorical Variables ----

## BoxPlot for Cut
ggplot(diamonds_data, aes(x = cut, y = price, color = cut)) + geom_boxplot() + ggtitle("BoxPlot for Price vs Cut")
### Due to the outliers, the variation in the mean price with the levels of the categorical variable 'cut' is not visible
ggplot(diamonds_data, aes(x = cut, y = price, color = cut)) + geom_boxplot( na.rm = TRUE) + ggtitle("BoxPlot for Price vs Cut") + ylim(0,15000)
### On limiting the data, the variation in the mean price with the levels of the categorical variable 'cut' is visible

## BoxPlot for Clarity
ggplot(diamonds_data, aes(x = clarity, y = price, color = clarity)) + geom_boxplot() + ggtitle("BoxPlot for Price vs Clarity")
### Due to the outliers, the variation in the mean price with the levels of the categorical variable 'clarity' is not visible
ggplot(diamonds_data, aes(x = clarity, y = price, color = clarity)) + geom_boxplot(na.rm = TRUE) + ggtitle("BoxPlot for Price vs Clarity") + ylim(0,10000)
### On limiting the data, the variation in the mean price with the levels of the categorical variable 'clarity' is visible

## BoxPlot Color
ggplot(diamonds_data, aes(x = color, y = price, color = color)) + geom_boxplot() + ggtitle("BoxPlot for Price vs Color")
### Due to the outliers, the variation in the mean price with the levels of the categorical 'color' variable is not visible
ggplot(diamonds_data, aes(x = color, y = price, color = color)) + geom_boxplot(na.rm = TRUE) + ggtitle("BoxPlot for Price vs Color") + ylim(0,10000)
### On limiting the data, the variation in the mean price with the levels of the categorical variable 'color' is visible

# MLR Model Version 1 ----
mlr_rev1 <- lm(price ~ carat + cut + clarity + color, diamonds_data)
summary(mlr_rev1)
### Residual Standard Error: 14790 on 210620 deg of freedom
### Adjusted R-sq : 58.29%
### p-value of the model: < 2.2e-16
anova(mlr_rev1)
### RSS: 4.6063e+13 on 210620 deg of freedom

## model adequacy
residuals_rev1 <- studres(mlr_rev1)

### checking for normality of residuals (qqplot)
tdist(residuals = residuals_rev1, data = diamonds_data, 4)
qqnorm(residuals_rev1)
qqline(residuals_rev1)
#### The t-distribution and the QQPlot clearly indicate that the residuals are not normally distributed 

### checking linear relationship between price and carat
ggplot(data = diamonds_data, aes(x = diamonds_data$carat, y = residuals_rev1)) + geom_point() + ggtitle("Residuals vs Carat") + xlab("Carat") + ylab("Residuals")
#### Since this does not give a random scatter around 0, we can conclude that price and carat are not linearly related.

### check for homoskedasticity
ggplot(data = mlr_rev1, aes(x = mlr_rev1$fitted.values, y = residuals_rev1)) + geom_point() + ggtitle("Residuals vs Fitted Values") + xlab("Fitted Values") + ylab("Residuals")
# To check for Homoskedasticity, we should see a completely random, equal distribution of points throughout the range of X axis. 
# As clearly witnessed in the graph, the residuals form a pattern and are not random.


# MLR model Version 2.1 ----
## MLR model using best-lambda from the boxcox procedure to determine transformation of price

## Variance Stabilizing Transformation on Price

boxcox_mlr_rev1 <- boxcox(mlr_rev1, data = diamonds_data)
lambda <- boxcox_mlr_rev1$x[boxcox_mlr_rev1$y == max(boxcox_mlr_rev1$y)]

diamonds_data$lambda_price <- (diamonds_data$price^lambda - 1)/lambda

ggplot(data = diamonds_data, aes(x = diamonds_data$carat, y = diamonds_data$lambda_price)) + geom_point() + xlab("Carat") + ylab("Transformed Price)") + ggtitle("Transformed Price vs Carat")
### graph seems to depict linear relationship between carat and transformed price

## MLR for lambda price
mlr_rev2a <- lm(lambda_price ~ carat + cut + clarity + color, data = diamonds_data)
summary(mlr_rev2a)
### Residual Standard Error: 9.046 on 210620 deg of freedom
### Adjusted R-sq : 92.76%
### p-value of the model: < 2.2e-16
anova(mlr_rev2a)
### RSS: 17235808 on 210620 deg of freedom
# The residual error has reduced compared to the previous model
## model adequacy
residuals_rev2a <- studres(mlr_rev2a)

### checking for normality of residuals (qqplot)
tdist(residuals = residuals_rev2a, data = diamonds_data, 4)
qqnorm(residuals_rev2a)
qqline(residuals_rev2a)
#### The t-distribution and the QQPlot indicate that the residuals have skew and also possess fat tails

### Checking linear relationship between transformed_price and carat
ggplot(data = diamonds_data, aes(x = diamonds_data$carat, y = residuals_rev2a)) + geom_point() + ggtitle("Residuals vs Carat") + xlab("Carat") + ylab("Residuals")
#### Since the plot does not give a random scatter around 0, we can conclude that transformed price and carat are still not linearly related

### check for homoskedasticity
ggplot(data = mlr_rev2a, aes(x = mlr_rev2a$fitted.values, y = residuals_rev2a)) + geom_point() + ggtitle("Residuals vs Fitted Values") + xlab("Fitted Values") + ylab("Residuals")
# To check for Homoskedasticity, we should see a completely random, equal distribution of points throughout the range of X axis. 
# As clearly witnessed in the graph, the residuals form a pattern and are not random. Also, there seems to be a logrithmic relationship. 

#### Variance is clearly not constant.

# MLR model Version 2.2 ----
## MLR model with ln(price) as ln() is the commonly used and suggested transformation for response variable

## Variance Stabilizing Transformation on Price

diamonds_data$log_price <- log(diamonds_data$price)

ggplot(data = diamonds_data, aes(x = diamonds_data$carat, y = diamonds_data$log_price)) + geom_point() + xlab("Carat") + ylab("ln(Price)") + ggtitle("ln(Price) vs Carat")
### graph seems to depecit a logarithmic relationship between price and carat, we might need to transform the regressor after further analysis

## MLR for ln(price) 
mlr_rev2b <- lm(log_price ~ carat + cut + clarity + color, data = diamonds_data)
summary(mlr_rev2b)
### Residual Standard Error: 0.6143 on 210620 deg of freedom
### Adjusted R-sq : 74.33%
### p-value of the model: < 2.2e-16
anova(mlr_rev2b)
### RSS: 79473 on 210620 deg of freedom

## model adequacy
residuals_rev2b <- studres(mlr_rev2b)

### checking for normality of residuals (qqplot)
tdist(residuals = residuals_rev2b, data = diamonds_data, 4)
qqnorm(residuals_rev2b)
qqline(residuals_rev2b)
#### The t-distribution and the QQPlot clearly indicate that the residuals are not normally distributed

### checking linear relationship between transformed_price and carat
ggplot(data = diamonds_data, aes(x = diamonds_data$carat, y = residuals_rev2b)) + geom_point() + ggtitle("Residuals vs Carat") + xlab("Carat") + ylab("Residuals")
#### Since this does not give a random scatter around 0, we can conclude that ln(price) and carat are not linearly related

### check for homoskedasticity
ggplot(data = mlr_rev2b, aes(x = mlr_rev2b$fitted.values, y = residuals_rev2b)) + geom_point() + ggtitle("Residuals vs Fitted Values") + xlab("Fitted Values") + ylab("Residuals")

#### variance is comparatively constant but the plot seems to show a relationship between the residuals and the fitted values implying that the regressor and response might not be linearly related.

# MLR Model Revision 3 ----

## Based on the model revisions 2a and 2b we can clearly see that the ln(price) is able to provide us with homoskedasticity, we also see a logarithimic relationship between ln(price) and carat, suggesting us the next transformation on the regressor as ln(carat) and that is what we proceed with.

diamonds_data$log_carat <- log(diamonds_data$carat)

## MLR for ln(price) witn ln(carat)
mlr_rev3 <- lm(log_price ~ log_carat + cut + clarity + color, data = diamonds_data)
summary(mlr_rev3)
### Residual Standard Error: 0.1656 on 210620 deg of freedom
### Adjusted R-sq : 98.13%
### p-value of the model: < 2.2e-16
anova(mlr_rev3)
### RSS: 5776 on 210620 deg of freedom

plot(diamonds_data$log_carat, diamonds_data$log_price)

## model adequacy
residuals_rev3 <- studres(mlr_rev3)

### checking for normality of residuals (qqplot)
tdist(residuals = residuals_rev3, data = diamonds_data, 4)
qqnorm(residuals_rev3)
qqline(residuals_rev3)
#### The t-distribution and the QQPlot shows that the residuals are normally distributed but with fat tails.

### checking linear relationship between ln(price) and ln(carat)
ggplot(data = diamonds_data, aes(x = diamonds_data$log_carat, y = residuals_rev3)) + geom_point() + ggtitle("Residuals vs ln(carat)") + xlab("ln(carat)") + ylab("Residuals")
#### We can see random scatter around 0, hence we can conclude that ln(price) and ln(carat) are linearly related

### check for homoskedasticity
ggplot(data = mlr_rev3, aes(x = mlr_rev3$fitted.values, y = residuals_rev3)) + geom_point() + ggtitle("Residuals vs Fitted Values") + xlab("Fitted Values") + ylab("Residuals")
#### variance is constant.

# Check for Multicollinearity ----

vif(mlr_rev3)
### The VIF does not indicate any multicollinearity among the 4Cs

avPlots(mlr_rev3)
### The added-variable plots do not indicate any multicollinearity among the 4Cs

mlr_matrix <- model.matrix(mlr_rev3)
cor(mlr_matrix[,-1])
#### The correlation matrix give us an idea about the relationships between different regressors of the model.
#### If positive value exists between 2 attributes, this shows that if one attribute increases, then second attrbute will increase in same direction for for negative value it will be visa-versa
#### If magnitude of the correlation is huge (close to 1), this will shows that the two attributes are heavly coorelated and multicollinearlity will exist.

ggpairs(data = diamonds_data, columns = c(1,2,3,4,6,7), upper = list(continuous = 'cor'))
#### ggpairs provide graphical representation of correlation matrix. For example, color vs log_carat will show log of carat values for different levels of color.

# Check for the significance of each regressor (Partial F-tests) ----

## Significance of Cut
mlr_without_cut <- lm(log_price ~ log_carat + clarity + color, data = diamonds_data)
anova(mlr_without_cut, mlr_rev3)
## p-value: < 2.2e-16
## At 95% significance, the p-value on ANOVA of the models clearly indicates that cut is a statistically significant regressor 

## Significance of Clarity
mlr_without_clarity <- lm(log_price ~ log_carat + cut + color, data = diamonds_data)
anova(mlr_without_clarity, mlr_rev3)
## p-value: < 2.2e-16
## At 95% significance, the p-value on ANOVA of the models clearly indicates that clarity is a statistically significant regressor

## Significance of Color
mlr_without_color <- lm(log_price ~ log_carat + cut + clarity, data = diamonds_data)
anova(mlr_without_color, mlr_rev3)
## p-value: < 2.2e-16
## At 95% significance, the p-value on ANOVA of the models clearly indicates that color is a statistically significant regressor

# ln(price) vs ln(carat) Plots ----

## ln(price) vs ln(carat) highlighting cut
ggplot(data = diamonds_data, aes(x = diamonds_data$log_carat, y = diamonds_data$log_price)) + geom_jitter(aes(color = cut)) + xlab("ln(carat)") + ylab("ln(price)") + ggtitle("ln(price) vs ln(carat) [Highlighting Cut]")

## ln(price) vs ln(carat) highlighting clarity
ggplot(data = diamonds_data, aes(x = diamonds_data$log_carat, y = diamonds_data$log_price)) + geom_jitter(aes(color = clarity)) + xlab("ln(carat)") + ylab("ln(price)") + ggtitle("ln(price) vs ln(carat) [Highlighting Clarity]")

## ln(price) vs ln(carat) highlighting color
ggplot(data = diamonds_data, aes(x = diamonds_data$log_carat, y = diamonds_data$log_price)) + geom_jitter(aes(color = color)) + xlab("ln(carat)") + ylab("ln(price)") + ggtitle("ln(price) vs ln(carat) [Highlighting Color]")
