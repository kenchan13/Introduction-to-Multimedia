function f = fixed(bits,value)

% f = fixed(bits,value)
% Constructor of a simulator of fixed point numbers
% Gives a fixed bit value of class "fixed"
% Output:
%       f	- An object representing a fixed point number
% Input:
%	bits	- number of bits 
%       value   - double value 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

superiorto('double')

if nargin < 2
  value=0;
  if nargin < 1
    bits=8;
  end
end

if isa(bits,'fixed')
  f=struct(bits);
else 
  f=struct(...
      'value',round(double(value) * pow2(bits)) / pow2(bits), ...
      'bits', bits);
end

%Overflow check
if any ((f.value >= 1)|(f.value < -1))
  warning('Overflow')
  f.value(abs(f.value)>1)=sign(f.value(abs(f.value)>1));
end

f=class(f,'fixed');
