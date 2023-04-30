close all;

fs=32000;		% Sampling frequency (Hz)
kf= 800; 		% Frequency deviation constant (Hz/V)
fc=3000; 		% Carrier frequency (Hz)
fm= 200; 		% Modulating frequency (Hz);

N=100000; 		% Number of samples

n=0:N-1;
Ts=1/fs;
t=n*Ts; 		% Sampling times

m=sin(2*pi*fm*t); % Modulating signal
xfm=cos(2*pi*fc*t+2*pi*kf*cumsum(m)*Ts); % FM signal

figure(1);
nn=1:500;
subplot(211),plot(t(nn),m(nn));
subplot(212),plot(t(nn),xfm(nn));

figure(2);
powerspec(xfm,Ts);


beta=kf*max(abs(m))/fm;

sxp=1/4*(besselj(0,beta))^2;


% Question 1

% La potencia de las deltas es inversamente proporcional a Kp
% Cuando disminuye la potencia por delta, aumenta el ancho de banda

% La distancia entre las deltas del espectro de potencia viene dada por FM


% Question 2

% El índice de modulación depende de K y del máximo de la señal del mensaje
% tanto en modulación de fasae como de frecuencia; y en caso de la
% modulación de frecuencia también depende de Fm

% El ancho de banda con beta = 0.1 se puede aproximar a 2 * fc, ya que el
% resto de componentes tienen potencia práctiamente nula.
% El ancho de banda con beta = 4 hay un total de 6 deltas a cada lado de
% cada una de las componentes en fc, por lo que el ancho de banda es 
% 2 * (fc + 6fm)