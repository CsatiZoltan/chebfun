function out = isreal(f)
%ISREAL   True for real DELTAFUN.
%   ISREAL(F) returns TRUE if the FUNPART and all the delta functions of F 
%   are real and FALSE otherwise.
%
%   See also REAL, IMAG.

% Copyright 2013 by The University of Oxford and The Chebfun Developers. 
% See http://www.chebfun.org for Chebfun information.

out = 1;

% Check if the funPart is real:
if ( ~isreal(f.funPart) )
    out = 0;
    return
end

% Check the delta functions:
if ( isempty(f.deltaMag) )
    return
else
    out = isreal(f.deltaMag);
end

end
