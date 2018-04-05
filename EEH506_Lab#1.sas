*Create a folder called original that has the Rosner datasets*;
libname original "S:\windows\Rosner";
run;
*Create a folder called analysis that has the Lab datasets*;
libname analysis "S:\windows\Lab datasets";
run;

*Make a new dataset in the analysis folder that is the exact same as the one in the original library*;
*The reason for this step is so that you have the original dataset without manipulation saved somewhere;
data analysis.lead;	
	set original.lead;
run;

proc print data=analysis.lead;
run;

/*Question 2
Create a new variable (ld73cat) with classification*/
*Why do you have to rename again?*;
data analysis.lead;
	set analysis.lead; 
	if ld73 LT 40 then ldt3cat=0;	
	else if ldt73 GE 40 then ld73cat=1;
run;
*Why do you add the 'MISSING statement next to tables?;
proc freq data= analysis.lead;
	tables ld73cat/MISSING;
	title "Table to Determine if there are any missing Lead Values";
run;

/*Question 3 full IQ score among unexposed*/
proc univariate data= analysis.lead;
	var IQF;
	histogram;
	where ld73cat=0;
	title "IQ distribution among low levels of lead exposure";
run; 

*Looking at sex distribution among unexposed*;
proc freq data=analysis.lead;
	tables sex;
	where ld73cat=0;
	title "Sex distribution among low levels of lead exposure";
run;

/*Question 4 looking for the relationship between sex and lead exposure with ChiSquare and Relative Risk*/;
proc freq data=analysis.lead;
	tables sex*ld73cat /CHISQ RELRISK;
run; 

/*Question 5 looking for the relationship between IQ and lead exposure with Ttest*/
proc ttest data=analysis.lead;
	class ld73cat;
	var  IQF;
	title "Relationship between IQ and Lead Exposure";
run;





