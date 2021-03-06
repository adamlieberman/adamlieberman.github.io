/*The Effect of News Source Credibility on Voter Reactions to Political Scandal, One-Way ANOVA*/
options ls=80 ps=60;
data D1;
	input SUB_NUM
		   CRED $
		   APPROV;
datalines;
01 L 18
02 L 21
03 L 20
04 L 20
05 L 24
06 L 22
07 L 19
08 L 16
09 L 19
10 M 20
11 M 22
12 M 21
13 M 15
14 M 24
15 M 19
16 M 18
17 M 19
18 M 17
19 H 14
20 H 18
21 H 16
22 H 19
23 H 15
24 H 16
25 H 11
26 H 12
27 H 14
;
PROC GLM DATA=D1;
	CLASS CRED;
	MODEL APPROV = CRED;
	MEANS CRED;
	MEANS CRED / TUKEY CLDIFF ALPHA=.05;
	TITLE 'ADAM LIEBERMAN';
RUN;




