# IRIS EXERCICES
# Axel - 2022


# 1. load the iris dataset (included in base R) ####
data(iris)

# 2. inspect the iris dataset ####
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




install.packages('tidyverse')
library(tidyverse)


# gene expression dataframe
mat <- round(matrix(rnorm(9, mean=5, sd=1.5), nrow=3))
colnames(mat) <- c('wt_R1', 'wt_R2', 'wt_R3')
rownames(mat) <- paste0('gene_', 1:3)

tpm_norm <- colSums(mat)/10
