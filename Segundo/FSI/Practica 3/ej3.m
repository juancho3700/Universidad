 im2 = im2double(im1); % Ahora la imagen es double
imshow(im2); % “imshow” funciona igual
imshow(im2/2);
% La última instrucción nos enseña la imagen con
% un 50% menos de contraste, ¿qué significa esto?: Se reduce el maximo y el
% minimo, por eso es mas oscura
