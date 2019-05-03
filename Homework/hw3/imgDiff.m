function errorFrame = imgDiff(reference_frame, est_frame)

[height width layer] = size(reference_frame);

for i = 1: layer
    errorFrame(:,:,i) = abs(reference_frame(:,:,i)-est_frame(:,:,i));
end