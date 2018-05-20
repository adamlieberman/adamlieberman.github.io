libname analysis "H:\windows\Rosner";
run;
libname original "H:\windows\Rosner";
run;

proc contents data=original.swiss;
run;
data analysis.swiss; set original.swiss;
run;

data analysis.swiss;
set analysis.swiss;
if creat_72 GE 1 then highcreat=1;
if creat_72<1 then highcreat=0;
if creat_72 =. then highcreat=.;
run;

proc freq data=analysis.swiss;
tables highcreat;
run;

/*Question#2*/
proc univariate data=analysis.swiss plot;
var age;
title "age description";
run;

proc univariate data=analysis.swiss plot;
var highcreat;
title "high creati distribution";
run;

proc sgplot data=analysis.swiss;
scatter y=creat_72 X=age;
title "scatter plot of age vs. creatine in 1972";
run;

/*Question 3*/

proc freq data=analysis.swiss;
tables age;
title "checking for different paramaterization";
run;

data analysis.swiss;
	set analysis.swiss;
if age=39 then agecat=1;
else if age>39 and age <=45 the agecat=2;
else if age >45 the agecat=3;
run;

proc freq data=analysis.swiss;
tables age;
title "checking for parameterization";
run;

/*dummy variables*/
data analysis.swiss;
set analysis.swiss;
	if agecat=1 then age1=1;
	else age1=0;
	if agecat=2 then age2=1;
	else agecat=0;
	if agecat=3 then age3=1;
	else agecate=0;
run;

proc freq data=analysis.swiss;
tables age1 age2 age3;
run;

proc reg data=analysis.swiss;
model creat_72=age2 age3;
title "continuous outcome dummy variable where the lowest age group is the referant";
run;

proc logistic data=analysis.swiss/descending;
model highcreat =age2 age3/iplots lackfit scale=none aggregate rsq;
output out=diagnostics resdev reschi=reschi;
run; 
	
