lambda=10;
mu=5;
n=2;
m=10;
ro=lambda/mu
ro_0=1/(1+ro)

P_otk=(ro^(m+n))/((n^m)*(factorial(n)))*ro_0
Q=1-P_otk

A=lambda*Q
K_zn=ro*Q


L_och=((ro^(n+1))/(n*factorial(n)))*(1-(ro^m)*(m+1-m*ro)/((1-ro)^2))*ro_0

T_och=L_och/lambda
L_syst=L_och+K_zn
T_syst=L_syst/lambda
