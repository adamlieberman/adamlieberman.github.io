libname original "H:\windows\Rosner";
run;
libname analysis "H:\windows\Rosner";
run;
proc contents data=analysis.tennis1;
run;

/*define case status*/
data analysis.tennis1;
	set analysis.tennis1;
	if num_epis=0 then case=0; 
	else if num_epis>0 and num_epis<9 then case=1;
	else if num_epis=9 then case=.;
	/*heavy or medium exposure v. referent, dichotomous variable*/
	if wgt_curr<=2 then heavy=1;
	else if wgt_curr=2 or wgt_curr=3 then heavy=0;
	else if wgt_curr>=4 then heavy=.;
	/*change age=99 to age=.*/
	if age=99 then age=.;  
run;

/*Checking coding for case status*/
proc freq data=analysis.tennis1;
	tables num_epis*case/missing;
run;

/*Checking coding for heavy/medium dummy cariables*/
proc freq data=analysis.tennis1;
	tables heavy*wgt_curr;
run;

proc logistic data=analysis.tennis1 descending;
/*descending is needed because SAS predicts log-odds for LOWEST value by default. 
SAS will always use the higher number as reference, but we want 0 (non-case) to be the referent, not 1=case*/
title "univariate model of racquet type v. tennis elbow";
model case = heavy;
run;



proc logistic data=analysis.tennis1 descending;
/*descending is needed because SAS predicts log-odds for LOWEST value by default*/
title "univariate model of racquet type v. tennis elbow with age in our model";
model case = heavy age;
run;
