*highway mpg;

data mpg_highway;
input x $ mpg;
cards;
ferrari 21
ferrari 22
ferrari 22
ferrari 20
ferrari 22
ferrari 16
porsche 30
porsche 29
porsche 28
porsche 29
porsche 25
porsche 28
porsche 21
porsche 21
;
run;

proc sgplot data=mpg_highway;
vbox mpg/category=x;
run;

proc glm data= mpg_highway;
class x;
model mpg=x;
run;

proc ttest data=mpg_highway;
class x;
var mpg;
run;

* city mpg;
data mpg_city;
input x $ mpg;
cards;
ferrari 15
ferrari 16
ferrari 16
ferrari 15
ferrari 12 ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
ferrari 16 ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
porsche 22
porsche 20
porsche 22
porsche 20
porsche 21
porsche 19
porsche 13
porsche 15
;
run;
proc sgplot data=mpg_city;
vbox mpg/ category=x;
run;


proc glm data= mpg_city;
class x;
model mpg=x;
run;

proc ttest data=mpg_city;
class x;
var mpg;
run;


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
proc sgplot data=mpg_combined;
vbox mpg/ category=x;
run;


proc glm data= mpg_combined;
class x;
model mpg=x;
run;

proc ttest data=mpg_combined;
class x;
var mpg;
run;

