% Apartado a)

s1 = load('senal1.mat');
s1 = s1.senal1;

s2 = load('senal2.mat');
s2 = s2.senal2;

plot(1:length(s1), s1, '-o', 1:length(s2), s2, '-o')
hold on

% Apartado b)

n = length (s1);
fs = 1000;

T = 1/fs;
t = n*T;

% Apartado c)

d1 = 2/(2^16);
d2 = 2/(2^3);

% Apartado d)
% Error = escalón de cuantificación / 2

E1 = d1 / 2;
E2 = d2 / 2;