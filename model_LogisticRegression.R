
## set the seed 
set.seed(123)

library(MASS)
library(caret)
library(tidyverse)

data <- read.csv("AllFeatures.csv")

data$icd9_code <- ifelse(data$icd9_code == 996,1,0)

removeCalls = c("subject_id","hamn_id","icustay_id","seq_num")

data[ ,removeCalls] <- list(NULL)

#split: 75% of the sample size
smp_size <- floor(0.75 * nrow(data))

train_ind <- sample(seq_len(nrow(data)), size = smp_size)

train <- data[train_ind, ]
test <- data[-train_ind, ]

#  model
model <- glm(icd9_code ~., data = train, family = binomial)
coef(model)

# stepwise
step.model <- model %>% stepAIC(trace = FALSE)
coef(step.model)

cols <- c("marital_status","hospital_expire_flag","los","gender","congestive_heart_failure","cardiac_arrhythmias","hypertension",
          "diabetes_uncomplicated","renal_failure","liver_disease","lymphoma","metastatic_cancer","rheumatoid_arthritis",
          "blood_loss_anemia","alcohol_abuse","drug_abuse","psychoses","TotalCO2","Glucose","Lactate","PCO2",
          "PO2","Temperature","Centromere","Creatinine","BloodLipase","BloodMagnesium","PlateletCount","RedBloodCells","WhiteBloodCells")

probabilities <- predict(step.model, test, type = "response")
predicted.classes <- ifelse(probabilities > 0.5, 1, 0)

table(predicted.classes,test$icd9_code)


data2 <- data[,cols]

#sample data set
x = data[,cols]
y = data[,"icd9_code"]

downSamp <- downSample(x,as.factor(y))

data2 <- downSamp

#split: 75% of the sample size
smp_size <- floor(0.75 * nrow(data2))

train_ind2 <- sample(seq_len(nrow(data2)), size = smp_size)

train2 <- data2[train_ind2, ]
test2 <- data2[-train_ind2, ]

model2 <- glm(Class ~., data = train2, family = binomial)
coef(model2)

probabilities2 <- predict(model2, test2, type = "response")
predicted.classes2 <- ifelse(probabilities2 > 0.5, 1, 0)

cm <- table(predicted.classes2,test2$Class)
cm
sum(diag(cm))/sum(cm)
