% a)
w = -pi : pi/60 : pi;
b = [1/2 1/3 1/4];

H = freqz (b, 1, w);

% b)
figure (1)

subplot (211), plot (abs (H))
subplot (212), plot (angle (H))
freqz (h, 1, [-pi/3, pi/3])