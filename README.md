Programming Assignment 3 - 'Getting and Cleaning Data'

The file 'run_analysis.R' has all the code required to carry out this assignment.  The script includes the following steps -

	1) A function 'genDF' is defined, and it can be used to assemble all the components needed for either the 'test' or 'train' Human Activity Recognition datasets.  The function requires three parameters - 1) 'modelUse', which indicates whether the data is for the 'train' or 'test' subjects, 2) 'axis', which indicates the directional axis of the sensor measurement ('x', 'y', 'z'), and 3) 'sensorType', which	indicates the type of sensor signal ('body_acc', 'total_acc', 'body_gyro') acquired.  Note that both the 'test' and 'train' subject groups have nine individual data files holding the processed signal readings for each combination of 'axis' and 'sensorType'.  Therefore, the 'genDF' function must be used nine times (as described in the next section) to produce both the 'test' and 'train' data subsets.
	
	2) The function 'genDF' is called to generate a data frame for each combination of 'axis' and 'sensorType' in the 'test' data.  As each data frame is created (except for the first one), it is concatenated with the previously created data frames to produce the full 'test' dataset.  Note the 'test' data has 26523 observations.
	
	3) The function 'genDF' is called to generate a data frame for each combination of 'axis' and 'sensorType' in the 'train' data.  As each data frame is created (except for the first one), it is concatenated with the previously created data frames to produce the full 'train' dataset.  Note the 'train' data has 66168 observations.
	
	4) The 'test' and 'train' data frames are combined into a single complete dataset with all 92691 observations.
	
	5) All derived features (i.e., the features computed from the processed sensor readings) are discarded except for those involving either the mean or standard deviation of the measurement.
	
	6) The 'activity IDs' are converted from integer categories to their corresponding word descriptions (i.e., 'WALKING', 'WALKING_UPSTAIRS', etc).
	
	7) The variables for each of the 128 sensor readings in each observation window are renamed to indicate they are 'Readings'.
	
	8) Some special characters in the feature names are modified to prevent misinterpretation by 'R'.

All input files required for execution of 'run_analysis.R' are described in the accompanying codebook.  The codebook also describes the dataset's variables in more detail.	