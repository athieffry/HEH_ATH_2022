# BASE R EXERCICES WITH THE IRIS DATASET
# Axel Thieffry - October 2022

# 1. load the iris dataset (included in base R) ####
# --------------------------------------------------
data(iris)


# 2. inspect the iris dataset ####
# --------------------------------
iris
typeof(iris)
str(iris)
dim(iris)
head(iris)
tail(iris)
summary(iris)
colnames(iris)
rownames(iris)
View(iris)


# 3. get the “Petal.Width” column ####
# ------------------------------------
# a. still in a dataframe
iris['Petal.Width']

# b. as a simple vector
iris[['Petal.Width']]
# or
iris$Petal.Width


# 4. For “Petal.Width” column, calculate: sum, mean, max, min ####
# ----------------------------------------------------------------
sum(iris$Petal.Width)
mean(iris$Petal.Width)
max(iris$Petal.Width)
min(iris$Petal.Width)


# 5. coerce to a matrix - what happened? ####
# -------------------------------------------
as.matrix(iris)


# 6. How many unique Sepal.Length measures exist? ####
# ----------------------------------------------------
length(unique(iris$Sepal.Length))
