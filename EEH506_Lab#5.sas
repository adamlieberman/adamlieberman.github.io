libname original "H:\windows\Lab Datasets 2018";
run;

libname analysis "H:\windows\Lab Datasets 2018";
run;

/*Step 1: Creating box plots to see if our variables assume normality and heteroscedasticity*/;
proc sgplot data=analysis.hospital;
vbox dur_stay;
title "Duration of stay";
proc sgplot data=analysis.hospital;
vbox age;
title "Age";
proc sgplot data=analysis.hospital;
vbox temp;
title "Temp";
proc sgplot data=analysis.hospital;
vbox wbc;
title "Wbc";
run;

/*Step 2: Fitting a Regression Model to check model diagnostics*/;
proc reg data=analysis.hospital;
model dur_stay= service age sex temp wbc/vif partial clb;
title "Model 1. Regression of duration of stay against type of service";
output out=modeldiag predicted=fittedy rstudent=jackknife h=leverage cookd=cook;
run;

/*Step 3: Evaluate assump
