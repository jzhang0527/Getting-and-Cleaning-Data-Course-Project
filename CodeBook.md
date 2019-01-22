#Codebook

The original data set was transformed in the following steps:

1. Training set and testing set were combined together by 
first joining independent variables/predictors Xs with the dependent variables/outcomes Y and subject ID,
then apending records to each other.

2. The data set then was filtered to only have variables that are mean or standard deviation of each measurements.

3. The dependent variables/outcomes Y was then labeled with actual activity names instead of numeric codes.

4. More descriptive names were used to update the original column names.

5. All variables were averages on Subject, Activity level so that each combination of Subject and Activity will only have one record in the data set.

