im1 = imread('lenna.bmp'); %leer imagen
imshow(im1); %ver la imagen
size(im1);%primer numero:filas/alto de la imagen. Segundo numero:columnas/ancho de la imagen
max(max(im1))%lo mismo que max(im1(:))   maximo de luminancia de toda la imagen
max(im1)%te devuelve el maximo de cada columna al ser una matriz
min(min(im1))%minimo de luminancia de  toda la imagen