%Design a full octave-band filter bank:


BandsPerOctave = 1;
N = 6;           % Filter Order
F0 = 1000;       % Center Frequency (Hz)
Fs = 48000;      % Sampling Frequency (Hz)
f = fdesign.octave(BandsPerOctave,'Class 1','N,F0',N,F0,Fs);

%Get all the valid center frequencies in the audio range to design the filter bank:

F0 = validfrequencies(f);
Nfc = length(F0);
for i=1:Nfc,
    f.F0 = F0(i);
    Hd(i) = design(f,'butter');
end

F0_octavas=F0;

%Now design a 1/3-octave-band filter bank. Increase the order of each filter to 8:

f.BandsPerOctave = 3;
f.FilterOrder = 8;
F0 = validfrequencies(f);
Nfc = length(F0);
for i=1:Nfc,
    f.F0 = F0(i);
    Hd3(i) = design(f,'butter');
end

F0_tercio_octavas=F0;

%Visualize the magnitude response of the two filter banks. The 1/3-octave filter bank will provide a finer spectral analysis but at an increased cost since it requires 30 filters versus 10 for the full octave filter bank to cover the audio range [20 20000 Hz].

hfvt = fvtool(Hd,'FrequencyScale','log','color','white');
axis([0.01 24 -90 5])
title('Octave-Band Filter Bank')
hfvt = fvtool(Hd3,'FrequencyScale','log','color','white');
axis([0.01 24 -90 5])
title('1/3-Octave-Band Filter Bank')

save FiltrosOctavas.mat Hd Hd3;