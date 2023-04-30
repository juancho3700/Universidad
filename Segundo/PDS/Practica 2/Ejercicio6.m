% a)
b = [1 0.81];
a = [1 -0.9];

fvtool(b, a)


% b)
hold on;
 
x1 = -2 * pi;
x2 = 2 * pi;
y = 18.1 / sqrt (2);
plot ([x1, x2], [y, y]);
hold on;