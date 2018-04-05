OPTIONS LS=80 PS=60;
DATA D1;
INPUT 	SUB_NUM
		HEIGHT
		WEIGHT
		AGE;
DATALINES;
  1 64 140 20 
  2 68 170 28
  3 74 210 20
  4 60 110 32
  5 64 130 22
  6 68 170 23
  7 65 140 22
  8 65 140 22
  9 68 160 22
  ;
  PROC MEANS DATA=D1;
  	VAR HEIGHT WEIGHT AGE;
	TITLE1 'ADAM LIEBERMAN';
  RUN;