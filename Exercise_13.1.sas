/*Analyzing Sex differences in Sexual Jealousy using Independent-Samples T-Test*/
OPTIONS LS=80 PS=60;
DATA D1;
	INPUT SUB_NUM 
		  SEX $
		  DISTRESS;
DATALINES;
01 M 22
02 M 25
03 M 23
04 M 24
05 M 20
06 M 28
07 M 27
08 M 23
09 M 23
10 M 24
11 M 26
12 M 26
13 M 25
14 M 21
15 M 22
16 M 23
17 M 24
18 M 25
19 F 22
20 F 22
21 F 25
22 F 18
23 F 23
24 F 24
25 F 19
26 F 20
27 F 20
28 F 20
29 F 21
30 F 21
31 F 21
32 F 19
33 F 19
34 F 22
35 F 23
36 F 21
;
PROC TTEST DATA=D1;
	CLASS SEX;
	VAR DISTRESS;
	TITLE1 'ADAM LIEBERMAN';
RUN;

