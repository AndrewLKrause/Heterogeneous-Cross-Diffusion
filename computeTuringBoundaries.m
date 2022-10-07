% This code computes the values of x where the Turing conditions become
% satisfied.
function [T0, xs] = computeTuringBoundaries(Dc,J,x)

trc = @(x)arrayfun(@(y)trace(Dc(y)\J(y)),x);
detc = @(x)arrayfun(@(y)det(Dc(y)\J(y)),x);
T0 = trc(x)>0 & trc(x).^2-4*detc(x)>0;

% Find regions where the conditions go from being satisfied to not being
% satisfied.
I = find(diff(T0))';
xs = [];

% Precisely locate where the boundary of the Turing space is for each jump.
for i=I
    xn = fzero(@(x)trc(x).^2-4*detc(x), [x(i),x(i+1)]);
    if(trc(xn)>0)
        xs = [xs, xn];
    end
end

end