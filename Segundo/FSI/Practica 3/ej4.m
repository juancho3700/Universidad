im3 = imread('mandril.bmp'); 
size(im3)%filas/  columnas/ numero de componentes necesarias para representar un color
imshow(im3);
R = im3(:,:,1);
G = im3(:,:,2);
B = im3(:,:,3); 
figure;imshow(R);title('Componente roja.');
figure;imshow(G);title('Componente verde.');
figure;imshow(B);title('Componente azul.'); 
max(max(im3(:,:,1))) ;
min(min(im3(:,:,1))) ;
max(max(im3(:,:,2))) ;
min(min(im3(:,:,2))) ;
max(max(im3(:,:,3))) ;
min(min(im3(:,:,3))) ;

%para convertir la imagen uint8 a double:

im4 = im2double(im3); % Toda la imagen
r = im2double(R);
g = im2double(G);
b = im2double(B); % Componente a componente 


imshow(im4/2);%se reduce el contraste