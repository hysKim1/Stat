* ch7. 각 모형의 자기상관함수 구하고 p0 ...p10 그래프 그리기;
data ar0;
 x=0;
 phi=0.8;
do t = 1 to 100;
 x = phi*x + rannor(1234)*sqrt(10); 
 output;
end;
run;

proc arima data=ar0;
	i var=x;
run;
proc arima data = ar0;
identify var=x;
estimate p=1 plot;
forecast id = t lead = 10 out = res_ar1;

proc timeseries data=ar0 plots=acf ;
var x;
run;



data ma;
laga=0;
theta1 = -0.5;
do t = 1 to 200;
a = rannor(1234)*sqrt(10);
laga=lag(a);
if laga=. then laga=0;
z = a+theta1*laga;
output;
end;
run;

proc timeseries data=ma plots=acf ;
var a;
run;

*4.  AR(1) 모형에서 자료 100개 생성해서 그림, 자기상관 함수 ACF그리기
data ar1;
x=0;
phi=0.55;
do t = 1 to 100;
x = phi*x + rannor(1234)*sqrt(5);
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