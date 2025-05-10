library(tidyverse)
library(lubridate)
library(tidyverse)
library(factoextra)
library(dbscan)
library(caret)
library(randomForest)
library(pROC)
library(cluster)

#Loading Data
data <- read.csv("C:/Users/adusa/OneDrive - University of New Haven/Documents/Business Capstone BANL 6900-04/Project/Data for Analysis.csv",
                 na.strings = c("NULL", "NA", ""))
str(data)

# Remove columns with more than 40% missing
na_threshold <- 0.4 * nrow(data)
data <- data[, colSums(is.na(data)) < na_threshold]

# Impute numeric columns with median
for (col in names(data)) {
  if (is.numeric(data[[col]])) {
    data[[col]][is.na(data[[col]])] <- median(data[[col]], na.rm = TRUE)
  } else if (is.factor(data[[col]]) || is.character(data[[col]])) {
    mode_val <- names(sort(table(data[[col]]), decreasing = TRUE))[1]
    data[[col]][is.na(data[[col]])] <- mode_val
  }
}

# Select only numeric features
num_data <- data %>% select(where(is.numeric))
scaled_data <- scale(num_data)

# Determine best K
fviz_nbclust(scaled_data, kmeans, method = "wss")

# Apply K-means with K = 2
set.seed(2025)
kmeans_model <- kmeans(scaled_data, centers = 2)
data$kmeans_cluster <- as.factor(kmeans_model$cluster)

# Visualize
fviz_cluster(kmeans_model, data = scaled_data)

#Hierarchical Clustering
d <- dist(scaled_data)
hc_model <- hclust(d, method = "ward.D2")
plot(hc_model, main = "Hierarchical Clustering", xlab = "", sub = "")

# Cut into 3 clusters
data$hclust_cluster <- as.factor(cutree(hc_model, k = 3))

# Silhouette Score for K-Means
sil <- silhouette(kmeans_model$cluster, dist(scaled_data))
mean(sil[, 3])

fviz_silhouette(sil)

# Convert target to binary factor
data$converted <- as.factor(ifelse(data$status_report == "Policycreated", 1, 0))

# Use only numeric features + target
model_data <- data %>%
  select(converted, where(is.numeric))

# Train-test split
set.seed(123)
split <- createDataPartition(model_data$converted, p = 0.7, list = FALSE)
train <- model_data[split, ]
test <- model_data[-split, ]

log_model <- glm(converted ~ ., data = train, family = "binomial")
summary(log_model)

log_probs <- predict(log_model, newdata = test, type = "response")
log_preds <- ifelse(log_probs > 0.5, 1, 0)

confusionMatrix(as.factor(log_preds), test$converted)

rf_model <- randomForest(converted ~ ., data = train, importance = TRUE)
rf_preds <- predict(rf_model, newdata = test)

confusionMatrix(rf_preds, test$converted)

# AUC-ROC
rf_probs <- predict(rf_model, test, type = "prob")[, 2]
roc_obj <- roc(as.numeric(as.character(test$converted)), rf_probs)
auc(roc_obj)






