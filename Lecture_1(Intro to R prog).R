#################################
########## Lecture 1 ############
#################################

### Basics ###
2 + 2

1:40

x <- 2 + 2
y <- 6 * 3
x/y

### Vectors ###
x <- c(1, 10, 8)
x
class(x)

x <- c("Hi", "there")
x
class(x)

rep(1, times = 3) # Repeat 1 three times
seq(2, 4) # Create a sequence from 2 to 4
2:4 # Equivalent 

vec1 <- rep(1:3, times = 4)
vec1

vec2 = c(vec1, 23) # append 23 to vec1
vec2


### Lists ###
list1 <- list(vec1, x) # Unnamed component
list2 <- list(first = vec1, second = x) # Named components

list1 = list(f = function(x) return(x+x), x = 2)
list1$f(list1$x)


### Matrices ###
mat1 <- matrix(vec1, nrow = 4, ncol = 3)
mat1

mat2 <- matrix(vec1, nrow = 4, ncol = 3, byrow = TRUE)
mat2

vec <- 1:3
cbind(vec, vec)
rbind(vec, vec)


### Data frame ###
df1 <- data.frame(Age = c(20, 21),
                  Citizen = c("Swedish", "British"),
                  Sex = c("Female", "Male"),
                  Employed = c(TRUE, FALSE))
df1


### Arrays ###
array1 <- array(1:8, dim = c(2, 2, 2))
array1


### Logical operations ###
3 > 3
3 >= 3
3 == 3
2 != 3

3 %in% c(1, 2, 4)

(3 < 4) & (3 > 0)

is.data.frame(df1) | is.matrix(df1)

# && and || is logical operators for scalar
1 == 1 || 2 == 3

1:2 == 1 && 2:3 == 2

# single & and | are vectorized meaning and can return a vector
((-2:2) >= 0) & ((-2:2) <= 0)

# all simply means that all the elements in the vector are true.
all(1:10 > 5)

# any simply means that any of the elements in the vector are true.
any(1:10 > 5)


### Subsetting ###
vec2 <- c(1.3, 2.3, 4.5)
vec2[c(1, 3)] # Using positive integers
vec2[-1] # Negative integers omit the elements

vec2[c(TRUE, TRUE, FALSE)]

vec2[vec2 > 3]

mat1[c(1, 2), c(2, 3)]

list2[1]
list2[[1]]
list2$first

df1[, c("Sex", "Age")]
df1[df1$Citizen == "British", ]
df1[c("Sex", "Age")]


### Mathematical operations ###
vec = c(2.5, 3, 2.86)
vec - 2
exp(vec)

mat = matrix(1:6, nrow = 2)
log(mat)


### Numerical accuracy ###
1.25 * 0.8 - 1

n <- 1:10
1.25 * (0.8 * n) - n

x <- 1:11
(sum(x^2) - 11 * mean(x)^2) / 10

x <- 1:11 + 1e10
(sum(x^2) - 11 * mean(x)^2) / 10
