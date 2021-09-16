#################################
########## Lecture 2 ############
#################################

### if statements
# Looks like this form:
if (condition) {
  do something
} else {
  do something else
}


x <- 2
if (x != 0) {
  1/x
} else {
  print("Division by 0 is not allowed")
}

x <- rnorm(3, mean = 1, sd = 1) # Three numbers drown from N(0,1)
if (all(x > 0)) {
  log(x)
} else {
  print("At least one element is negative.")
}

x <- 3
if (x == 3) {
  print("It's true!")
} else {
  print("It's false")
}

x <- 4
if (x == 3) {
  print("It's true!")
} else {
  print("It's false")
}

x <- rnorm(20)
if (any(x < 0)) {
  x[x < 0]
}

if (any(x < 0)) {
  x[x < 0] <- -x[x <0]
}
x


### Loops ###
for (i in 1:3) {
  print(i)
}

x <- numeric(4) # Empty vector
for (i in 1:4) {
  x[i] <- 4*i
}
x

x <- rnorm(1000)
sumx <- 0
for (i in 1:1000) {
  sumx <-  sumx + x[i]
}

lognumbers <- c()
for (i in 1:10) {
  x <- rnorm(1, mean = 1, sd = 1)
  if (x > 0) {
    lognumbers <- c(lognumbers, log(x))
  }
}
lognumbers

for (i in 1:4) {
  print(i^2)
}

x <-  rnorm(1000)
sumx <- 0
for ( i in 1:length(x)) {
  sumx <- sumx + x[i]
}
sumx

# loop within a loop
for (i in 1:4) {
  for (j in 1:2) {
    i^j
  }
}

i <- 1
while (i^2 <= 9)
{
  cat(i, "squared is", i^2, "\n") # similar to print
  i <- i + 1
}

# ifelse()
x = rnorm(10)
for(i in 1:length(x)){
  if(x[i] > 0){
    x[i] = 1
  } else {
    x[i] = 0
  }
}
x
# same as above but much shorter code!
x = rnorm(10)
ifelse(x > 0, 1, 0)


### Excercise
y <- numeric(100)
for (t in 2:100) {
  y[t] <- 0.5 * y[t-1] + rnorm(1)
}
y

A <- matrix(0, 4, 5)
for(i in 1:4) {
  for(j in i:(i + 1)) {
    if (i == j) {
      A[i, j] <- 0.5
    } else {
      A[i, j] <- 1
    }
  }
}
A

y <- A %*% rnorm(5)
y


### Functions ###
division <- function(num, denom) {
  return(num/denom)
}
division(4,2)


example <- function() {
  x = "something"
  y = "something else"
  z = "completly different"
  return(z)
}
example()


x <- 2
square <- function(){
  return(x^2)
}
square()

# parameters with default values LAST!
bad = function(a = "a", x){
}

good = function(x, a = "a"){
}

# More examples of functions:
x <- rnorm(1000)

variance <- function(x) {
  n <- length(x) # Number of obs
  res <- sum((x - mean(x))^2) / (n-1) # Sample variance
  return(res)
}
variance(x)

variance <- function(x, unbiased = TRUE) {
  n <- length(x) # Number of obs
  if (unbiased) {
    res <- sum((x - mean(x))^2) / (n-1) # Sample variance (unbiased)
  } else {
    res <- sum((x - mean(x))^2) / n # Sample variance (ML)
  }
  return(res)
}
variance(x)
variance(x, unbiased = FALSE)


### Exercise (for more good but extensive exerc, look slides 39-44)
variance <- function(x, unbiased = TRUE){
  if (is.vector(x) && is.numeric(x)){
    n <- length(x) # Number of observations
    if (unbiased){
      res <- sum((x - mean(x))^2)/(n - 1) # Sample variance (unbiased)
      } else {res <- sum((x - mean(x))^2)/n # Sample variance (ML)
      }
    return(res)
  } else {
    stop("x is not numeric and/or a vector.")
  }
}
variance(xx)

# return multiple objects in a list
variance2 <- function(x) {
  n <- length(x) # Number of obs
  res <- list(unbiased = NULL, ML = NULL) # Empty list to fill
  res$unbiased <- sum((x - mean(x))^2) / n # unbiased version
  res$ML <- sum((x - mean(x))^2) / n       # ML version
  return(res)
}
variance2(x)



### Save your work, slides: 45 - 49

### R packages, slides: 50 - 54



