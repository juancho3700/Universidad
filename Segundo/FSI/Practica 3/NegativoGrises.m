function imneg = NegativoGrises(im) 

if isinteger(im) imneg=255-im;
else imneg=1-im;
end
imshow(imneg)
%esto equivale a la funcion de matlab J = imcomplement(I) donde J es la
%imagen resultante e I la imagen que pasar a Negativo.
%Si complementamos una imagen 2 veces vuelve a su estado original.