function [fp, mvx, mvy] = motionVector(f1,f2,N,Range)
[height, width, layer] = size(f2);

% For each targetFrame
for h = 1:layer
    for i = 1:N:height-N
        for j = 1:N:width-N
            MAD_min = 256;
            mvx = 0;
            mvy = 0;
            % For each search region in reference frame
            for k = -Range:Range
                for l = -Range:Range
                    MAD = 0;
                    % For each pixel in seach region
                    for u = i:i+N-1
                        for v = j:j+N-1
                            if ((u+k > 0)&&(u+k < height + 1)&&(v+l > 0)&&(v+l < width + 1))
                                MAD = MAD + abs(f1(u,v)-f2(u+k,v+l));
                            end
                        end
                    end
                    MAD = MAD/(N*N);
                    
                    
                    if (MAD<MAD_min)
                        MAD_min = MAD;
                        dy = k;
                        dx = l;
                    end
                end
            end
            fp(i:i+N-1,j:j+N-1)= f2(i+dy:i+dy+N-1,j+dx:j+dx+N-1); %put the best matching block in the predicted image
            iblk = floor((i-1)/(N+1))+1; %block index
            jblk = floor((j-1)/(N+1))+1;
            mvx(iblk,jblk) = dx; %record the estimated MV
            mvy(iblk,jblk) = dy;
        end
    end
end