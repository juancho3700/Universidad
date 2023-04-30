
 function [Lp LeqT Lp_fs prms_fs]= SPL(p, fs, modo, ajuste)
 
 % Entradas:
 %            p : se�al a procesar
 %            fs: frecuencia de muestreo
 %            modo: 'F' o 'S'
 %            ajuste: resultado de la calibraci�n previa
 %
 % Salidas:
 %            L_p: nivel de presi�n sonora (1 valor por segundo)
 %            L_eqT: nivel de sonido continuo eqquivalente.
 %            L_p_s: nivel de presi�n sonora (1 valor por muestra)
 %            prms_fs: presi�n sonora eficaz (1 valor por muestra). No
 %                     coincide necesariamente con el valor eficaz de 'p'
 %                     ya que se tiene en cuenta el resultado de la 
 %                     calibraci�n.
 %
 if modo=='F'
     tau=0.125;
 else
     tau=1;
 end
 
 
 % C�lculo del cuadrado del valor eficaz con ponderaci�n exponencial
 prms2=filter(1/fs/tau,[1 -exp(-1/fs/tau)],p.^2);
 
 % Valor eficaz de p
 prms_fs=sqrt(prms2);
 
 duracion=floor(length(p)/fs);
 
 % Nos quedamos con un n�mero entero de segundos para obtener un
 % valor por segundo.
 prms2=prms2(1:duracion*fs);
 
 prms2=reshape(prms2,fs,duracion); % 1 columna por segundo
 
 prms2=max(prms2); % seleccionamos el m�ximo en cada segundo
 
 p0=20e-6; % presi�n sonora de referencia
 
 Lp=10*log10(prms2/p0.^2); 
 Lp_fs=10*log10(prms_fs.^2/p0.^2);
 
 LeqT=10*log10(sum(p.^2)/length(p)/p0.^2);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ajuste de calibracion para obtener dB de nivel de presion sonora
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Lp = Lp +ajuste;
Lp_fs = Lp_fs +ajuste;
LeqT=LeqT+ajuste;

%Obtenemos el valor eficaz ajustado
prms_fs=sqrt(10.^(Lp_fs/10)*p0*p0);

 