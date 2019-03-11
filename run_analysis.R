###################################################################################################################
###This function reads in several files needed to construct a full 'Human Activity Recognition'	dataset for	###
###either the 'train' or 'test' subjects of the experiment.  The function requires three parameters - 		###
### 1) 'modelUse', which indicates whether the data is for the 'train' or 'test' subjects, 2) 'axis', which	###
###indicates the directional axis of the sensor measurement ('x', 'y', 'z'), and 3) 'sensorType', which		###
###indicates the type of sensor signal ('body_acc', 'total_acc', 'body_gyro') acquired.				###
###################################################################################################################

genDF <- function(modelUse, axis, sensorType) {

	setwd(paste("~\\JHU_DataScienceCourse\\CourseProjects\\Course3\\UCI HAR Dataset\\",
		modelUse,"\\Inertial Signals", sep = ""));
	readingsDF <- read.table(paste(sensorType, '_', axis, '_', modelUse, 
		'.txt', sep = ""), sep = "", header = FALSE);

	setwd(paste("~\\JHU_DataScienceCourse\\CourseProjects\\Course3\\UCI HAR Dataset\\",
		modelUse, sep = ""));
	featuresDF <- read.table(paste('X_', modelUse, '.txt', sep = ""), sep = "",
		header = FALSE);
	subjectLabels <- read.table(paste('subject_', modelUse, '.txt', sep = ""), sep = "",
		header = FALSE);
	colnames(subjectLabels) <- "subjectID";
	activityLabels <- read.table(paste('y_', modelUse, '.txt', sep = ""), sep = "",
		header = FALSE);
	colnames(activityLabels) <- "activityID";

	setwd("~\\JHU_DataScienceCourse\\CourseProjects\\Course3\\UCI HAR Dataset");
	featureLabels <- read.table('features.txt', sep = "", header = FALSE);
	colnames(featuresDF) <- featureLabels[,2];

	subDF <- cbind(subjectLabels, activityLabels, readingsDF, featuresDF);
	subDF$Use <- modelUse;
	subDF$Type <- sensorType;
	subDF$Direction <- axis;

	return(subDF);

	}

###################################################################################################################
###The function 'genDF' is first used to construct nine subsets of the 'test' data - one subset for each	###
###combination of 'axis' ('x', 'y', 'z') and 'sensorType' ('body_acc', 'total_acc', 'body_gyro').  These nine	###
###subsets are concatenated to produce the full set of 'test' data.						###
###################################################################################################################

axes <- c('x', 'y', 'z');
sensors <- c('body_acc', 'total_acc', 'body_gyro');
first <- TRUE;

for (i in axes) {
	for (j in sensors) {
		testsubset <- genDF('test', i, j);

		if (first) {
			testDF <- testsubset;
			}
		else {
			testDF <- rbind(testDF, testsubset);
			}

		first <- FALSE;
		rm(testsubset);
		}
	}

rm(axes, sensors);

###################################################################################################################
###The function 'genDF' is next	used to construct nine subsets of the 'train' data - one subset for each	###
###combination of 'axis' ('x', 'y', 'z') and 'sensorType' ('body_acc', 'total_acc', 'body_gyro').  These nine	###
###subsets are concatenated to produce the full set of 'train' data.						###
###################################################################################################################

axes <- c('x', 'y', 'z');
sensors <- c('body_acc', 'total_acc', 'body_gyro');
first <- TRUE;

for (i in axes) {
	for (j in sensors) {
		trainsubset <- genDF('train', i, j);

		if (first) {
			trainDF <- trainsubset;
			}
		else {
			trainDF <- rbind(trainDF, trainsubset);
			}

		first <- FALSE;
		rm(trainsubset);
		}
	}

rm(axes, sensors);

###################################################################################################################
###Next the 'test' and 'train' datasets are combined into one dataset, and all derived features (i.e., the	###
###variables that are computed from the processed sensor readings) are discarded except for			###
###those indicating the mean or standard deviation of the measurements.  The activity labels are converted from	###
###numeric values to the corresponding descriptive term, the dataset's sensor reading variables are renamed to	###
###allow for more obvious explanation, and some of the special characters in the derived feature variable	###
###names are modified to prevent misinterpretation by 'R'.							###
###################################################################################################################

comboDF <- rbind(testDF, trainDF);

meanFeature <- grep('mean()', colnames(comboDF), value = FALSE, fixed = TRUE);
stdFeature <- grep('std()', colnames(comboDF), value = FALSE, fixed = TRUE);
selectDF <- comboDF[, c(1:130, meanFeature, stdFeature, 692:694)];

selectDF$activityID <- sub('1', 'WALKING', selectDF$activityID, fixed = TRUE);
selectDF$activityID <- sub('2', 'WALKING_UPSTAIRS', selectDF$activityID, fixed = TRUE);
selectDF$activityID <- sub('3', 'WALKING_DOWNSTAIRS', selectDF$activityID, fixed = TRUE);
selectDF$activityID <- sub('4', 'SITTING', selectDF$activityID, fixed = TRUE);
selectDF$activityID <- sub('5', 'STANDING', selectDF$activityID, fixed = TRUE);
selectDF$activityID <- sub('6', 'LAYING', selectDF$activityID, fixed = TRUE);

colnames(selectDF)[3:130] <- sub('V', 'Reading', colnames(selectDF)[3:130], fixed = TRUE);
colnames(selectDF) <- gsub('-', '_', colnames(selectDF), fixed = TRUE);
colnames(selectDF) <- gsub('()', "", colnames(selectDF), fixed = TRUE);

###################################################################################################################
###Last a new summary dataset is computed from the finished 'selectDF' dataset - this summary dataset indicates	###
###the average value of each numeric variable in 'selectDF', by activity type ('WALKING', 'WALKING_UPSTAIRS',	###
###etc.) and by subject ID.											###
###################################################################################################################

library(dplyr);
select_tbl <- as.tbl(selectDF);
select_grouped <- group_by(select_tbl, subjectID, activityID);
grouped_summary <- summarise_at(select_grouped, vars(Reading1:fBodyBodyGyroJerkMag_std), mean);

###################################################################################################################
###Write both the full dataset and the summarized dataset to files.						###
###################################################################################################################

setwd("~\\JHU_DataScienceCourse\\CourseProjects\\Course3");
write.csv(selectDF, file = 'HumanActvityRecognition_selectedVars.csv', quote = FALSE,
	row.names = FALSE);
write.csv(grouped_summary, file = 'HumanActvityRecognition_summarizedVars.csv', quote = FALSE,
	row.names = FALSE);
