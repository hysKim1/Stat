
data a ; 
   input x1 x2  y; 
   eta1= (x1-(43.0+1.6)/2) / ((43.0-1.6)/2) ;
   eta2= (x2-(1357+816)/2) / ((1357-816)/2) ;
cards;
1.6 851 193
15.5 816 230
22.0 1058 172
43.0 1201 91
33.0 1357 113
40.0 1115 125
25 1000 .
;
run;

proc print data=a; run;

*1 d.f. of Error = 0  ;

proc rsreg data=a;
model y = x1 x2 ;
run;
*2;
proc glm data=a;
model y = eta1 eta2 eta1*eta1 eta2*eta2 ;
run;
*3;
proc glm data=a;
model y = x1 x2 x2*x2 x1*x1 ;
output out=testx p=pred;
run;
proc print data=testx; run;

proc rsreg data=a;
model y = eta1 eta2/lackfit ;
run;

/* 4. 에타1,에타2를 이용한 상호작용 없는 반응표면 분석           ==== */
/*data grid라는 데이터를 생성하여 y행은 모두 . 
eta1은 -1부터 1까지 0.05씩 증가할때 eta2도 -1부터 1까지 0.05씩 증가
위의 중첩된 do 구문에서의 -1 과 1사이의 값에서의 eta1,2이용하여 x1,x2로 각 각 값으로 변환 */
data grid;
do;
	y= . ;
	do eta1 = -1 to 1 by 0.05;
		do eta2 = -1 to 1 by 0.05;
			x1=((43.0-1.6)/2)*eta1 + ((43.0+1.6)/2);
	    	x2=((1357-816)/2)*eta2+((1357+816)/2);
			output;
		end;
	end;
end;
run;
*위의 grid의 각 eta 1,2를 이차항인 eta11,eta22계산, grid  합쳐서grid2 생성;
data grid2; set a grid;
eta11 = eta1*eta1;
eta22 = eta2*eta2;
run;
*gird2 데이터 출력 proc print data=grid2 ; run;
*선형회귀모형을 이용하여 예측값pred 을 새로운데이터 gridout에 저장;
proc reg data=grid2 ;
	model y = eta1 eta2 eta11 eta22;
	output out=gridout p=pred;
run;

proc print data=gridout; run;
*반응표면 분석 3d graph출력, University ed에서는 g3d 동작 안함; 
proc g3d data=gridout;
plot x1*x2=pred;
run;

proc rsreg data=gridout plots=surface(3d);
model pred = x2 x1 ;
run;


data b ; 
   input x1 x2  y; 
   eta1= (x1-(40+30)/2) / ((40-30)/2) ;
   eta2= (x2-(160+150)/2) / ((160-150)/2) ;
cards;
30 150 39.3
30 160 40
40 150 40.9
40 160 41.5
35 155 40.3
35 155 40.5
35 155 40.7
35 155 40.2
35 155 40.6

;
run;


proc rsreg data=b plots=surface(3d);
model y =  x1 x2/lackfit ;
run;


proc glm data=b ;
model y=x1 | x2 x1*x1 x2*x2 ; 
	output out=gridout p=pred;
run; 
proc print data=gridout;run;
proc rsreg data=gridout plots=surface(3d);
model pred = x2 x1 ;
run;

   eta1= (x1-(40+30)/2) / ((40-30)/2) ;
   eta2= (x2-(160+150)/2) / ((160-150)/2) ;

data grid;
do;
	y= . ;
	do eta1 = -1 to 1 by 0.05;
		do eta2 = -1 to 1 by 0.05;
			x1=((40- 30 )/2)*eta1 + ((43.0+30)/2);
	    	x2=((160-150)/2)*eta2+((160+150)/2);
			output;
		end;
	end;
end;
run;
*위의 grid의 각 eta 1,2를 이차항인 eta11,eta22계산, grid  합쳐서grid2 생성;
data grid2; set b grid;
eta11 = eta1*eta1;
eta22 = eta2*eta2;
run;
*gird2 데이터 출력 proc print data=grid2 ; run;
*선형회귀모형을 이용하여 예측값pred 을 새로운데이터 gridout에 저장;
proc reg data=grid2 ;
	model y = eta1 eta2 eta11 eta22;
	output out=gridout p=pred;
run;

proc rsreg data=gridout plots=surface(3d);
model pred = x2 x1 ;
run;


data b ; 
   input x1 x2  y; 
   eta1= (x1-(40+30)/2) / ((40-30)/2) ;
   eta2= (x2-(160+150)/2) / ((160-150)/2) ;
cards;
30 150 39.3
30 160 40
40 150 40.9
40 160 41.5
35 155 40.3
35 155 40.5
35 155 40.7
35 155 40.2
35 155 40.6
42.07 155 41.4859
27.93 155 39.2942
35 162.07 40.9196
35 147.93 40.0005

;
run;

proc print data=b;run;

proc rsreg data=b plots=surface(3d);
model y=x1 x2 /lackfit; run;


data b ; 
   input x1 x2  y; 
   eta1= (x1-(90+80)/2) / ((90-80)/2) ;
   eta2= (x2-(180+170)/2) / ((180-170)/2) ;
cards;
80 170 76.5
80 180 77
90 170 78
90 180 79.5
85 175 79.9
85 175 80.3
85 175 80
85 175 79.7
85 175 79.8
92.07 175 78.4
77.93 175 75.6
85 182.07 78.5
85 167.93 77
;
run;


proc print data=b;run;

proc rsreg data=b plots=surface(3d);
model y=x1 x2 /lackfit; run;



data b ; 
   input x1 x2  y; 
   eta1= (x1-(90+80)/2) / ((90-80)/2) ;
   eta2= (x2-(180+170)/2) / ((180-170)/2) ;
   eta11=eta1*eta1;
    eta22=eta2*eta2;
    eta12=eta1*eta2;
   
cards;
80 170 76.5
80 180 77
90 170 78
90 180 79.5
85 175 79.9
85 175 80.3
85 175 80
85 175 79.7
85 175 79.8
92.07 175 78.4
77.93 175 75.6
85 182.07 78.5
85 167.93 77
;
run;

proc reg data=b;

model y= eta1 eta2 eta11 eta22  eta12 ;
run;
proc print data=b;run;

proc rsreg data=b plots=surface(3d);
model y=x1 x2 /lackfit; run;

