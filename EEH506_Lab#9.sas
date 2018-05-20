libname analysis "H:\windows\Rosner";
run;
libname original "H:\windows\Rosner";
run;

proc contents data=original.swiss;
run;
data analysis.swiss; set original.swiss;
run;


proc univariate data=analysis.swiss plot;
var age;
title "age description";
run;	

/*find quintiles of age, make grouped linear and dummy vars*/
proc freq data=analysis.swiss ;
tables age;
title "finding quintiles";
run;


/* Find quintile cut-off points */

/*You can determine the cut off points by taking the age points at 20%, 40%, 60% and 80% of cumulative frequencies for age.*/

data analysis.swiss;
set analysis.swiss;
agecat=.;   /* linear grouping variable */
if age<=36 then agecat=1;
else if age>36 and age<=40 then agecat=2;
else if age>40 and age<=44 then agecat=3;
else if age>44 and age<=47 then agecat=4;
else if age>47 then agecat=5;
/*note coding would be different if there were missing vars*/
run;

proc freq data=analysis.swiss;
tables agecat/missing;
/*checking for expected Ns:60, 53, 66, 69, 52*/
run;

/* Dummy variables */
data analysis.swiss;
set analysis.swiss;
if agecat=1 then age1=1;
else age1=0;
if agecat=2 then age2=1;
else age2=0;
if agecat=3 then age3=1;
else age3=0;
if agecat=4 then age4=1;
else age4=0;
if agecat=5 then age5=1;
else age5=0;
/*note coding would be different if there were missing vars*/
run;


proc freq data=analysis.swiss;
tables age1 age2 age3 age4 age5;
/*checking for expected Ns:60, 53, 66, 69, 52*/
run;

/*describing X/Y relationship:tabular way*/
/*proc report will give us the mean of creatine by the age category*/
/*Look at Q2 on HW*/
proc report data=analysis.swiss;
column agecat creat_68, (mean);
define agecat/group;
title "mean creatinine (mg/dl) in 1968 according to age quintile";
run;
/*creatine levels are increasing by age group, linear relationship. If this was'nt linear you
can transform var. to see what works better*/

/*describing X/Y relationship: graphic way*/
proc sgplot data=analysis.swiss;
scatter y=creat_68 x=age;
title "scatterplot of age v. creatinine in 1968";
run;


/*describing X/Y relationship: another graphic way*/
proc sort data=analysis.swiss;
by agecat;	/*need to sort by X categories before making bar plot*/
run;

/*PE/BMI relationship: bar plot*/
data analysis.swiss;
set analysis.swiss;
by agecat;
observed=mean(creat_68);
/*telling SAS to make new variable called 'observed' that is mean of creatinine within each age category*/
run;

/*PE/BMI relationship:  bar plot*/
proc sgplot data=analysis.swiss;
vbar agecat/response=observed stat=mean;
title "mean observed creatinine within age quintiles";
run;

/*for proc ;pgistic statement:
model outcome = exposure/lackfit scale=none aggregate rsq
This will give you the deviance, pearson, HL test etc. */


/*dummy variable model*/
proc reg data=analysis.swiss;
model creat_68 = age2 age3 age4 age5;
title "dummy var model, lowest group is referent";
run;

/*square root model*/
data analysis.swiss;
set analysis.swiss;
rootage=sqrt(age); /*making new variable square root of age*/
run;

proc reg data=analysis.swiss;
model creat_68 = rootage;
output out=sqrtpred p=predicted;
title "square root model";
run;

proc sgplot data=sqrtpred;
scatter y=creat_68 x=age;
series y=predicted x=age;
/*title "observed v. predicted creatinine, square-root of age";*/
run;

/*log-transformed model*/

data analysis.swiss;
set analysis.swiss;
logage=log(age); /*create new variable which is the log of age*/
run;

proc reg data=analysis.swiss;
model creat_68 = logage;
output out=logpred p=predicted;
title "log transformed model";
run;

proc sgplot data=logpred;
scatter y=creat_68 x=age;
series y=predicted x=age;
title "observed v. predicted creatinine, log of age";
run;



