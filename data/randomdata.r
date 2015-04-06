data <- read.csv("#########.csv")
sample <- sample(size = 1e4, 1:dim(data)[1], replace = TRUE)
# random sample with replacement
data <- data[sample, ]
# remove original id
data[,1] <- 1:1e4
write.csv(data, file = "random_interva4.csv", row.names = FALSE)