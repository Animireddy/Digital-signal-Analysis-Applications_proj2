Noise4('q4/Img3.png')
function [result] = Noise4(fileName)

original = imread(fileName);

nse = original(:,:,1);
[r,c] = size(nse);

X = fft2(nse);

im_fft = fftshift(X);

ftr = double(ones(r,c)); 
len = 100;   
%b = 2;
y1=ceil(c/2);
x1=ceil(r/2);
ftr(x1-2:x1+2,1:len) = 0.0;
ftr(x1-2:x1+2,c-len:c) = 0.0;     
ftr(1:len, y1-2:y1+2) = 0.0;
ftr(r-len:r, y1-2:y1+2) = 0.0;

finalimg = ftr.*im_fft;
finalimg = ifftshift(finalimg);
finalimg = ifft2(finalimg);
finalimg = abs(finalimg);

result = cat(1, uint8(finalimg));
imshow(result);
end