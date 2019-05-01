function result = matrixSame(m1, m2)
result = 0;
[h1 w1 l1] = size(m1);
[h2 w2 l2] = size(m2);

if (h1==h2) && (w1==w2) && (l1==l2) % Same matrix size
    % fprintf("Same Size\n");
    for i = 1: l1
        if m1(:,:,i) == m2(:,:,i)
            result = result + 1; 
        end
        if m1(:,:,i) ~= m2(:,:,i), break, end
    end
    
    if (result == l1)
        result = 1;
    end
    
else 
    fprintf("Two matrix have different size!");
    result = 0;
end    
    