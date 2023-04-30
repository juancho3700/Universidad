function imagenGrises = EscalaGrises (imagenColor)

    imagenGrises = 0.3 * imagenColor (:,:,1) + 0.59 * imagenColor (:,:,2) + 0.11 * imagenColor (:,:,3); 

end

