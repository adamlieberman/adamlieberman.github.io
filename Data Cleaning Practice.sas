proc freq data=work.d2;
run;

data d2;
set work.d1;
ga_total=(ga_months*4)+ga_weeks;
run;

proc freq data=d2;
table ga_total;
run;

proc print data=d2;
	where ga_total>=40;
run;

data d2;
	set work.d1;
/*define time above 12 months or above 4 weeks as MISSING*/
	/*otherwise keep the same number*/
if ga_months>12 then ga_months=.;
else ga_months=ga_months;
if ga_weeks>4 then ga_weeks=.;
else ga_weeks=ga_weeks;
ga_total=(ga_months*4)+ga_weeks;
proc print data=d2;
run;

data d2;
	set d2;
/*Apply case definition based on ga_total*/
if ga_total>=37 then case=0;
if ga_total<37 then case=1;
if ga_total=. then case=.;
proc freq data=d2;
run;

/*Merging Datasets*/
data d4;
	merge d2 work.d3;
		by SUB_NUM;
run; 


proc freq data=d4;
run;
