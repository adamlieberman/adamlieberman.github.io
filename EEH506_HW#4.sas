libname original "S:\windows\Rosner";
run;

libname analysis "S:\windows\Rosner";
run;

proc print data=analysis.lead;
run;
 
 	
data analysis.lead;
	set analysis.lead;
	if ld73 LE 29 then lead30=0;
	if ld73 GT 30 then lead30=1;
	agechar=put (age, 4.);
	agepartA = substr (agechar,1,2);
	agepartB = substr (agechar,3,2);
	agemo= (agepartA * 12) + agepartB;
run;
/*Question 1*/
proc glm data =analysis.lead;
	model iqf = lead30 sex agemo;
	output out=analysis.lead_hw4model1 predicted=fittedval l95m=lCIsub u95m=uCIsub l95=lCIind u95=uCIind;
title 'Model 1. Regression of high lead concentration and full IQ after adjusting for sex and age';
run; 

PROC PRINT DATA=ANALYSIS.LEAD_HW4MODEL1;
	TITLE 'fITTED vALUSE AND ci FOR mODEL 1';
RUN;

	
/*Question 2*/
proc glm data =analysis.lead;
	model iqf = lead30;
	output out=analysis.lead predicted=fittedval l95m=lCIsub u95m=uCIsub l95=lCIind u95=uCIind;
title 'Model 1. Regression of high lead concentration and full IQ';
run; 
proc print data=analysis.lead;
	var iqf agemo fittedval lCIsub uCIsub lCIind uCIind; 
	where lead30=1 and age=1400 and sex=2;
	title "Fitted Values and CI for a 14 yr. old girl with high lead exposure";
run;

/*Question 3*/

proc glm data=analysis.lead;
	model iqf=lead30;
	output out=analysis.lead predicted=fittedval l95m=lCIsub u95m=uCIsub l95=lCIind u95=uCIind;
	title " Full IQ and SE for subgroup of 10.5 yr. old boys with low lead exposure";
run;

proc print data=analysis.lead;
	var iqf age fittedval;
	where lead30=0 and age=1006 and sex=1;
	title 'Fitted Values for a 10.5 yr. old boy with low lead exposure';
run;


estimate "10.5, low lead" intercept 1 lead30 0 agemo 1006;
