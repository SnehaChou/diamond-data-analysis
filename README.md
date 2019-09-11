# Diamond Data Analysis

## Data Source: 

This dataset was taken from a diamond retailer's website.

## Contributors:

This project was worked upon by the following 4 members together as a team:
- Siddharth Suresh
- Sneha Choudhary
- Suchetha Sharma
- Vidhi Gupta

## Context:

The intent of the project was to use regression modeling to understand the effect of the 4Cs (carat, color, clarity and cut) on the price of a dimaond.

**Our Questions:**

1. What determines the price of diamond? Do the 4Cs actually impact the price? If yes, are these enough to determine the price of a diamond?
2. Do the 4Cs have an equal impact on the price of a diamond? If not:
   1. Is there an order of importance? 
   2. Are the individual levels in line with our business understanding?
   3. Which of the 4Cs has the largest impact on price of a diamond?
   4. Which of the 4Cs has the smallest impact on price of a diamond?
3. Can the price of a diamond be predicted with a regression model using only the 4Cs? If yes, how close can a model get to the price using only the 4Cs?
4. Does the distribution of diamonds in the dataset convey something about retailer's supply strategy or inventory?

## Conclusions from the analysis:

1. **What determines the price of diamond? Do the 4Cs actually impact the price? If yes, are these enough to determine the price of a diamond?**

While the price of a diamond could be explained by more than just the 4Cs, each of the 4Cs do have a positive impact on the price.

2. **Do the 4Cs have an equal impact on the price of a diamond? If not:**
   1. **Is there an order of importance?**
   2. **Are the individual levels in line with our business understanding?**
   3. **Which of the 4Cs has the largest impact on price of a diamond?**
   4. **Which of the 4Cs has the smallest impact on price of a diamond?**

The 4Cs do not seem to have an equal importance on price. Carat has the largest impact on price among the 4Cs keeping everything else constant. Amongst the qualitative attributes, keeping everything else constant at a reference level of a Good/SI2/J diamond, the “Flawless” clarity and “Very Good” cut have the largest and smallest impact on price respectively.

3. **Can the price of a diamond be predicted with a regression model using only the 4Cs? If yes, how close can a model get to the price using only the 4Cs?**

With the current model v.3 used for this project, diamond prices cannot be predicted accurately using the 4Cs.  However, based on the recommendations listed above, there is future scope of work to improve the current model to be able to possibly predict diamond prices using only the 4Cs.

4. **Does the distribution of diamonds in the dataset convey something about retailer's supply strategy or inventory?**

We think that retailer’s supply strategy maybe focused more towards superior brilliance (as defined by cut) and superior transparency (as defined by color) at the lowest price. In order to drive down the prices for such superior quality diamonds however, more than 99% of retailer’s diamonds are less than 5.0 carats and about 70% of the them are in the lower spectrum of clarity. Also, 97.9% of these diamonds are priced less than $40,000  and 89.9% are less than $10,000 which shows retailer’s inclination to supplying diamonds to a wide audience rather than branding themselves in luxury category.