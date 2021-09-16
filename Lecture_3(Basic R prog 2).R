#################################
########## Lecture 3 ############
#################################

### About: Environments
     # global & local environments


### Implement an Algorithm

# sorting algorithm
x <- c(5, 3, 2, 6, 4)
# Step 1
swap <- x[1] # value of the first element
minpos <- which.min(x) # index of the minimum
x[1] <- x[minpos] # Put minimum in the first element
x[minpos] <- swap # Put the old first element where the minimum was
x
# Step 2
swap <- x[2] # value of the second element of x
minpos <- which.min(x[2:5]) + 1 # +1 here to get position in full vetor
x[2] <- x[minpos] # put minimum in second element
x[minpos] <- swap # put the old second element where min was 
x

# implement this in a for loop:
x <- c(5, 3, 2, 6, 4)

for (i in 1:5) {
  swap <- x[i]
  minpos <- which.min(x[i:5]) + i - 1
  x[i] <- x[minpos]
  x[minpos] <- swap
}
x

# even nicer in a function:
sorting <- function(x) {
  m <- length(x)
  for (i in 1:m) {
    swap <- x[i]
    minpos <- which.min(x[i:m]) + i - 1
    x[i] <- x[minpos]
    x[minpos] <- swap
  }
  return(x)
}
x <- c(5, 3, 2, 6, 4)
sorting(x)

## Advance example of a sorting algorithm
quickSort <- function(x) {
  pivot_val <- seq_along(x) [floor(length(x)/2)]
  pivot <- x[pivot_val]
  x <- x[-pivot_val]
  left <- x[which(x <= pivot)]
  right <- x[which(x > pivot)]
  if (length(left) > 1) {
    left <- quickSort(left) # call itself
  }
  if (length(right) > 1) {
    right <- quickSort(right) # call itself
  }
  return(c(left, pivot, right))
}

x = runif(10000)
quick_start = Sys.time() # get current time from machine
quickSort(x)
quick_end = Sys.time()

slow_start = Sys.time()
sorting(x)
slow_end = Sys.time()


### Debugging, slides: 21 - 23


### Don't repeat yourself, slides: 23 - 
# write an loop/function instead of repeating yourself
set.seed(123)
df <- data.frame(replicate(6, sample(c(1:10, -99), 6, rep = TRUE)))
names(df) <- letters[1:6]
df
# don't repeat you lik this...
df$a[df$a == -99] <- NA
df$b[df$b == -99] <- NA
df$c[df$c == -99] <- NA
df$d[df$d == -99] <- NA
df$e[df$e == -99] <- NA
df$f[df$f == -99] <- NA
df
# do like this instead
fix_missing <- function(x){
  x[x == -99] <- NA
  return(x)
}
fix_missing(df)

# better than
df$a <- fix_missing(df$a)
df$b <- fix_missing(df$b)
df$c <- fix_missing(df$c)
df$d <- fix_missing(df$d)
df$e <- fix_missing(df$e)
df$f <- fix_missing(df$f)


# OR BETTER, use the apply family functions:
df2 <- apply(X = df, MARGIN = 2, FUN = fix_missing)
as.data.frame(df2)
# problem with apply() is that i returns a matrix...

# lapply() returns a list, so we can avoid the problem by
as.data.frame(lapply(df, FUN = fix_missing))
# otherwise we get this... not so nice for us
lapply(X = df, FUN = fix_missing)


### Exercise
x <-matrix(rnorm(500, sd = 10), 50, 10)
x

normalize <- function(x) {
  (x - mean(x)) / sd(x)
}
x_norm <- apply(X = x, MARGIN = 2, FUN = normalize)
x_norm

# alternativly defining th function in the apply() call
x_norm <- apply(X = x, MARGIN = 2, FUN = function(x) (x-mean(x))/sd(x))

# varify that it works by
colMeans(x_norm)
apply(x_norm, 2, var)

### Similarly, by the "variance" function from lecture 2, we can use apply
#   to calculate the variance of every column in a matrix:
variance <- function(x, unbiased = TRUE) {
  n <- length(x) # Number of obs
  if (unbiased) {
    res <- sum((x - mean(x))^2) / (n-1) # Sample variance (unbiased)
  } else {
    res <- sum((x - mean(x))^2) / n # Sample variance (ML)
  }
  return(res)
}

apply(X = x, MARGIN = 2, FUN = variance)
apply(X = x, MARGIN = 2, FUN = variance, unbiased = FALSE)


### Creating an R package, slides 49 - 58