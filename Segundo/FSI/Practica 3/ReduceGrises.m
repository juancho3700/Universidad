function img2 = ReduceGrises(img,N)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %
% Funcion que reduce a N niveles de gris. %
% %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
imaux = im2double(img); % Pasar a real
if (N>=256)
 M = 255;
elseif (N<=2)
 M = 1;
else
 M = N-1;
end % El maximo de la imagen es el numero de niveles menos 1.
imaux2 = uint8(imaux*M);
 % Imagen con N niveles de gris (enteros de 0 a M=N-1).
img2 = double(imaux2)/M; % Imagen final 
imshow(img2);

%Se aprecia la perdida de calidad notoria a partir del nivel 20 hacia abajo