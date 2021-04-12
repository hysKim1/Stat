*1.1 자료 입력과 변환 input ;

Data sample;   *파일 이름;
	input t A ;*변수 이름;
	Cards;
1 2
2 11
3 12
4 29
5 6
6 10
7 23
8 33
9 13
10 46
;
proc print data=sample; run;

*1.2 시점 생성;
*t 시점 지우기;
data sample_1;
set sample;
drop t;
run;

data sample_2;
set sample_1;
t+1;* t변수 생성: 1씩 증가하는 값 +=1;
run;
/*시간변수 이름 =intnx (자료 형식, 시작일'd, _N_)
_N_ 시잠점으로부터 몇 번 수행 되었는지 알려주는 변수(관측값 수)
_N_-1 시작점 포함
, format: 열year. 분기yyq.  월monyy. 일yymmdd.   */
data sample_3;
set sample;
date=intnx('month','01jan99'd,_N_-1);
format date monyy. ;
run;

*변환을 위한 새로운 변수 생성 log, 역수, 제곱근, 차분,전 시점;
data sample_5;
set sample;
a1=log(A);
a2=1/A;
a3=a**0.5; *sqrt(A);
a4=dif(a); *t=0자료 없음.  xt- xt-1;
a5=lag(a);
run;

*white noise정상시계열 -변환 불필요, at~N(0,1);
data wn;
do t=1 to 200;    *생성될 자료의 수 200개;
x=rannor(10000); *표준정규분포 생성,seed
output;
end;
run;

proc print data=wn;run;

/*sas graph glot  global option 
symbol 1~255 개
i 관측치 연결하는 방법 none연결 없음, join 직선, spline운형곡선, needle,수직연결)
v 그래프 끝 모양 circle, star,dot , ','등등
h 선 두께
l 모양 지정 1실선,2 점선 ...45
*/
symbol1 i=join v = star l=1 c=blue;
symbol2 i=spline v = circle l=2 c=blue;
symbol3 i=needle v = ',' h=1 l=1 c=red ;
symbol i=none v = ',' h=1 l=1 c=red ; *scatter plot 처럼..;

proc gplot data=wn;
plot x*t=1;* 0~200부터 -3 +3값 안에 속함
run;

*화이트 노이즈 변환;
data wn_new;
do t=1 to 200;
x=10+rannor(150);
x2=log(x); *분산 작아짐;
x3=dif(x); *0 중심 ;
x4=lag1(x);
x5=lag3(x);
output;
end;
run;
proc print data=wn_new;run;

*자료 변환 시계열도;
proc sgplot data=wn_new;
series x=t y=x2 ;
series x=t y=x3 ;
series x=t y=x4 ;
series x=t y=x5 ;
run; 

proc sgplot data=wn_new;
scatter x=t y=x4;
scatter x=t y=x5;
run;

proc gplot data=wn_new;
plot x2*t=1;
run;
*자료 변환 산점도 겹쳐그리기 xy관계;
proc gplot data= wn_new;
plot x4*x=2 x5*x=3/overlay;
run;
