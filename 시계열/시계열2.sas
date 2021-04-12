*확률보행과정;
data ex1;
z1=0;
do t=1 to 300;
 a=rannor(100);
 z=z1+a;
output;
 z1=z;
end; run;
proc print data=ex1;
run;
proc gplot data=ex1;
plot z*t=1;
run; quit;

proc sgplot data=ex1;
series y=z x=t;
run; quit;





data ex2;
z1=0;
 do t=1 to 300;
 a=rannor(100);
 z=0.2+z1+a;
 output;
 z1=z;
end;
run;

proc sgplot data=ex2;
series y=z x=t;
run; quit;

proc gplot data=ex2;
plot z*t=1;
run; quit;



data ar1;
x=0;
phi=0.5;
do t = 1 to 200;
x = phi*x + rannor(20);
output;
end;
run;
proc sgplot data = ar1;
series y=x x=t;
run;
proc arima data = ar1;
identify var=x;
estimate p=1 plot;
forecast id = t lead = 5 out = res_ar1;
run;
** 1) Identify 문 - 표본자기상관함수(ACF) , 표본 부분자기상관함수(PACF) 모형식
별;
*** var : 분석하려는 변수명;
** 2) Estimate 문 - 모형의 차수를 이용하여 모수를 추정;
*** p : AR 차수;
*** q : MA 차수;
**3) Forecast 문 - 예측값 출력;
*** id : 시간변수;
*** lead : 예측을 몇번째 앞까지 할 것인지;


data ar2;
z1=0; z2= 0;
retain z 0;
do t = 1 to 200;
z = 1.2*z1 - 0.35*z2 + rannor(100);
output;
z2 = z1; z1 = z;
end;
run;
proc sgplot data = ar2;
series x=t y=z;
run;
proc gplot data = ar2;
plot z*t=1;
run;
proc arima data = ar2;
identify var=z;
run;

data ma1;
laga=0;
theta1 = 0.7;
do t = 1 to 200;
a = rannor(14);
laga=lag(a);
if laga=. then laga=0;
z = a+theta1*laga;
output;
end;
run;

proc sgplot data = ma1;
series x=t y=z;
run;
proc gplot data = ma1;
plot z*t=1;
run;
proc arima data = ma1;
identify var=z;
run;


data ma2;
laga_1=0; laga_2=0;
do t = 1 to 200;
a = rannor(1004);
laga_1=lag(a);
laga_2=lag(laga_1);
if laga_1=. then laga_1=0;
if laga_2=. then laga_2=0;
z = a + 1.2*laga_1 + 0.35*laga_2;
output;
end;
run;
proc gplot data = ma2;
plot z*t;
run;
proc arima data = ma2;
identify var=z;
run;


#4.1. 데이터 불러오기;
proc import out = flight /* 생성할 Dataset 이름 지정*/
datafile = "D:\TA_시계열분석및실습\국적·지역_및_월별_외국인_입국
자.xlsx" /* 불러올 Excel 파일이 저장되어 있는 경로 지정*/
dbms = xlsx replace ; /* 파일 종류 지정, csv 파일인 경우 xlsx가 아닌
csv로 지정 */
getnames = yes ; /* 첫 번째 레코드를 변수명으로 인식 */
run;
data flight ;
set flight;
sasdate = intnx('month', '1JAN10'D,_n_-1);
format sasdate Monyy.;
run;
#4.2. 자료 분석;
proc gplot data = flight;
plot x*sasdate;
run;
proc arima data = flight;
identify var=x;
run;





data dies;
input die;
cards;
1
3
3
5
1
2
4
5
2
6
3
2
5
4
1
;
data dies_1;
set dies;
t+1;
run;


data dies_1;
set dies_1;
X=t+(die)**2;
run;

proc sgplot data=dies_1;
series y= X x=t;
run;

proc gplot data=dies_1;
plot X*t;
run;



**** 2번 (1) ****;


symbol1 i=join v=none h=2 l=1 c=black;
symbol2 i=join v=none h=2 l=1 c=red;
data problem2;
x = 0;
do i=1 to 100;
at = rannor(0);
x = 1/2 * x +at;
output;
end;
run;
title 'first order autoregressive model';
proc gplot data=problem2;
plot x*i=1;
run;



data problem2;
set problem2;
date = intnx('month', '1JAN78'D,_n_-1);
format date Monyy.;
run;
**** 2번 (2) ****;
data problem2_1;
set problem2;
x2 = log(x+50);
run;
proc sgplot data=problem2_1;
series y=x2 x=date;
run;
proc gplot data=problem2_1;
plot x2*date;
run;


**** 2번 (3) ****;
data problem2_2;
x = 0;
do i=1 to 100;
seed = 87654123;
at = rannor(seed);
x = 1/2 * x +at;
output;
end;
run;
data problem2_2;
set problem2_2;
date = intnx('month', '1JAN78'D,_n_-1);
format date Monyy.;
run;

data problem2_3;
set problem2_2;
x2 = log(x+50);
run;
proc gplot data=problem2_3;
plot x2*date=1 x1*date=2 / overlay;
run;

proc sgplot data=problem2_3;
series y=x2 x= date;
series y=x x=date;
run;