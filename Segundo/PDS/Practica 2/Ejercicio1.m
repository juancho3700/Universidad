n = 0:3;
x = 2.^n;
h = [1/2 1/3 1/4];
y = conv (x, h);
stem (y);