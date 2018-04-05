libname analysis "H:\windows\Lab datasets";
run;

data analysis.lead;	
	set original.lead;
run;

proc print data=analysis.lead;
run;

/*Question 1*/

data analysis.lead;
	set analysis.lead;
	if IQF LE 80 then IQFlevel =0;
	if IQF GT 80 then IQFlevel =1;
run;

proc freq data=analysis.lead;
	tables IQFlow IQFhigh;
run;

/*Question 2*/
data analysis.lead;
	set analysis.lead;
	if ld73 LT 40 then ld73level =0;
	if ld73 GE 40 then ld73level =1;
run;

proc freq data=analysis.lead;
	tables ld73level*IQFlevel; 
	where sex=1; 
run;

proc freq data=analysis.lead;
	tables ld73level*IQFlevel;
	where sex=2;
run; 

/*Question 3*/
*Crude Odds Ratio and MH Odds Ratio between lead concentration and IQ level*;
proc freq data=analysis.lead;
	tables ld73level*IQFlevel/relrisk cmh;
	run;
*Sex-Stratified Odds Ratio between lead concentration and IQ level*;
proc sort data=analysis.lead;
	by sex;
run; 

proc freq data=analysis.lead;
	tables ld73level*IQFlevel/all;
	by sex;
run;

