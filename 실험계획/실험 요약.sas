
*combined (highway+city)/2;
data mpg_combined;
input x $ mpg;
cards;
ferrari 18
ferrari 19
ferrari 19
ferrari 19
ferrari 17.5
ferrari 14 ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
porsche 25
porsche 24.5
porsche 25
porsche 24.5
porsche 24.5
porsche 22
porsche 17
porsche 18
;
run;

proc ttest data=mpg_combined;
class x;
var mpg;
run;
* SAS 실습 : solution :모수 추정, Clparm 신뢰구간 estimate 각 명목형 변수간의 모수 추정
;
data a1;
input fat trans @@;
cards;
1 164 1 172 1 168 1 177 1 156 1 195
2 178 2 191 2 197 2 182 2 185 2 177
3 175 3 193 3 178 3 171 3 163 3 176
4 155 4 166 4 149 4 164 4 170 4 168
; 
run;
*Anova table 작성, 각 fat 평균 모수 수치(Estimate)
fat 1= 162 +10= 172    fat4 162+0=162;
proc glm data=a1;
class fat;
model trans = fat/ solution;
run; 


proc glm data=a1;
class fat;
model trans = fat/  clparm;
estimate 'animal -vege' fat 0.5 0.5 -0.5 -0.5; *(fat1+2)/2 - (fat 3+4)/2 비교 각 합침;
estimate 'animal -vege2' fat 1 1 -1 -1; *위의 2배;
run;

/*     */
data a;
input program sales @@;
cards;
1 74 1 67 1 83 1 77 1 71
2 94 2 82 2 69 2 78 2 68
3 62 3 75 3 59 3 79 3 68
4 80 4 82 4 75 4 90 4 72
; 
proc glm data= a;
class program;
model sales= program / solution clparm;
estimate 'pgm 1' intercept 1 program 1 0 0 0;
estimate 'pgm1 vs pgm2' program 1 -1 0 0;
run;

* SAS 실습 : solution :모수 추정, Clparm 신뢰구간 estimate 각 명목형 변수간의 모수 추정
;
data a1;
input fat trans @@;
cards;
1 164 1 172 1 168 1 177 1 156 1 195
2 178 2 191 2 197 2 182 2 185 2 177
3 175 3 193 3 178 3 171 3 163 3 176
4 155 4 166 4 149 4 164 4 170 4 168
; 
run;
*Anova table 작성, 각 fat 평균 모수 수치(Estimate)
fat 1= 162 +10= 172    fat4 162+0=162;
proc glm data=a1;
class fat;
model trans = fat/ solution;
run; 

proc glm data=a1;
class fat;
model trans = fat/  clparm;
estimate 'fat1 -fat 4' fat 1 0 0 -1;
run;

proc glm data=a1;
class fat;
model trans = fat/  clparm;
estimate 'animal -vege' fat 0.5 0.5 -0.5 -0.5; *(fat1+2)/2 - (fat 3+4)/2 비교 각 합침;
estimate 'animal -vege2' fat 1 1 -1 -1; *위의 2배;
run;
/*    */

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

* 5 다중비교 anova;
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
		lsmeans feed / t;
	run;

	*튜키 다중비교;

proc glm data=dat5_1;
	class feed;
	model gain=feed;
	means feed / tukey scheffe;
		lsmeans feed / adjust=tukey scheffe;
	run;

proc glm data=dat5_1;
	class feed;
	model gain=feed;
	means feed / dunnett('feed1');
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

proc glm data=data1;
	class x;
	model y=x;
	contrast 'linear' x -2 -1 0 1 2;
	contrast 'quadratic' x 2 -1 -2 -1 2;q
	contrast 'cubic' x -1 2 0 -2 1;
	contrast 'quadrtic' x 1 -4 6 -4 1;
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

/*  6 잔차 검정 */	
* 잔차 산점도(수직축잔차, 수평축 브랜드) 이분산;
proc sgplot data=resid;
 scatter x=company y=res;
 run;
 *바틀렛 검정 -등분산성: > 0.05 h0기각 못함 타르함량 분산 동일;
proc glm data= cigarette;
class company;
model tar = company;
means company /hovtest=bartlett;
run;

*잔차 정규활률지 -정규성 테스트-직선에 가가움 정규성 만족, 모든 검정의 결과값 >0.05;
proc univariate normal data=resid;
probplot  res/normal rotate;
run;


