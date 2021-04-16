## Load Data 
y <-c(10,17,48,27,55,26,9,16); y=as.matrix(y)
x1<- c( 2,3,4,1,5,6,7,8)
x2 <- c(1,2,5,2,6,4,3,8)
x <- matrix(c(rep(1, 8), x1,x2), nrow = 8, ncol = 3);x # x=(1,x1,x2)

## A. hat{b} = (X^T X)^{-1} X^T y 
beta_hat <- solve( t(x) %*% x ) %*% t(x) %*% y
beta_hat


## B. SSR = hat{b}^T X^T y - (1/7) * y^T (1 1^T) y
one_mat <- matrix(rep(1, 8), nrow = 8, ncol = 1)
Jn <- one_mat %*% t( one_mat)
#y=descedent; X=x
#transopose t( ) matrix multi %*% 역 inverse : solve ()
ssr <- (t(beta_hat) %*% t(x) %*% y) - (1/8) * t(y) %*% Jn%*% y
ssr #1060.525

## C, SSE = y^T y -  hat{b}^T X^T y 
sse <- t(y) %*% y - (t(beta_hat) %*% t(x) %*% y)
sse #991.475 ; SST=SSR+SSE=2052

## D, SE( hat{b}_1 ) = sqrt( MSE * (X^T X)^{-1}의 (i,i) 번째 원소) 
mse <- sse / ( nrow(y) - 3) 
mse <- as.numeric(mse)

sb1 <- sqrt( mse * solve( t(x) %*% x)[2, 2] ) #비대각 원소 NaN으로 나옴
sb1
sb2 <- sqrt( mse * solve( t(x) %*% x)[3, 3] )
sb2


## E, x = t(4, 4) 일 때,  y 의 평균 지름에 대한 95% 신뢰구간을 
## MSE *  (X^T X)^{-1}  행렬을 이용해 구하라.  
## sas 의  proc reg 에서 UCLM , LCLM 을 이용해 그 값을 확인하라.
a <- c( 1 , 4,4 ) #X 추가 
y0 <- t(a) %*% beta_hat  #y0 = X beta_hat

uci <- y0 + qt(0.975, 7-2) * sqrt( mse * ( t(a) %*% solve(t(x) %*% x) %*% a ) )
lci <- y0 - qt(0.975, 7-2) * sqrt( mse * ( t(a) %*% solve(t(x) %*% x) %*% a ) )

upi <- y0 + qt(0.975, 7-2) * sqrt( mse * ( 1 + t(a) %*% solve(t(x) %*% x) %*% a ) )
lpi <- y0 - qt(0.975, 7-2) * sqrt( mse * ( 1 + t(a) %*% solve(t(x) %*% x) %*% a ) )

c( lpi , upi)
c(lci , uci )

  
  