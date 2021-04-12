data dat5_1;
	input feed $ gain @@;
	cards;
feed1 27.4 feed1 33.6
feed2 17.7 feed2 25.8
feed3 17.0 feed3 20.4
feed4 21.7 feed4 23.0
feed5 12.3 feed5 13.4
feed6 17.3 feed6 20.8
;
run;

proc glm data=dat5_1;
	class feed;
	model gain=feed;
	means feed / lsd;
	run;

proc print data=dat5_1;
run;

* 51.2 anova;

proc glm data=dat5_1;
	class feed;
	model gain=feed;
	run;
	* using contrast;

proc glm data=dat5_1;
	class feed;
	model gain=feed;
	contrast 'feed difference ' 
	feed 1 -1 0 0 0 0,
	feed 0 1 -1 0 0 0, 
	feed 0 0 1 -1 0 0, 
	feed 0 0 0 1 -1 0, 
	feed 0 0 0 0 1 -1;
	run;
	* 다중비교 (LSD) 반복수 동일한 경우 means = lsmeans;

proc glm data=dat5_1;
	class feed;
	model gain=feed;
	means feed / lsd;
	run;

proc glm data=dat5_1;
	class feed;
	model gain=feed;
	lsmeans feed / t;
	run;
	*튜키 다중비교;

proc glm data=dat5_1;
	class feed;
	model gain=feed;
	means feed / tukey;
	run;
proc glm data=dat5_1;
	class feed;
	model gain=feed;
	lsmeans feed /pidiff cl adjust=tukey;
	run;
proc glm data=dat5_1;
	class feed;
	model gain=feed;
	lsmeans feed /pidiff cl adjust=tukey;
	run;

proc glm data=dat5_1;
	class feed;
	model gain=feed;
	means feed / scheffe;
	run;

proc glm data=dat5_1;
	class feed;
	model gain=feed;
	lsmeans feed / adjust=scheffe;
	run;

proc glm data=dat5_1;
	class feed;
	model gain=feed;
	means feed / dunnett('feed1');
	run;

proc glm data=dat5_1;
	class feed;
	model gain=feed;
	lsmeans feed / adjust=dunnett pdiff=control('feed1');
	run;
	*5.2;

Data dat5_2;
	Input speed blood @@;
	Cards;
150 3.540 50 1.158 50 1.128 75 1.686
150 3.480 150 3.510 100 2.328 100 2.340
100 2.298 125 2.982 100 2.328 50 1.140
125 2.868 150 3.504 100 2.340 75 1.740
50 1.122 50 1.128 150 3.612 75 1.740
;

proc sort data=dat5_2;
	By speed;
run;

*5.2.2 Anova;

proc glm data=dat5_2;
	class speed;
	model blood=speed;
	;
	run;
	*5.2.3 몇차 추세;

Data dat5_2;
	set dat5_2;
	speed2=speed**2;
	speed3=speed**3;
	speed4=speed**4;
run;

proc glm data=dat5_2 plots=none;
	model blood=speed speed2 speed3 speed4;
	run;

proc glm data=dat5_2;
	class speed;
	model blood=speed;
	contrast 'linear' speed -2 -1 0 1 2;
	contrast 'quadratic' speed 2 -1 -2 -1 2;q
	contrast 'cubic' speed -1 2 0 -2 1;
	contrast 'quadrtic' speed 1 -4 6 -4 1;
	run;
	*	5.2.5 CI for max-min;

Proc glm data=dat5_2;
	Class speed;
	Model blood=speed/ clparm;
	Estimate 'max- min' speed -1 0 0 0 1;
	Run;
	*5.2.6 CI for meat at speed=50;

Proc glm data=dat5_2;
	Class speed;
	Model blood=speed/ clparm;
	Estimate 'mean for speed 50' intercept 1 speed 1 0 0 0 0;
	Run;

Proc means data=dat5_2;
	By speed;
	Var blood;
Run;

*5.3 고혈압 ;

Data dat5_3;
	Input treat $b_down;
	Cards;
Medi 10
Medi 12
Medi 9
Medi 15
Medi 13
Exer 6
Exer 8
Exer 3
Exer 0
Exer 2
Diet 5
Diet 9
Diet 12
Diet 8 
Diet 4
;
	*anova;

Proc glm data=dat5_3;
	Class treat;
	Model b_down=treat;
	Run;
	*	Exercise vs diet;

Proc sort data=dat5_3;
	By treat;
Run;

Proc means data=dat5_3;
	By treat;
	Var b_down;
Run;