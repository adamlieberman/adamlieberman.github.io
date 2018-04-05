libname original "H:\windows\Lab Datasets 2018";
libname analysis "H:\windows\Lab Datasets 2018";
run;

data analysis.hospital;
	set original.hospital;
run;

/*Check the contents of dataset, sorta like proc print*/
proc contents data=analysis.hospital;
title "JUST CHECKING";
RUN;

proc freq data=analysis.hospital;
tables service dur_stay/missing;
title "just checking";
run;

/*Always run initial print statement to check for errors*/
proc print data=analysis.hospital;
run;

/*Run a regression model to see if there is an association between 2 variables, clb+gives confidence intervals*/
proc reg data = analysis.hospital;
	model dur_stay = service /clb;
	title 1 "Model 1: Regression of type of Service against Duration of Stay"; 
	title 2 "service is coded 1=medical 2=surgical";
run;

/*Step 3: Model 2*/
data analysis.hospital;
	set analysis.hospital;
	service2 = service-1;/*one of several ways to make the new variable*/
run;
 /* This way we are recoding service into 0 and 1, instead of 1 and 2. Can alse do this using if/then statements.*/

proc freq data=analysis.hospital;
	tables service2*service/missing;
	title "checking service2 coding";
run;
/*Will give us 2x2 table with service 2 on one side and service on the other*/

proc reg data = analysis.hospital;
	model dur_stay = service2 /clb;
	title 1 "Model 2: Regression of duration of stay against type of service"; 
	title 2 "service is coded 0=medical 1=surgical";
run;

/*step 4; model 3*/
proc reg data =analysis.hospital;
	model dur_stay = age/clb;
	title "Model 4. regression of duration of stay against age";
run;

/*step 4; model 4*/
proc reg data=analysis.hospital;
	model dur_stay = service age /clb;
	title "Model 4. regression of duration of stay against age";
run;

/*after adjusting for age, surgical is 2.5 less than medical for duration of stay*/
/*after adjusting for service, every unit increase in age has o.7 greater duration of stay*/
/*but neither are statistically significant*/
