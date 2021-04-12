data hw1;
	input s $ h $ g $ time @@;
	cards;
up up high  17.12
up up high 16.68 
up up low 13.61
up up low 13.48
up down high 17.20
up down high 16.98
up down low 13.13
up down low 13.02
down up high 18.29
down up high 17.14
down up low 13.60
down up low 12.78
down down high 17.57
down down high 	18.33
down down low 12.27	
down down low 12.35

;
run;
proc print data= hw1;
run;
*2 3 way ;
Proc glm data=hw1;
	Class s h g;
	Model time = s | h | g ;
	
run ;
*3 pooling ;
Proc glm data=hw1;
	Class s g h;
	Model time = s  h  g s*h h*g s*g/ alpha= 0.25 ;
	store pooling;
run ; 



*4 주효과 ; 
Proc glm data=hw1;
	Class s ;
	Model time = s   ;
	store mains;
run ;  

proc plm restore = mains;
effectplot  /clm connect;
run; 

Proc glm data=hw1;
	Class g ;
	Model time = g   ;
	store mains;
run ;  
proc plm restore = mains;
effectplot  /clm connect;
run; 
Proc glm data=hw1;
	Class h ;
	Model time = h   ;
	store mains;
run ;  
proc plm restore = mains;
effectplot  /clm connect;
run; 

/*
proc plm restore = mains;
effectplot  /clm connect;
run 
proc plm restore = pooling;
effectplot interaction (x=s)  /clm connect;
run;
proc plm restore = pooling;
effectplot interaction (x=g)  /clm connect;
run;
proc plm restore = pooling;
effectplot interaction (x=h)  /clm connect;
run;
*4 주효과 (2) 수정한 방식 ; 
proc plm restore = pooling;
effectplot interaction(x=g)/ at(h= "up" "down")   clm connect;
/*effectplot interaction (x= h sliceby= time) /  clm connect ;
effectplot interaction (x= g sliceby= time) /  clm connect;
run;*/


*5 상호작용 ;
proc glm data= hw1;
	Class s h g;
	Model time = s  h  g s*h h*g s*g ;
	lsmeans s*g / slice=s  ;
	lsmeans s*g / slice=g ;
	run;
	
*6;	
proc glm data= hw1 ;
	Class s h g;
	Model time = s  h  g s*h h*g s*h h*g s*g  ;
	lsmeans  s*g / pdiff=all adjust=tukey lines;
	run;