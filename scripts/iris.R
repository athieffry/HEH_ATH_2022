# load the iris dataset (included in base R)
data(iris)

# inspect the iris dataset
iris
type(iris)
str(iris)
dim(iris)
head(iris)
tail(iris)
summary(iris)
colnames(iris)
rownames(iris)
View(iris)

# get the “Petal.Width” column:
  # 1. still in a dataframe

  # 2. as a simple vector

# For “Petal.Width” column, calculate: sum, mean, max, min

# coerce to a matrix - what happened?
as.matrix(iris)


