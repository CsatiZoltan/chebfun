function h = rdivide(f, g)
%./   Pointwise CHEBFUN right divide.
%   F./G returns a CHEBFUN that represents the function F(x)/G(x).

% Copyright 2013 by The University of Oxford and The Chebfun Developers. 
% See http://www.chebfun.org/ for Chebfun information.

% Trivial empty case:
if ( isempty(f) || isempty(g) )
    h = chebfun(); 
    return
end

% Trivial zero denominator case:
if ( isnumeric(f) && ~any(f) )
    h = 0*g;
    return
end

% If g is numeric then call TIMES():
if ( isnumeric(g) )
    if ( g == 0 )
        error('CHEBFUN:rdivide:DivisionByZero', 'Division by zero.')
    end
    h = f.*(1./g);  
    return
end

% Check for zero FUNs:
for k = 1:numel(g.funs)
    if ( iszero(g.funs{k}) )
        warning('CHEBFUN:rdivide:DivisionByZeroChebfun', ...
            'Division by zero CHEBFUN.');
    end
end

% Add breaks at the roots of g:
g = addBreaksAtRoots(g);

% Copy g to h in preperation for output:
h = g;

if ( isa(f, 'chebfun') )
    
    % Check that the domains are the same:
    if ( ~domainCheck(f, g) )
        error('CHEBFUN:rdivide:domain', 'Inconsistent domains.');
    end
    
    % Check that the orientation is the same:
    if ( xor(f.isTranposed, g.isTransposed) )
        error('CHEBFUN:rdivide:domain', ...
            'Matrix dimension do not agree (transposed)');
    end
    
    % Introduce matching breakpoints in f and g:
    [f, g] = overlap(f, g);
    
    % Loops of the FUNS:
    for k = 1:numel(g.funs)
        h.funs{k} = rdivide(f.funs{k}, g.funs{k});
    end
    
    % Divide the impulses:
    h.impulses = f.impulses(1,1,:)./g.impulses(1,1,:);
    
else
    
    % Loops of the FUNS:
    for k = 1:numel(g.funs)
        h.funs{k} = rdivide(f, g.funs{k});
    end
    
    % Divide the impulses:
    h.impulses = f./g.impulses(1,1,:);
    
end

end


