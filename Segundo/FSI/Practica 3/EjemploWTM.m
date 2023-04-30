%
% Ejemplo de "esteganografia" (watermarking) a lo tonto
%
clear;
im0 = imread('lenna.bmp');
im1 = MensajeSecreto(im0,'Ejemplo de Mensaje');
imshow([im0 im1]);pause;close all;
%
% Asi vemos la imagen original (im0 = lenna) y la procesada im1:
% original a la izquierda,
% procesada a la derecha.
% ¿Se nota el procesado?
%
mensaje = LeerMensaje(im1);
fprintf('\n\nMensaje obtenido:%s.\n',mensaje);
% ¿Que hacen las funciones "MensajeSecreto" Y "LeerMensaje"?
% ¿En que se basan?
