function f = fred( K, v )
%FRED Fredholm integral operator with a LOWRANKAPPROX kernel.
% F = FRED(K, V) computes the Fredholm integral with kernel K:
%
% (F*v)(x) = int( K(x,y)*v(y), y=c..d ), x=a..b
%
% where [c d] = domain(V) and [a b c d] = domain(K). The kernel function
% K(x,y) should be smooth for best results. K is a LOWRANKAPPROX and V is a
% CHEBFUN. The result is a row CHEBFUN object.
%
% See also VOLT.

% Copyright 2014 by The University of Oxford and The Chebfun2 Developers.
% See http://www.chebfun.org/ for Chebfun information.

% Empty check:
if ( isempty( K ) )
    return
end

% Get domain of f:
dom = K.domain;

% Get the low rank representation for f:
[cols, D, rows] = cdr( K );

% Make sure v is a chebfun:
if ( isa( v, 'function_handle' ) )
    v = chebfun( v, dom(3:4) );
else
    
    % Check that the domain of CHEBFUN2 and chebfun are correct.
    if ( ~domainCheck( v, cols ) )
        error('CHEBFUN:LOWRANKAPPROX:fred:domainMismatch', ...
            'Domain of CHEBFUN and LOWRANKAPPROX kernel do not match');
    end
    
end

cols = ( cols.' * v ).';
f = cols * D * rows.';

end