M = 50; N = 500;
Rx = [];
Ry = [];
x = pa3 (M, N);

b = firpm (32, [0, .24, .26, .74, .76, 1], [0 0 1 1 0 0]);
y = filter (b, 1, x');
y = y';

for j = 1:M
    Rx (j,:) = conv (x (j,:), fliplr (x (j,:)) )/N;
    Ry (j,:) = conv (y (j,:), fliplr (y (j,:)) )/N;
end

r = mean (Ry);
plotacf (r, 1/5000)