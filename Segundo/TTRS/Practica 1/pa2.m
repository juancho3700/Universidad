function x = pa2(M,N) 
% function x = pa2(M,N) 
%
% Proceso aleatorio nº2
A = rand(M,1)*ones(1,N);
B = rand(M,1)*ones(1,N);
x = ( rand(M,N)-0.5 ).*B + A;