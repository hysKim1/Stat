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