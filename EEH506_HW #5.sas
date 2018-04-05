libname original "H:\windows\Rosner";
run;
libname analysis "H:\windows\Rosner";
run;

/*Question 6*/
proc reg data=analysis.lead;
	model ld73=iqf sex age area hh_index;
run;

/*Question 7*/
proc reg data=analysis.lead;
	model ld73=iqf sex age area hh_index;
	output out=modeldiag predicted=yfitted residual=resid rstudent=jackknife;
proc sgplot data=modeldiag;
	histogram jackknife;
run;

/*Question 8*/
proc reg data=analysis.lead;
	model ld73=iqf sex age area hh_index/ vif;
run;

/*Question 9*/
proc reg data=analysis.lead;
	model ld73=iqf sex age area hh_index;
	output out=model1diag h=leverage;
run;

proc print data=model1diag;
	var leverage iqf sex age area hh_index;
	where leverage GT .0967;
	title "High Leverage Values";
run;

/*Question 10*/
proc reg data=analysis.lead;
	model ld73=iqf sex age area hh_index/influence;
	output out=model2diag rstudent=jackknife h=leverage cookd=cook dffits=dffits;
	ods output out=model2odsout;
run;

proc print data=model2diag;
	var leverage cook dffits jackknife;
	where cook GT .5 or dffits GT .439;
	title "High Cook D Values and High DFFits Values";
run;

proc print data=model2odsout;
	where dfb_iqf>22.27 or dfb_sex>22.27 or dfb_age>22.27 or dfb_area>22.27 or dfb_hh_index>22.27;
	title "High DFBeta Values";
run;
	
	
