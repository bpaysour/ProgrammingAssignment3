Codebook for Programming Assignment 3 - "Getting and Cleaning Data"

I.  Data Files

The script 'run_analysis.R' requires the following input files -

	1) A set of nine data files holding the processed sensor readings for subjects assigned to the 'test' group.  One file is required for each combination of the readings' directional axis ('x', 'y', 'z') and type of sensor ('body_acc', 'total_acc', and 'body_gyro').  The files have names of the form 'body_acc_x_test.txt', 'body_acc_y_test.txt', etc.  The files consist of 128 columns of numeric data (with each row representing the full set of readings for an observation window) and there are no headers.
	
	2) A set of nine data files holding the processed sensor readings for subjects assigned to the 'train' group.  One file is required for each combination of the readings' directional axis ('x', 'y', 'z') and type of sensor ('body_acc', 'total_acc', and 'body_gyro').  The files have names of the form 'body_acc_x_train.txt', 'body_acc_y_train.txt', etc.  The files consist of 128 columns of numeric data (with each row representing the full set of readings for an observation window) and there are no headers.

	3) Two data files, 'X_test.txt' and 'X_train.txt', holding derived features computed from the processed readings for the 'test' and 'train' subjects, respectively.  The files consist of 561 columns of numeric data (with each row representing a complete observation window) and there are no headers.
	
	4) A file named 'features.txt' containing the names of each of the 561 features described in '3' above.  The file consists of two columns - an integer ID for each feature name, and the feature names themselves.  There is no header.
	
	5) Two data files, 'subject_test.txt' and 'subject_train.txt', holding the subject IDs for each observation window of the 'test' and 'train' subjects, respectively.  The files consist of a vector of integers between 1 and 30 (inclusive), with each integer corresponding to a different subject.  There is no header.
	
	6)  Two data files, 'y_test.txt' and 'y_train.txt', holding the activity IDs for each observation window of the 'test' and 'train' subjects, respectively.  The files consist of a vector of integers between 1 and 6 (inclusive), with each integer corresponding to a different activity.  There is no header.  The description for each integer value (e.g., '1' = 'WALKING') can be found in the file 'activity.labels.txt'.
	
II. Generated Data Set 1 - 'selectDF'

The data set 'selectDF' includes the following variables -

	1) 'subjectID' - an integer corresponding to the subject from whom the observation was collected.
	
	2) 'activityID' - a character string describing the type of activity performed while the observation was collected.
	
	3) 'Reading1' through 'Reading128' - numeric values for each of the processed signal readings for the observation window.
	
	4) A set of 33 mean values and a set of 33 standard deviation values for each of 33 'features' derived from the processed signal readings for the observation window.  Explanations for each of these 'features' can be found in the file 'features_info.txt'.
	
	5) 'Use' - a character string indicating whether the subject for the observation was assigned to the 'test' or 'train' group.
	
	6) 'Type' - a character string indicating the type of sensor ('body_acc', 'total_acc', and 'body_gyro') employed for the observation.
	
	7) 'Direction' - a character string indicating the directional axis ('x', 'y', 'z') for the observation.
	
III. Generated Data Set 2 - 'grouped_summary'

The data set 'grouped_summary' includes the following variables -

	1) 'subjectID' - an integer corresponding to the subject from whom the observation was collected.
	
	2) 'activityID' - a character string describing the type of activity performed while the observation was collected.
	
	3) 'Reading1' through 'Reading128' - means of the numeric values for each of the processed signal readings for the observation window, calculated for each subject-activity group (e.g., Subject 1 - WALKING) in the data.
	
	4) Means for each of the 33 mean values and each of the 33 standard deviation values computed for the 'features' described in II.4. above.