/*Effect of Interview Suspicion on Interviewee Nervousness, Independent Sample T-Test*/
OPTIONS LS=80 PS=60;
DATA D1;
	INPUT SUB_NUM
		 SUS_GRP $
         	 NERV;
DATALINES;
01 L 17
02 L 20
03 L 19
04 L 19
05 L 15
06 L 16
07 L 18
08 L 17
09 L 16
10 L 18
11 H 19
12 H 21
13 H 20
14 H 18
15 H 20
16 H 19
17 H 20
18 H 17
19 H 22
20 H 23
;
PROC TTEST DATA=D1;
	CLASS SUS_GRP;
	VAR NERV;
	TITLE 'ADAM LIEBERMAN';
RUN;
	
