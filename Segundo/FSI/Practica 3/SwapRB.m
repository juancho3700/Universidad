function imc2 = SwapRB(imc) 
B=imc(:,:,[1 2]); % Parte azul a cero
R=imc(:,:,[2 3]); % Parte roja a cero
imc(:,:,[1 2])=R;
imc(:,:,[2 3])=B;
imc2=imc;
imshow(imc2);