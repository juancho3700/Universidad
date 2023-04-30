function ImOut = Fusion(ImFondo,ImNueva,Mascara,PosHor)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                  %
% Fusion.                                          %
%                                                  %
% Funde una imagen de fondo y una imagen nueva.    %
% La mascara indica la zona de interes.            %
%                                                  %
% ImFondo: imagen de fondo.                        %
% ImNueva: imagen que se va a "pegar encima".      %
% Mascara: para saber los puntos de interes.       %
% PosHor:  punto de la ultima linea donde se       %
%          "pega" la nueva imagen.                 %
%                                                  %
% ImOut: imagen resultado.                         % 
%                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Ymax,Xmax,ndim] = size(ImFondo);
[DeltaY,DeltaX,ndim] = size(ImNueva);
y1 = Ymax;
y0 = y1-DeltaY+1;
x0 = PosHor;
x1 = x0+DeltaX-1;
if (y0<1)
    y0 = 1;
end
if (x0<1)
    x0 = 1;
end
if (x1>Xmax)
    x1 = Xmax;
end % Inicio
%
% Primero copiar todo el fondo.
%
ImOut = ImFondo;
%
% Ahora copiar.
%
for x=x0:x1,
    for y=y0:y1,
        Xrel = x-x0+1;
        Yrel = y-y0+1;
        if (Mascara(Yrel,Xrel))
            ImOut(y,x,:) = ImNueva(Yrel,Xrel,:);
        end
    end
end
      