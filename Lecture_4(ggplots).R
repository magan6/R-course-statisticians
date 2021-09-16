#################################
###### Lecture 4 - ggplots ######
#################################

# install.packeges()

library(tidyverse)
library(devtools)
install_github("lukketotte/StatProg")
library(StatProg)

# Example
#######
####
##

data(movies)
movies
?movies

# Scatterplot (budget vs. rating)
ggplot(data = movies) +
  geom_point(mapping = aes(x = budget, y = rating))

# Scatterplot, but now we seperate the variables by: if the movie is an Action movie or not
ggplot(data = movies) +
  geom_point(mapping = aes(x = budget, y = rating, color = Action))

ggplot(data = movies) +
  geom_point(mapping = aes(x = budget, y = rating, shape = Action))

ggplot(data = movies) +
  geom_point(mapping = aes(x = budget, y = rating, color = Action, shape = Action))

ggplot(data = movies) + 
  geom_point(mapping = aes(x = budget, y = rating),
             size = 2,
             color = "red",
             shape = 21,
             alpha = 0.5,
             fill = "blue",
             stroke = 2)
# alpha = opacistet
# fill = ifyllnad
# stroke = tjocklek på linjer punkterna

### Exercises ###
# Make a scatterplot of the logarithm of budget vs length
ggplot(data = movies) + 
  geom_point(mapping = aes(x = log(budget), y = length))

# Try mapping color, shape, size and alpha to rating. What happens?
ggplot(data = movies) + 
  geom_point(mapping = aes(x = log(budget), y = length,
                           color = rating, size = rating, alpha = rating))

ggplot(data = movies) + 
  geom_point(mapping = aes(x = log(budget), y = length,
                           color = rating, size = rating, alpha = rating))
# "shape" can not be used for ratring, beacuse rating is continous


### multiple layers ###
ggplot(data = movies) + 
  geom_smooth(mapping = aes(x = budget, y = rating)) # trend of the budget (average)

ggplot(data = movies) + 
  geom_point(mapping = aes(x = budget, y = rating)) +
  geom_smooth(mapping = aes(x = budget, y = rating))


scatter <- ggplot(data = movies, mapping = aes(x = budget, y = rating)) +
  geom_point()
scatter

scatter_smooth <- scatter + geom_smooth()

scatter +
  geom_point(aes(color = Action)) +
  geom_smooth(aes(color = Action))

scatter +
  geom_smooth(data = filter(movies, votes > 20000))

scatter +
  geom_smooth(method = "lm", se = FALSE)
# ads a regression line

scatter +
  facet_wrap(~vote_group)

scatter +
  facet_wrap(Action~vote_group)

### Exercises ###
# By adding layers to scatter, map the color of the points to the number of votes.
scatter +
  geom_point(aes(color = votes))

# Do the same thin again, but map the color of the points to vote_group instead.
scatter +
  geom_point(aes(color = vote_group))

# What happens to the color scale when you map point color to as.numeric(vote_group)?
scatter +
  geom_point(aes(color = as.numeric(vote_group)))

# Use facet_wrap to plot budget vs rating for each subgroup of Action and vote_group
scatter +
  facet_wrap(Action~vote_group)

# Cosult the documentation of facet_wrap to make the resulting plot be an 2 x 4 grid of subplots
?facet_wrap
scatter +
  facet_wrap(Action~vote_group, nrow = 2, ncol = 4)


#### Bar plots ####
data(titanic)
titanic

ggplot(data = titanic, mapping = aes(x = Pclass)) +
  geom_bar()

ggplot(data = titanic, mapping = aes(x = Pclass, fill = Survived)) +
  geom_bar()

bar_fill <- ggplot(data = titanic, mapping = aes(x = Pclass, fill = Survived)) +
  geom_bar(position = "fill")
bar_fill

ggplot(data = titanic, mapping = aes(x = Pclass, fill = Survived)) +
  geom_bar(position = "dodge")


#### Distribution plots ####
# Histograms
ggplot(data = titanic, mapping = aes(x = Age)) +
  geom_histogram()

ggplot(data = titanic, mapping = aes(x = Age)) +
  geom_histogram(binwidth = 5)

ggplot(data = titanic, mapping = aes(x = Age)) +
  geom_histogram(bins = 50)

# Density plot
ggplot(data = titanic, mapping = aes(x = Age)) +
  geom_density()

ggplot(data = titanic, mapping = aes(x = Age)) +
  geom_density(adjust = 0.2)
# adjust <- control the smoothness of the curve

### Exercise ###
# By adding a layer to bar_fill, create a border of black around each bar
bar_fill +
  geom_bar(color = "black")

# Construct a density plot whick displays three density curves with different colors, one for each passenger class
ggplot(data = titanic, mapping = aes(x = Age)) +
  geom_density(aes(color = Pclass))

# Make a figure with three boxplots (one for each passenger class) showing the distributions of the Fare variable
ggplot(data = titanic, mapping = aes(x = Pclass, y = Fare)) +
  geom_boxplot()


### Custumize the plots ###

# Titles etc...
bar_labs <- bar_fill +
  labs(title = "Survival of the fittest?",
       subtitle = "First-class passengers had higher rate of survival",
       caption = "Source: The Internet",
       x = "Passenger class",
       y = "Proportion",
       fill = "Survival")
bar_labs

# Scale_
bar_discrete <- bar_labs +
  scale_fill_discrete(labels = c("Did not survive", "Survived"))
bar_discrete

bar_labs +
  scale_fill_manual(values = c("red", "green"),
                    labels = c("Did not survive", "Survived"))


### Exercise ###
scatter +
  geom_point(aes(color = Action)) +
  geom_smooth(aes(color = Action)) +
  scale_color_manual(values = c("purple", "orange"),
                     labels = c("No", "Yes"))



### trim and specify the axes ###
# zoom in (y-axis between 5-7.5):
scatter_smooth +
  coord_cartesian(ylim = c(5, 7.5))
# zoom in by removing observations without the limit (5-7.5):
scatter_smooth +
  ylim(c(5, 7.5))

scatter_smooth +
  scale_y_continuous(breaks = c(3, 6, 9), labels = c("Poor", "Okey", "Great"))

bar_labs + 
  scale_x_discrete(labels = c("Fisrt", "Second", "Third"))


