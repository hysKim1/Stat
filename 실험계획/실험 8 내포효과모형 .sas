data a;
input a $ b $ y;
cards;
1 1 55.3
1 1 55.33
1 2 55.53
1 2 55.55
2 1 55.04
2 1 55.05
2 2 55.22
2 2 55.20
run;

proc glm data=a;
class a b;
model y= a b(a);
run;