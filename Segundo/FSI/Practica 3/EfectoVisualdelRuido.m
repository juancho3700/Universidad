I=imread('t_toons.bmp');
J=imnoise(I,'gaussian');
figure;imshow(I)
figure;imshow(J)