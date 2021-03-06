PROC IMPORT OUT= WORK.GD1
		DATAFILE= "H:\windows\505master2017.csv"
		DBMS=CSV REPLACE;
	GETNAMES=YES;
	DATAROW=2;
RUN;

OPTIONS LS=80 PS=60;

PROC PRINT DATA=GD1;
RUN;
PROC MEANS DATA=GD1;
	VAR BFED CHOL SEX YRSEDUC AGE RACE;
RUN;
DATA GD2; SET GD1;
	IF BFED NE . AND
	   CHOL NE . ;
	IF BFED NE 8 AND
	   BFED NE 9;
	IF CHOL < 400;
*^^^^getting rid of missing data (chol & bfed), cut off for chol outliers;
PROC PRINT DATA=GD2;
RUN;

DATA GD3;
	SET GD2;
	IF AGE<56 THEN AGE2='LESS THAN 55';
	IF AGE>55 THEN AGE2='GREATER THAN 55';

PROC PRINT DATA=GD3;
RUN;
*^^^^^creating a new categorical variable for age (splits at age=55);
PROC MEANS DATA=GD3;
	VAR SEX AGE RACE YRSEDUC CHOL;
RUN;
*^^^^Looking at different variables without stratifying for another (i.e. breastfed, etc.);
PROC MEANS DATA=GD3;
	VAR SEX AGE RACE YRSEDUC CHOL;
	CLASS BFED;
RUN;
PROC MEANS DATA=GD3;
	VAR SEX;
	CLASS SEX BFED;
RUN;
*^^^^Looking at one variable with multiple levels while stratifying for one other class variable (i.e. breastfed);
PROC TTEST DATA=GD3;
	CLASS BFED;
	VAR CHOL;
	TITLE1 "Association between Breastfeeding and Cholesterol Levels";
RUN;
*^^^^crude relationship between bfed & chol;
PROC SORT DATA=GD3;
	BY SEX;
RUN;
*^^^^Sorting data to allow SAS to stratify for sex;
PROC TTEST DATA=GD3;
	CLASS BFED;
	VAR CHOL;
	BY SEX;
	TITLE1 "STRATIFIED BY SEX";
RUN;
*^^^^Stratified T-Test (by Sex);
PROC SORT DATA=GD3;
	BY AGE2;
RUN;
*^^^^Sorting data to allow SAS to stratify for age (categorically);
PROC TTEST DATA=GD3;
	CLASS BFED;
	VAR CHOL;
	BY AGE2;
	TITLE1 "STRATIFIED BY AGE";
RUN;
*^^^^Stratified T-Test (by Age);
PROC REG DATA=GD3;
	MODEL CHOL=BFED / STB P;
	TITLE1 "Crude Regression Analysis";
RUN;
*^^^^Crude linear regression analysis for breastfed and cholesterol;
PROC REG DATA=GD3;
	MODEL CHOL=BFED AGE SEX YRSEDUC / STB P;
	TITLE1 "Regression Adjusted Stratified by Age,Sex,Education";
RUN;
*^^^^Adjusted linear regression analysis by age, sex and education;
PROC SORT DATA=GD3;
	BY RACE;
RUN;
PROC REG DATA=GD3;
	MODEL CHOL=BFED / STB P;
	BY RACE;
	TITLE1 "Race-Stratified Regression";
RUN;
*^^^^Crude race-stratified linear regression analysis;
PROC REG DATA=GD3;
	MODEL CHOL=BFED AGE SEX YRSEDUC / STB P;
	BY RACE;
	TITLE1 "Race-Stratified Regression by Age,Sex, Years of Education";
RUN;
*^^^^Race-stratified linear regression analysis adjusted by age, sex and education;
