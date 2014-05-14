# Code Book for tidy "Human Activity Recognition Using Smartphones" Data Set

## Data origins
Thirty human subjects were measured while performing six different basic physical activities by a smartphone (Samsung Galaxy S II) they were wearing on the waist. Measurements were taken of their bodies' linear acceleration and angular momentum using the embedded accelerometer and gyroscope of the smartphone. Both measurements were captured along three axes (X, Y and Z) at a constant rate of 50Hz. The experiments were video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See variables below for more detail.

### Reference
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.


## Transformations performed on the data

* The train and test subjects were merged together in one data set.
* Only the means and standard deviations of the time and frequency features have been retained. All other variables have been removed.
* Activity identifiers (numbers) have been replaced by activity descriptors.
* Feature identifiers (numbers) have been replaced by full descriptive names, containing information on original signal, domain and calculations performed.
* Averages have been taken over all instances in which the same subject performed the same activity, so that the tidy data set contains one row per subject per activity.

## Variables in the tidy data set

The tidy data set contains one row for each subject performing one particular activity.

Every row in the data set has a value for the following variables:

subject 1
        Number of Human Test Subject
        1..30 .Identifier of the subject who carried out the experiment.
        
activity 34
        Physical activity or movement performed by subject while wearing smartphone on the waist
        WALKING .Walking
        WALKING_UPSTAIRS  .Walking upstairs
        WALKING_DOWNSTAIRS  .Walking downstairs
        SITTING .Sitting down
        STANDING  .Standing up
        LAYING  .Laying down
        
timebodyaccelerationmeaninxdirectionaverage 
        Mean linear acceleration of the subject's body in the x direction (normalized), averaged over all occassions subject performed the same activity
        [-1,1]
        
