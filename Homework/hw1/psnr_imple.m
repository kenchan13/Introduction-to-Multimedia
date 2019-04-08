function psnr_imple = func(A, B)
A = double(A);
B = double(B);

[M N Layer] = size(A);
error = A - B;
MSE = sum(sum(error .* error)) / (M * N);

if(MSE > 0)
    PSNR = 10*log(255*255/MSE) / log(10);
else
    PSNR = 99;
end

psnr_imple = mean(PSNR);