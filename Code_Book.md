#Talaat_G-C-Data_CourseProjectRepo

## Intro:

The script `run_analysis.R`performs the course project described steps

* 1st,similar data sets are merged using the `rbind()` function.
* Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from `features.txt`.
* As activity data is addressed with values 1:6, we take the activity names and IDs from `activity_labels.txt` and they are substituted in the dataset.
* On the whole dataset, those columns with vague column names are corrected.
* Finally, we generate a new dataset with all the average measures for each subject and activity type. The output file is called `AveragesData.txt`, and uploaded to this repository.

## Variables:

* `xTrain`, `yTrain`, `xTest`, `yTest`, `sub_Train` and `sub_Test` contain the data from the downloaded files.
* `xData`, `yData` and `sub_Data` merge the previous datasets to further analysis.
* `fet` contains the correct names for the `xData` dataset, which are applied to the column names stored in `m_St_Fet`, a data vector used to extract the needed data.
* A similar approach is taken with activity names through the `activity` variable.
* `wholeData` merges `xData`, `yData` and `sub_Data` in a single dataset.
* Finally, `AveragesData.txt` contains the relevant averages for each variable. `ddply()` from the plyr package is used to apply `colMeans()` and return the data in a new data frame.
