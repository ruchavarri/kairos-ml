
#https://www.kaggle.com/francksylla/titanic-machine-learning-from-disaster

library(tidyverse)
library(magrittr)

train = read_csv('https://raw.githubusercontent.com/ruchavarri/kairos-ml/master/2.intro_ml/data/titanic/train.csv')
test = read_csv('https://raw.githubusercontent.com/ruchavarri/kairos-ml/master/2.intro_ml/data/titanic/test.csv')

getwd()

map_df(train, ~sum(is.na(.)))

glimpse(map_df(train, ~sum(is.na(.))))
glimpse(map_df(test, ~sum(is.na(.))))

map_df(train, is.na )

str(train)

dim(train)
dim(test)

train %<>%
    mutate(Embarked = ifelse(is.na(Embarked), median(Embarked, na.rm = TRUE), Embarked))

train %<>%
    mutate(Age = ifelse(is.na(Age), mean(Age, na.rm = TRUE), Age))

test %<>%
    mutate(Age = ifelse(is.na(Age), mean(Age, na.rm = TRUE), Age))

test %<>%
    mutate(Fare = ifelse(is.na(Fare), mean(Fare, na.rm = TRUE), Fare))

train %>%
    mutate('FamilySize' = SibSp + Parch,
           'Title' = str_extract(Name, '\\w+\\.') ) %>% select(Title)

train %<>%
    mutate('FamilySize' = SibSp + Parch,
           'Title' = str_extract(Name, '\\w+\\.') )


test %<>%
    mutate('FamilySize' = SibSp + Parch,
           'Title' = str_extract(Name, '\\w+\\.') )

names(test)

glimpse(train)
glimpse(test)

ggplot(train, aes(Title, fill = as.factor(Survived))) + 
    geom_bar() +
    theme_minimal()

title_dict = list("Mr." = "Mr.", "Miss." = "Miss", "Mrs." = "Mrs", 
                  "Master." = "Master", "Dr." = "Scholar", "Rev." = "Religious", 
                  "Col." = "Officer", "Major." = "Officer", "Mlle." = "Miss", 
                  "Don." = "Noble", "Countess." = "Noble", "Ms." = "Mrs", 
                  "Mme." = "Mrs", "Capt." = "Noble", "Lady." = "Noble", 
                  "Sir." = "Noble", "Jonkheer." = "Noble", "Dona." = "Noble")

train %<>%
    mutate('TitleGroup' = unlist(title_dict[Title]))

test %<>%
    mutate('TitleGroup' = unlist(title_dict[Title]))

ggplot(train, aes(TitleGroup, fill = as.factor(Survived))) + 
    geom_bar() +
    theme_minimal()





