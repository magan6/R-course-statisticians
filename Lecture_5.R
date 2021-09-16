library(tidyverse)
library(devtools)
install_github("lukketotte/StatProg")
library(StatProg)

### Tibbles vs. data frames ###
# tibble is like a data frame but more user-friendly
# better printing method

class(movies)
movies

movies_df <- as.data.frame(movies)
movies_df


tibb <- tibble(x1 = c("one", "two", "three"), y = 1:3)
tibb
tibb$x1
tibb$x

tibb_df <- as.data.frame(tibb)
tibb_df
tibb_df$x1
tibb_df$x # for df it works to write only a part of the name, but can be risky

tibb_df$x1 # vector
tibb_df[, "x1"] # vector
tibb_df[, c("x1", "y")] # data frame

tibb$x1 # vector
tibb[, "x1"] # tibble (this could be good!)
tibb[, c("x1", "y")] # tibble


data.frame('Hej' = 1:3,
           '2002' = 2:4)
tibb <- tibble('Hej' = 1:3,
               '2002' = 2:4)
tibb
tibb$Hej


### Exercises
# 1) How can you tell if an object is a tibble?
class(movies)

# 2) Practice referring to non-syntactic names in the following data frame by:
annoying <- tibble(
  '1' = 1:10,
  '2' = '1' * 2 + rnorm(10)
)
annoying
# 2.1) Extracting the variable called 1

# 2.2) Plotting a scatterplot of 1 vs 2



### Importing data ###
# some useful tools
parse_integer(c("€25", "25$", "25%")) # don't work
parse_number(c("€25", "25$", "25%"))

parse_number("1,25")
default_locale()
parse_number("1,25", locale = locale(decimal_mark = ","))

parse_number("10.000,25", locale = locale(decimal_mark = ","))

parse_number("8'000'000")
parse_number("8'000'000", locale = locale(grouping_mark = "'"))


# Import data
setwd("~/Documents/R-kursen (Master)")
rb <- read_csv2("riksbank.csv")
spec(rb)
rb

# date is parst as character vector... how do we solve this?
?read_csv2
vignette("readr")
?col_date

rb <- read_csv2("riksbank.csv", col_types = cols(
  Date = col_date(format = "%d/%m/%Y"), # we change this to get it like Dates
  Group = col_character(),
  Series = col_character(),
  Value = col_double()
))
rb

## Import 2 - use tsv since it is tab-separated file 
rb2 <- read_tsv("riksbank_comma.txt", col_types = cols(
  Date = col_date(format = "%d/%m/%Y"),
  Group = col_character(),
  Series = col_character(),
  Value = col_number()
)
, locale = locale(decimal_mark = ","))
# we also change Date and Value to get the format right in the import of the data


### Tidy data ###
# load from the StatProg package "data(table*, package = "StatProg")
table1 # looks tidy
data(table2, package = "StatProg")
table2  # not tidy...
data(table3_top1, package = "StatProg") 
table3_top1 # not tidy
table3_top10 # not tidy

# The pipe operator %>%
x <- 1:10
mean(x)

x %>% mean()

# get %>%  by: control+shift+m

# with pipe operator
table1 %>% 
  filter(country == "Sweden", year == 2000) %>% 
  select(top_1)
# without (harder to read and understand... than pipe op)
select(filter(table1, country == "Sweden", year == 2000), top_1)


### lets make the tables tidy!
table2
table2 %>%
  pivot_wider(names_from = type, values_from = share)

table3_top1
table3_top10
table3_top1 %>% 
  pivot_longer(c("2000", "2010"), names_to = "year", values_to = "top_1")
table3_top10 %>% 
  pivot_longer(c("2000", "2010"), names_to = "year", values_to = "top_10")
# next step is to merge. Comes later into the lecture...

### Exercise
# 1) Is air_passengers tidy?
data("air_passengers", package = "StatProg")
air_passengers
# not tidy, each mounth has its own column, several obs per row...
air_passengers %>% 
  pivot_longer(Jan:Dec, names_to = "month", values_to = "passengers")

# 2) Is vote_table tidy?
data("vote_table", package = "StatProg")
vote_table
# this is a table, not a tidy data frame..


# longformat is good when we want to plot data, so get used to:
# pivot_longer
dat
ggplot(dat) + 
  geom_line(aes(time, value, color = variable)) # looks good due to long-format


dat_wide <- pivot_wider(dat, names_from = variable, values_from = value)
dat_wide # now it is on wide-format

dat_wide %>% 
  pivot_longer(A:D, names_to = "variable", values_to = "value") %>% 
  ggplot() +
  geom_line(aes(time, value, color = variable)) # and now back to long and plot it with pipe
# the code gets more readable with the pipe operator, as you can follow along and see what happens along the way


### Exercise
# Plot the top_1 and top_10 shares in a single line plot, where the share
# is differentiated by linetype and countries separated by color.
# Is it easier to use table1 or table2 for this?
table1
table2

table1 %>% 
  pivot_longer(c(top_1, top_10), names_to = "type", values_to = "share") %>% 
  ggplot(aes(year, share)) +
  geom_line(aes(linetype = type, color = country))

table2 %>% 
  ggplot(aes(year, share)) +
  geom_line(aes(linetype = type, color = country), size = 2)
# table2 is easyer beacuase it is in long format.


tab3_1 <- table3_top1 %>% 
  pivot_longer(c("2000", "2010"), names_to = "year", values_to = "top_1")
tab3_10 <- table3_top10 %>% 
  pivot_longer(c("2000", "2010"), names_to = "year", values_to = "top_10")

inner_join(tab3_1, tab3_10)
inner_join(tab3_1, tab3_10, c("country", "year")) # specify, "join by" good when we have alot of columns


tab3_1_share <- rename(tab3_1, share = top_1)
tab3_1_share
tab3_10_share <- rename(tab3_10, share = top_10)
tab3_10_share

inner_join(tab3_1_share, tab3_10_share)
inner_join(tab3_1_share, tab3_10_share, by = c("country", "year"))


table_new
inner_join(table_new, table1) # only join by existing in both datasets
inner_join(table_new, table1, by = c("country", "year"))
left_join(table1, table_new)
right_join(table1, table_new)
full_join(table1, table_new)
# this only works with two datasets, for multiple: use pipe op
