function imbn = ImagenGrises(imc) 
imbn= 0.3*imc(:,:,1) + 0.59*imc(:,:,2) + 0.11*imc(:,:,3); 
imshow(imbn)