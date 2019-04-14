function outp=p2_Quantize(inp,b)

scaling = max(abs(inp)/(1-pow2(-b)));
outp = scaling*double(fixed(b, inp/scaling));
return