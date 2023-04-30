% Función para el calculo y representación del espectro
%   verEspectro(senal, ventana, L, Nfft, fs)
%   senal = señal de la cual queremos ver el espectro
%   ventana = tipo de ventana a utilizar (sin solapamiento), posibilidades: 'rectangular', 'hamming', 'hanning'
%   L = longitud de la ventana
%   Nfft = Número de puntos de la fft
%   fs = frecuencia de muestreo a utilizar para la representación
%   Se recomienda que Nfft sea un multiplo de L, por ejemplo Nfft = 8*L. De esta manera, al calcularse la fft se realiza un zero padding que facilita que el espectro se vea con mas claridad
function verEspectro(senal,ventana,L,Nfft,fs)

if (Nfft < L)
    error('Se requiere que el numero de puntos de la FFT sea mayor o igual que la longitud de la ventana');
end

%Total de muestras de la señal
Nsenal=length(senal);  
Ts=1/fs;
t=0:Ts:Ts*(Nsenal - 1);

switch ventana
    case 'rectangular'
       window=rectwin(L);
    case 'hanning'
       window=hanning(L);
    case 'hamming'
        window=hamming(L);
end

%Normalización para que W(f=0)=1
window=window/sum(window); 

%Forzaremos que el numero total de puntos en el tiempo sea un multiplo entero de L, agregando ceros al final, si es necesario

%Numero de ventanas
columnas=ceil(Nsenal/L);
%totals es el numero total de muestras (samples)
totals=columnas*L;
if totals > Nsenal
     %Si el numero de puntos original no era multiplo entero de L
     % rellenar con ceros hasta completar
     s0=[senal; zeros(totals-Nsenal,1)];
else
     s0=senal;
end

%Convertir el vector de datos original en una matriz. Cada columna es una ventana
ss=reshape(s0,L,columnas);

%Reservar memoria
fss=zeros(Nfft,columnas);

%Enventanar y calcular el modulo de la fft de cada columna de la matriz fss
for indc=1:columnas
  wseg1=ss(:,indc).*window;
  %Como Nfft > L, la funcion fft rellenara con ceros las muestras que falten (zero padding) automaticamente
  fss(:,indc)=abs(fft(wseg1,Nfft));
end

%nos quedamos con las frecuencias entre 0 y pi
nfss=fss(1:Nfft/2+1,:);

%Calcular la media de todos los espectros
mfss=mean(nfss,2);

%Representar

%Señal en el tiempo
subplot(211), plot(t,senal), xlabel('t (s)'), ylabel('amplitud'), axis tight;

%Señal en frecuencia

%Eje horizontal de frecuencias
fHz=0:fs/Nfft:fs/2;

%Se representa la media de los espectros, en dB
subplot(212), plot(fHz,20*log10(mfss)), xlabel('f (Hz)'), ylabel('Magnitud (dB)'),axis([0 4000 -60 max(20*log10(mfss))]);

%Para ver el espectro con el eje logaritmico de frecuencias, descomentar la
%siguiente linea:
%subplot(212), semilogx(fHz,20*log10(mfss)), xlabel('f (Hz)'), ylabel('Magnitud (dB)'),axis([0 fs/2 -60 max(20*log10(mfss))]);

grid;
end