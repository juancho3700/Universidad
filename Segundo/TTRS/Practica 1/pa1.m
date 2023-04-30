function x = pa1(M,N) 
% function x = pa1(M,N) 
%
% Proceso aleatorio nº 1
a = 0.02;
b = 5;
C = ones(M,1)*b*sin((1:N)*pi/N);
A = a*ones(M,1)*[1:N];
x = ( rand(M,N)-0.5 ).*C + A;