*연습문제 6;
data a;
 do treat=-1 to 1 by 2;
  do n=1 to 5;
   y=exp(4+3*rannor(111)+treat);
  output;
 end;
end;
*잔차로 정규성 검정;
proc glm data= a;
 class treat;
 model y = treat;
 output out=resid r=res;
run;
*잔차 상자그림;
proc sgplot data=resid;
vbox res /category=treat;
run;
*히스토그램;
proc univariate data=resid normal plot;
var res;
run;
*잔차 정규확률지;
proc univariate normal data=resid;
probplot  res/normal rotate;
run;
*잔차 정규성 검정;
proc univariate data=resid normal plot;
var res;
run;

*박스 칵스 변환;
proc transreg details data=a;
model boxcox (y/ convenient lambda =  -2 to 2 by 0.01)=class(treat);
run;

*변환된 자료로 위의 분석 반복 yi=logyi;
data trans;
set a;
logy=log(y);
run;
proc print data=trans;
run;

proc glm data= trans;
 class treat;
 model logy = treat;
 output out=resid r=res;
run;
*잔차 상자그림  중위수=평군;
proc sgplot data=resid;
vbox res /category=treat;
run;
*히스토그램-종모양;
proc univariate data=resid normal plot;
var res;
run;
*잔차 정규확률지-일직선;
proc univariate normal data=resid;
probplot  res/normal rotate;
run;
*잔차 정규성 검정 4가지 모두 >0.05, h0기각 못함: ;
proc univariate data=resid normal plot;
var res;
run;

*7. 이원배치 고정효과;
proc glm data= ;
	class a b;
	model y= a | b/test;
	lsmeans a*b/ adjust = tukey lines;
run;
*상호작용 유의하지 않는 경우 각 처리별 유의성 검정;
proc glm data= ;
	class a b;
	model y= a | b/test;
	lsmeans a*b/ slice=b;
run;
*이원배치 임의효과;
proc glm data= ;
	class a b;
	model y= a b a*b ;
	random a b a*b/test;
	lsmeans a*b/slice=b;
run;
	
*이원배치 다중비교 - ab 유의;
proc glm data= ;
	class a b;
	model y= a b a*b ;
	random a b a*b/test;
	lsmeans a*b/ pdiff=all adjust =tukey lines slice=a;
run;	
* 주효과 ;
proc glm data= ;
class a;
model y=a;
random a;
run; 

lsmeans a /pdiff =all;
* 8.내포모형;
proc glm data= ;
class a b;
model y=a b(a);
random a b(a)/ test;
run;
	
	
*10.RCBD;

data a; input line $ time $y ; cards;
1 a 7
1 b 6
1 c 11
2 a 10
2 b 9
2 c 15
3 a 8
3 b 5
3 c 25
;
proc glm data=a ;
class line time;
model y=line time;
random line/test;

run;	

proc glm data= a plots=(diffplot (center) meanplot (cl ascending));
class trt block;
model y=block trt;
random blcok /test; *EMS;
lsmeans trt/ adujust =tukey;
run;
*RCBD안의 이원배치법;
proc glm data= ;
class trt block1 block2;
model y=block trt1 trt2 trt1*trt2;

run;

*11라틴방경법;
proc glm data= ;
class trt block1 block2;
model y=block1 block2 trt;

run;

proc glm data= ;
class trt block1 block2;
model y=block1 block2 trt;
lsmeans trt/ adujust =tukey;
run;

proc glm data= ;
class trt block1 block2;
model y= rep row(rep) col(rep) trt;
model y= rep row col(rep) trt;
model y= rep row col trt;
run;

*ancova;
proc sgplot data= a;
scatter x=x y=y/ group=ab;
run;

proc corr data= a;
var x y ; 
run;
*상호작용 유의 여부 ->ancova;
proc glm data=;
class ab;
model y= ab  x ab*x/solution;
run;
*ancova -처리효과, 공변량 검정 -> 회귀선 추정(same slope);
proc glm data=;
class ab;
model y= ab  x/soultion;
run;

proc standard data= a mean =0 out=b;
	var x;
run;

*반응표면분석;
proc rsreg data=a plots=surface(3d);
model y=x1 x2  /lackfit;
run;
	
