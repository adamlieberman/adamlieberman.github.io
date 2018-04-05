libname original "H:\windows\Rosner";
run;
libname analysis "H:\windows\Rosner";
run;

proc contents data=analysis.lead;
run;

/*define case status*/
data analysis.lead;
	set analysis.lead;
	if iqf LE 80 then case=1;
	else if iqf GT 80 then case=0;
/*crate dummy variable for residential distance*/
	if area=2 then areamid=1;
	else if area=1 or area=3 then areamid=0;
	if area=3 then areafar=1;
	else if area=1 or area=2 then areafar=0;
run;

/*Question #1*/
proc freq data=analysis.lead;
	tables iqf areafar;
run;
/*Question #2*/
proc logistic data=analysis.lead descending;
title "univariate model of low iq versus other predictors";
model case= ld73 sex areamid areafar;
run;

/*Question #5*/
proc logistic data=analysis.lead;
title "univariate model of low iq versus other predictors (not descending)";
model case=ld73 sex areamid areafar;
run;
