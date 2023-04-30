function senal_grabada = grabacion(fs,t_grabacion)
% senal_grabada = grabacion(fs,t_grabacion)
% ENTRADAS
%       fs: frecuencia de muestreo en Hz
%       t_grabacion: tiempo de grabacion en s
%SALIDAS
%       senal_grabada

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n_total= t_grabacion*fs;  %numero de muestras a grabar

recObj = audiorecorder(fs, 16, 1);
disp('Start speaking.')
recordblocking(recObj, t_grabacion);
disp('End of Recording.');

senal_grabada = getaudiodata(recObj);

