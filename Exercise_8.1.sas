/*Working with an Academic Development Questionnaire and using IF-THEN statements to create new variables*/
OPTIONS LS=80 PS=60;
DATA D1;
	INPUT SUB_NUM
		  Q1
		  Q2
		  Q3
		  Q4
		  SEX $
		  AGE
		  CLASS;
DATALINES;
01 6 . 2 7 F 20 1
02 3 2 7 2 M 26 1
03 7 7 1 7 M 19 1
04 5 6 . 5 F 23 2
05 6 7 1 6 M 21 2
06 3 2 6 3 F 25 2
07 5 6 2 5 F 25 3
08 5 6 1 5 F 23 3
09 7 7 1 6 M 31 3
10 5 4 1 4 M 25 4
11 4 5 3 5 F 42 4
12 7 6 1 6 F 38 4
;
PROC PRINT DATA=D1;
	TITLE 'ADAM LIEBERMAN';
RUN;

DATA D2;
	SET D1;

	Q3 = 8-Q3;
	DEVEL = (Q1+Q2+Q3+Q4)/4;

	AGE2 =   .;
	IF AGE LT 30 THEN AGE2= 0;
	IF AGE GE 30 THEN AGE2= 1;

	CLASS2='   .';
	IF CLASS = 1 THEN CLASS2 = 'FRE';
	IF CLASS = 2 THEN CLASS2 = 'SOP';
	IF CLASS = 3 THEN CLASS2 = 'JUN';
	IF CLASS = 4 THEN CLASS2 = 'SEN';
PROC PRINT DATA = D2;
	TITLE 'ADAM LIEBERMAN';
RUN;


