libname analysis "H:\windows\Lab Datasets 2018";
run;

libname original "H:\windows\Lab Datasets 2018";
run;

proc contents data=analysis.hospital;
run;

/*Creating a new dataset called "hospital1" based on "hospital" such that it only has age, antinio, bact_cul, dur_stay, ID*/;

data analysis.hospital1;
	set analysis.hospital(drop=service sex temp wbc);
run;

/*Creating a new dataset called "hospital2" based on "hospital" such that it only has ID, service sex temp wbc*/

data analysis.hospital2;
	set analysis.hospital (keep= ID service temp WBC);
run; 

/*Merging hospital 1 and hospital 2 by ID*/

proc sort data=analysis.hospital1;
by id;
run;

proc sort data=analysis.hospital2;
by id;
run;

data analysis.hospital3;
	merge analysis.hospital1 andalysis.hospital2;
	by ID; 
run; 

proc freq data=analysis.hospital;
	tables age;
run; 

/*The drop and keep statements serve the same purpose. You can choose which one to use depending 
on the number of variables to drop or keep/*


/*Now, lets convert the continuous variable age into 4 distinct dummy variables. We need to make one group the reference group.*/

data analysis.hospital;
	set analysis.hospital;
	if age LE 30 then age1=1;
	else age1=0;

	if age GE 31 and age LE 50 then age2=1;
	else age2=0;

	if age GE 51 and age LE 70 then age3=1;
    else age3=0;

	if age GE 71 then age4=1;
	else age4=0;
run; 

proc freq data=analysis.hospital;
	tables age1 age2 age3 age4;
run; 

/*Another way to view different variables is through: Grouped linear variables*/

data analysis.hospital;
	set analysis.hospital;
	if age LE 30 then agenew=0;
	if age GE 31 and age LE 50 then agenew=1;
	if age GE 51 and age LE 70 then agenew=2;
	if age GE 71 then agenew=3;
run;

proc freq data=analysis.hospital;
	tables agenew;
run;

/*Regression between dummy variables and duration of stay, We do not have to add age1 because it is our reference group*/

proc reg data=analysis.hospital;
	model dur_stay = age2 age3 age4;
run;

