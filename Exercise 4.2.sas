OPTIONS LS=80 PS=60;
DATA D1;
	INPUT SUB_NUM
		  AGE
		  SEX  $
		  RACE $
		  INCOME
		  VOLUN $
		  ;
DATALINES;
01 20 F AF 75000 Y
02 32 F AF     . Y
03 34 M CA 26000 Y
04  . M CA 31000 N
05 29 F CA 23000 Y
06 41 F AS 29000 Y
07 58 . AS 59000 N
08 37 . CA 28000 N
09 25 M CA  1000 Y
10 39 M AF 55000 Y
11 44 F CA 50000 N
;
PROC MEANS DATA=D1;
	VAR SUB_NUM AGE INCOME;
	TITLE 'ADAM LIEBERMAN';
RUN;
PROC FREQ DATA=D1;
	TABLES SEX RACE VOLUN;
RUN;
PROC PRINT DATA=D1;
RUN;

