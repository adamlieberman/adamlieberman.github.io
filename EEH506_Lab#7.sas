libname original "H:\windows\Rosner";
run;
libname analysis "H:\windows\Rosner";
run;

/*define case status*/
data analysis.tennis1;
	set analysis.tennis1;
	if num_epis=9 then case=.;
		else if num_epis=0 then case=0; 
		else if num_epis>0 then case=1;
run;

proc print data=analysis.tennis1;
	var num_epis case;
run;

/*heavy or medium exposure v. referent, dichotomous variable 1=heavy 2=medium 3=light 4=don't know 9=missing */
data analysis.tennis1;
	set analysis.tennis1;
	if wgt_curr<=2 then heavy=1; /*combining heavy and medium group*/
		else if wgt_curr=3 then heavy=0;
		else if wgt_curr>=4 then heavy=.;

/*change age=99 to age=.*/
	if age=99 then age=.;  
run;

/*step 2: multivariate model*/
proc genmod data=analysis.tennis1 descending ;
	model case = heavy age sex/ dist=bin link=logit waldci; /* dist:binary outcome,link:logistic model, waldci:CI*/
	title "multivariate model of racquet type v. tennis elbow";
run;

proc genmod data=analysis.tennis1 descending ;
	model case = heavy age sex/ dist=bin link=logit waldci;
	title "multivariate model of racquet type v. tennis elbow";
		estimate "heavy/medium v. light adj. OR, CI" heavy 1 /exp; /*use estimate and exp option statment to get OR and exponentiate betas*/
		estimate "1-year age adj. OR, CI" age 1 /exp;
		estimate "female v. male adj. OR, CI" sex 1/exp;
run;


proc genmod data=analysis.tennis1 descending ;
	model case = heavy age sex/ dist=bin link=logit waldci;
	title "multivariate model of racquet type v. tennis elbow";
			estimate "a. heavy female v light male" heavy 1 sex 1 /exp; /*adjusted for age*/
			estimate "b. 30 yo v 15 yo" age 15 /exp; /*adjusted for heavy and sex*/
			estimate "c. 15 yo light male v 30 yo heavy female" heavy -1 age -15 sex -1/exp; /*not adjusted for any var. so we have all 3 coefficients 'heavy,age,sex*/
run;

/*Interaction Model, to see better fit whole model v. model without variables*/
proc genmod data=analysis.tennis1 descending ;
		model case = heavy age sex/ dist=bin link=logit waldci;
		title "multivariate model of racquet type v. tennis elbow";
		/*don't forget to use commas in contrast statement, not needed for estimate statement*/
			contrast "a. model fit" heavy 1, age 1, sex 1;/*whole model*/
			contrast "b. sex and age together" sex 1, age 1; /*model without heavy*/
			contrast "c. sex only" sex 1; /*model with only sex*/
run;


