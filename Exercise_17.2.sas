/*Relationship Between Membership in College Student Organizations and Sexually Coercive Behavior in Men*/
OPTIONS LS=80 PS=60;
DATA D1;
	INPUT COERC    $
		  TYPE_ORG $
		  NUMBER   ;
DATALINES;
NEVER NONE  120
NEVER FRAT   27
NEVER OTHER 118
SOME  NONE   91
SOME  FRAT   48
SOME  OTHER  79
;
PROC FREQ DATA=D1;
	TABLES COERC*TYPE_ORG / ALL;
	WEIGHT NUMBER;
	TITLE1 'ADAM LIEBERMAN';
RUN;

