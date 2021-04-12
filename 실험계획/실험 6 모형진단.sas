*실습 [2] 영업교육 프로그램별 판매실적의 분산이 같은지 /다른지 ;
data a;
input program sales @@;
cards;
1 74 1 67 1 83 1 77 1 71
2 94 2 82 2 69 2 78 2 68
3 62 3 75 3 59 3 79 3 68
4 80 4 82 4 75 4 90 4 72
; 
run;
*바틀렛;
proc glm data=a;
	class program;
	model sales= program;
	means program/hovtest=bartlett;
run;
*sales자료 정규확률지;
proc univariate normal data=a;
	probplot sales / normal rotate;
run;
	
*연습문제 [2] 담배 별 타르함량;
data cigarette;
input company $ tar @@;
cards;
carlton 0.16
carlton 0.14
carlton 0.21
carlton 0.14
carlton 0.13
now 0.19
now 0.20
now 0.23
now 0.18
now 0.19
cambridge 0.21
cambridge 0.17
cambridge 0.19
cambridge 0.23
cambridge 0.20
;
run;
*일원배치법에의한 잔차;
proc glm data= cigarette;
 class company;
 model tar=company;
 output out=resid r=res;
 run;
*잔차 히스토그램:;
proc univariate data=resid normal plot;
var res;
run;

*잔차 정규활률지 -정규성 테스트-직선에 가가움 정규성 만족, 모든 검정의 결과값 >0.05;
proc univariate normal data=resid;
probplot  res/normal rotate;
run;

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

Data dat5_2;
	Input speed blood @@;
	Cards;
150 3.540 50 1.158 50 1.128 75 1.686
150 3.480 150 3.510 100 2.328 100 2.340
100 2.298 125 2.982 100 2.328 50 1.140
125 2.868 150 3.504 100 2.340 75 1.740
50 1.122 50 1.128 150 3.612 75 1.740
;

proc glm data= dat5_2;
 class speed;
 model blood=speed;
 output out=resid r=res;
 run;

proc reg;
 model res =/dw;
run;

proc autoreg;
 model res=/dwprob;
 run;
*박스 칵스 변환;
proc transreg details data=dat5_2;
model boxcox (blood/ convenient lambda =  -2 to 2 by 0.01)=class(speed);
run;
proc transreg details data=dat5_2;
model boxcox (blood/ convenient lambda =  -2 to 2 by 0.01)=identity(speed);
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
* 잔차 산점도(수직축잔차, 수평축 브랜드) 이분산;
proc sgplot data=resid;
 scatter x=treat y=y;
 run;

*히스토그램;
proc univariate data=resid normal plot;
var res;
run;

*잔차 정규확률지;
proc univariate normal data=resid;
probplot  res/normal rotate;
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
*히스토그램-종모양; *잔차 정규성 검정 4가지 모두 >0.05, h0기각 못함: ;
proc univariate data=resid normal plot;
var res;
run;
*잔차 정규확률지-일직선;
proc univariate normal data=resid;
probplot  res/normal ;
run;



