data cigarette;
input name $ tar;
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

proc glm data=cigarette;
	class name;
	model tar=name;
	run;
	
proc glm data=cigarette;
	class name;
	model tar=name/ solution;
run;