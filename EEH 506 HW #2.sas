libname original "H:\windows\Rosner";
libname analysis "H:\windows\Rosner";
run;

data analysis.lead;
	set original.lead;
run;

proc print data=analysis.lead;
run;

/*Question #8*/

data analysis.lead;
	set original.lead;
 	if ld73 LE 30 then lead30=0;
	else if ld73 GT 30 then lead30=1;
run;

proc reg data=analysis.lead;
	model iqf = lead30 /clb;
run;

/*Question #9*/

data analysis.lead;
	set original.lead;
	if ld73 LE 30 then lead30b =0;
	if ld73 GT 30 then  lead30b =2;
run;

proc reg data=analysis.lead;
	model iqf = lead30b /clb;
run;

proc means data=analysis.lead;
	var IQF;	
	by lead30;
run;

/*Question #10*/

proc reg data=analysis.lead;
	model iqf = ld73 /clb;
run;
