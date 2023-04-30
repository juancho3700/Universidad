function [R,G,B] = ComponentesPunto(imc, x, y)
R=imc(y+1,x+1,1)
G=imc(y+1,x+1,2)
B=imc(y+1,x+1,3)