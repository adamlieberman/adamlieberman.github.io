/*The Effect of Misleading Suggestions on the Creation of False Memories, One-Way ANOVA with One Between Subjects Factor*/
OPTIONS LS=80 PS=60;
DATA D1;
INPUT SUB_NUM
      NUM_EXP $
      CONFID;
DATALINES;
01 0_EXP 1
02 0_EXP 1.25
03 0_EXP 2
04 0_EXP 1.75
05 0_EXP 2.75
06 0_EXP 3.25
07 0_EXP 4.5
08 2_EXP 2.75
09 2_EXP 3
10 2_EXP 4
11 2_EXP 5.5
12 2_EXP 5.5
13 2_EXP 6.25
14 2_EXP 6.75
15 4_EXP 4.75
16 4_EXP 3
17 4_EXP 4.75
18 4_EXP 5.75
19 4_EXP 7
20 4_EXP 6
21 4_EXP 3
;
PROC GLM DATA=D1;
	CLASS NUM_EXP;
	MODEL CONFID = NUM_EXP;
	MEANS NUM_EXP;
	MEANS NUM_EXP / TUKEY CLDIFF ALPHA=0.05;
	TITLE1'Your name';
RUN;
QUIT;
