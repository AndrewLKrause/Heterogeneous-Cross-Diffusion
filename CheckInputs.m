% This function formats the diffusion tensor D to have the right size.
function [D] = CheckInputs(D,N)

x = linspace(0,1,N)';
for i=1:2
    for j=1:2
        Dij = D{i,j}(x,x,x);
        if(length(Dij)~=N)
            D{i,j} = @(u,v,x)D{i,j}(u,v,x) +0*x;
        end
    end
end