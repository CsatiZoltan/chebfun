function out = feval(f,x)
%FEVAL    Evaluate the specfied function.
%   Y = FEVAL(F, X) evaluates the UNBNDFUN F at the points X. 

% Copyright 2013 by The University of Oxford and The Chebfun Developers. 
% See http://www.chebfun.org/ for Chebfun information.

% Map the input:
z = f.mapping.inv(x);

% Make sure -Inf and Inf are mapped to -1 and 1 respectively:
mask = isinf(x); 
z(mask) = sign(x(mask));

% Evaluate the onefun
out = feval(f.onefun, z);
    
end