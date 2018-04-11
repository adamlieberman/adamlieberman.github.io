/*Correlation study of Nurses Intent to Remain*/
OPTIONS LS=80 PS=60;
DATA D1;
	INPUT SUB_NUM
		  N_ASSERT /*Nurse Assertiveness*/
		  EXHAUST /*Emotional Exhaustion*/
		  INT_REM; /*Intent to Remain*/
DATALINES;
01 22 10 34
02 20 13 34 
03 13 11 30
04 31 20 30
05 15 13 29
06 20 16 27
07 22 19 27
08 26 22 24
09 33 26 24
10 18 14 23
11 25 18 22
12 10 23 21
13 22 26 20
14 16 21 19
15 28 31 19
16 19 22 16
17 25 25 16
18 32 29 15
19 19 34 14
20 16 27 13 
21 27 31 11
22 23 34 10
;
PROC PLOT DATA=D1;
	 PLOT INT_REM*N_ASSERT;
	 TITLE1 'ADAM LIEBERMAN';
RUN;
PROC CORR DATA=D1;
	VAR N_ASSERT EXHAUST INT_REM;
	TITLE 'ADAM LIEBERMAN';
RUN;

