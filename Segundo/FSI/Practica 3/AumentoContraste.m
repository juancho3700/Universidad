function I = AumentoContraste(im)
m=min(min(im));
M=max(max(im));
if max(im(:))>1
    max_Y=255;
    min_Y=0;
else 
    max_Y=1;
    min_Y=0;
    
end

I=((im-m)/(M-m))*max_Y+min_Y;

imshow(I);