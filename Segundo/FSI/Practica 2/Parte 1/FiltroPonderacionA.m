% Filtro ponderacion A


load coef_ponderacionA

fs= 48000;
f = [31.5 63 125 250 500 1000 2000 4000 8000 16000]
w = 2*pi/fs*f;
H =freqz(b_pondA, a_pondA, w);
semilogx(f, 20*log10(abs(H)))
H=freqz(b_pondA, a_pondA);
grid
title('Filtro ponderación A')
xlabel(' f (Hz)')
ylabel('dB de correccion')



