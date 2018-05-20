libname original "S:\Rosner";
run;
libname analysis "S:\Rosner";
run;

/*Create dichotomous variable of contraception*/
data analysis.contraception;
	set analysis.contraception;
	if contra GE 2 then contrause= 1;
	if contra LE 1 then contrause= 0;
run;

/*Check to see if contrause variable works*/
proc freq data=analysis.contraception;
	tables contrause;
run;

/*Create age into a multiple variables*/
data analysis.contraception;
	set analysis.contraception;
	if age LE 19 then age1 =1;
		else age1=0;
	if age GE 20 and age LE 29 then age2 =1;
		else age2=0;
	if age GE 30 and age LE 39 then age3 =1;
		else age3=0;
	if age GE 40 then age4 =1;
		else age4=0;
run;

/*Checking to see if age variables work*/
proc freq data=analysis.contraception;
	tables age1 age2 age3 age4;
run;

/*Creating variable for nulliparous*/
data analysis.contraception;
	set analysis.contraception;
	if parity LE 0 then parity1=0;
	if parity GE 1 then parity1=1;
run;

/*Checking to see if parity1 variable worked*/
proc freq data=analysis.contraception;
	tables parity1;
run;

/*Create wife's education into dummy variable for Table 2*/
data analysis.contraception;
	set analysis.contraception;
	if educ=1 then educ1=1;
	else educ1=0;
	if educ=2 then educ2=1;
	else educ2=0;
	if educ=3 then educ3=1;
	else educ3=0;
	if educ=4 then educ4=1;
	else educ4=0;
run;

/*Checking to see if wife's education variables work*/
proc freq data=analysis.contraception;
	tables educ1 educ2 educ3 educ4;
run;

/*Frequency of each variable for Table 1*/
proc freq data=analysis.contraception;
	tables age1 age2 age3 age4 educ hus_age parity1 religion working sol media contrause;
run;
 
/*Sort data by contraception use*/
proc sort data=analysis.contraception; 
	by contrause;
run;

/*Frequency of each variable stratified by contraception use: Table 1*/
proc freq data=analysis.contraception;
	tables age1 age2 age3 age4 educ hus_age parity1 religion working sol media contrause;
	by contrause;
run;

/*X2 p-values to see significant differences between contraceptive users and non-users: Table 1*/
proc freq data=analysis.contraception;
	tables age*contrause educ*contrause hus_age*contrause parity1*contrause religion*contrause working*contrause 
       sol*contrause media*contrause/all;
run;

/*Model to identify the association between contraception use and wife's educational attainment (4 categories)
Used in Table 2 (low education as the referent)*/
proc logistic data=analysis.contraception descending;
	model contrause=educ2 educ3 educ4; 
run;

/*Multiple regression model with all covariates included*/
proc logistic data=analysis.contraception descending;
	model contrause=educ age hus_age parity working sol media;
run;

/*Sequentially taking out one variable at a time to see if the OR changes by >10%. If so it will be added to the final model*/
proc logistic data=analysis.contraception descending;
	model contrause=educ hus_age parity working sol media;
run;

proc logistic data=analysis.contraception descending;
	model contrause=educ age parity working sol media;
run;

proc logistic data=analysis.contraception descending;
	model contrause=educ age hus_age working sol media;
run;

proc logistic data=analysis.contraception descending;
	model contrause=educ age hus_age parity working sol media;
run;

proc logistic data=analysis.contraception descending;
	model contrause=educ age hus_age parity sol media;
run;

proc logistic data=analysis.contraception descending;
	model contrause=educ age hus_age parity working media;
run;

proc logistic data=analysis.contraception descending;
	model contrause=educ age hus_age parity working sol;
run;

/*Final Model after adjusting for parity religion, standard of living, and media. Including 
wife's education as a dummy variable for Table 2 (low education as the referent)*/
proc logistic data=analysis.contraception descending;
	model contrause=educ2 educ3 educ4 parity sol media;
run;

/*Testing Model fit*/
proc logistic data=analysis.contraception descending;
	model contrause=educ parity sol media/iplots lackfit scale=none aggregate rsq;
	output out=diagnostics resdev=resdev reschi=reschi;
run;

/*Evaluate specific departures from linearity*/
/*resdev for deviation and resci for pearson residuals*/
proc sgplot data=diagnostics;
scatter y=resdev x=educ;
title "residual deviances vs. educ";

proc sgplot data=diagnostics;
scatter y=reschi x=educ;
title "X2 deviances vs. educ";

proc sgplot data=diagnostics;
scatter y=resdev x=parity;
title "residual deviances vs. parity";

proc sgplot data=diagnostics;
scatter y=reschi x=parity;
title "X2 deviances vs. parity";

proc sgplot data=diagnostics;
scatter y=resdev x=sol;
title "residual deviances vs. sol";

proc sgplot data=diagnostics;
scatter y=reschi x=sol;
title "X2 deviances vs. sol";

proc sgplot data=diagnostics;
scatter y=resdev x=media;
title "residual deviances vs. media";

proc sgplot data=diagnostics;
scatter y=reschi x=media;
title "X2 deviances vs. media";
run;

/*Testing for any Influential Observations*/
proc logistic data=analysis.contraception;
model contrause=educ parity sol media/influence iplots lackfit scale=none aggregat rsq;
output out=diagnostics2 cbar=cbar;
run;

/*A few observations had high C-Bar values so I will find these observations and see if there is anything unusual*/
proc print data=diagnostics2;
where cbar>.04;
run;
/*we can conclude that these observations are not influential and can keep them in the original model*/

/*Testing for collinearity, looking at VIF's*/
proc reg data=analysis.contraception;
model contrause=educ parity sol media/vif;
run;
/*All are close to 1.0 no signs of collinearity*/

/*Model to test if the association is modified by wife's religion: Table 3*/;
proc logistic data=analysis.contraception descending;
	model contrause=educ parity religion sol media religion*educ;
run;
