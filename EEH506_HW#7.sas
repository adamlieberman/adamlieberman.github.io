libname original "H:\windows\Rosner";
run;
libname analysis "H:\windows\Rosner";
run;


data analysis.lead;
set analysis.lead;
/*create variable for case status*/
	if iqf LE 80 then case=1;
	else if iqf GT 80 then case=0;
/*crate dummy variable for residential distance*/
	if area=2 then areamid=1;
	else if area=1 or area=3 then areamid=0;
	if area=3 then areafar=1;
	else if area=1 or area=2 then areafar=0; 
	/*create variable for hyper2*/
	if hyperact=99 then hyperact2=.;
	if hyperact=0 then hyperact2=0;
	else if hyperact>0 then hyperact2=1;
/*create variable for sex2*/
	if sex=1 then sex2=1;
	if sex=2 then sex2=0;
/*create interact variables*/
	if hyperact2=1 and sex2=1 then interact=1;
run;

/*Question#1*/
proc freq data=analysis.lead;
	tables hyperact2 sex2;
run;

/*Question#2*/
proc logistic data=analysis.lead descending;
	title "univariate model of low iq versus far residential distance";
	model case=areafar;
run;

/*When do you use contrast statement v. estimate statement?*/

/*Question#3,4,5,6*/
 proc genmod data=analysis.lead descending;
	model case = hyperact2 sex2 interact areamid areafar age/ dist=bin link=logit waldci;
	title "multivariate model of far residential distance";
		estimate "hyperactive girls v non-hyperactive girls" hyperact2 1/exp; 
		estimate "hyperactive boys v non-hyperactive boys" hyperact2  1/exp; 
		estimate "interaction term" interact 1/exp;
        estimate "hyperactive male 36 months old v non-hyperactive female 24 months old" hyperact2 1 sex2 1 age 12/exp;
	run;



