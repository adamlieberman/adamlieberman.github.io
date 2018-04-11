/*Bivariate Correlation Study of Drinking and Driving Behavior*/
OPTIONS LS=80 PS=60;
DATA D1;
	INPUT SUB_NUM
		  MC_T1 /*moral commitment at time 1*/
		  PC_T1 /*percieved certainty at time 1*/
		  DD_T1 /*drinking and driving at time 1*/
		  DD_T2; /*drinking and driving at time 2*/
DATALINES;
01 24  8 1 3 
02 12 12 3 4
03  4  4 4 5
04 16 12 2 2
05 28  . 1 1
06  8 16 3 3
07 12  8 3 5
08  8  8 5 6
09 16 16 4 4
10 16 16 4 5
11 12 12 4 6
12 20 16 5 2
13 28 24 5 3
14 20 20 5 5
15 20 24 6 4
16 16 20 6 6
17 16 16 6 7
18  4 12 6 8
19 24 28 7 5
20 20 24 7 6
21  4 20 8 8
;
PROC PLOT DATA=D1;
	PLOT DD_T2*MC_T1;
	TITLE1 'ADAM LIEBERMAN';
RUN; 
PROC CORR DATA=D1;
	VAR MC_T1 PC_T1 DD_T1 DD_T2;
	TITLE1 'ADAM LIEBERMAN';
RUN; 
