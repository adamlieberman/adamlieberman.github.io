/*The Relationship Between Sex of Children and Marital Disruption*/
OPTIONS LS=80 PS=60;
DATA D1;
	INPUT STATUS $
	  	  SEX    $
	  	  NUMBER ;
DATALINES;
I BB 34
I BG 26
I GG 15
S BB 14
S BG 22
S GG 36 
;
PROC FREQ DATA=D1;
	TABLES STATUS*SEX / ALL;
	WEIGHT NUMBER;
	TITLE1 'ADAM LIEBERMAN';
RUN;
