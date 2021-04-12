*14.2 2가지 요인 고려 a요인 a1,a2;
data sheep; input AB $ x y ; cards;
a1b1 209.3 11.2
a1b1 286.9 27.2
a1b1 259.1 24.4
a1b1 273.2 24
a2b1 252.4 26.1
a2b1 302.1 30.6
a2b1 287.5 31
a2b1 276.3 24.4

;

proc standard data=sheep mean=0 out=b;
var x;
run;

proc print data=b;run;
* (1)상관관계: 실험 전의 체중 -체중증가량의 상관관계 존재?-산점도- 양의 상관관계;
proc sgplot data= sheep;
scatter x=x y=y/ group=AB;
run;
*상관계수 계산 p=0.22593, p값0.401 h0기각  0과 유의하게 다르지 않음 =0;
proc corr data= sheep;
var x y ;
run;

*(2)공분산 분석- 처리수준과 x에 상호작용 없어야 하고 처리수준이 공변량(x)에 영향 안줘야함 
type 3SS p값에서x*AB 0.1566 >0.05 -> h0 기각 못함 = 공변량과 처리간 상호작용 존재하지않음 ->ANCOVA;
proc glm data=sheep;
class AB;
model y= AB x AB*x;
run;


*(3)공부분산 분석: 실험 전 체중 고려, 사료 종류에 따라 체중 증가량이 다른지 조사
type 3SS AB p값: 0.3881 >0.05 : 사료의 종류에 따라 체중 증가량에 미치는 영향 유의하지않음;

*(4)공부분산 분석:  사료종류 고려, 실험전 체중이 증가하면 체중 증가량이 증가하는지
type 3SS AB p값: 0.8335 >0.05 : 사료종류 다ㅏ르다는것 고려, 실험전 체중이 실험 후 체중증가량에 영향을 주이 않음;
*그래프 기울기 동일, 절편 상이;
proc glm data=sheep;
class AB;
model y=AB x;
run;
*(5) 사료별로 실험전 체중이 끼치는 영향 다르다고 가정(공변량-처리수준 상호작용 존재), 기울기가 다른 4개의 회귀선 구하기(solution);
*그래프 기울기 상이- solution 결과 이용 하여 구하기
a1b1 : 14.334-45.632 +0.024x +0.183x = -31.298 +0.207x
a1b2 : 14.334-14.403 +0.024x +0.058x = 28.737 -0.034x
a2b1 :14.334-17.196 +0.024x +0.087x = -2.862 +0.111x
a2b2:14.334 +0.024x; 
proc glm data=sheep;
class AB;
model y= AB x AB*x/solution;
run;

