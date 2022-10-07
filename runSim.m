% This code simulates the system defined by the arguments. The time range
% *for plotting purposes only* is defined below and is given by T.
function [u, v,T] = runSim(D, F, L,Uss, N, uinit)

% This ensures D(u,v,x) is the right size.
[D] = CheckInputs(D,N);

% Spatial step and diffusion prefactor.
dx = L/(N-1);Dx = (1/dx^2);

% Evaluate the diffusion tensor on a predefined grid x.
x = linspace(0,L,N)';
D{1,1} = @(u,v)D{1,1}(u,v,x);D{1,2} = @(u,v)D{1,2}(u,v,x);
D{2,1} = @(u,v)D{2,1}(u,v,x);D{2,2} = @(u,v)D{2,2}(u,v,x);

% If no initial condition is provided, randomly perturb the given steady
% state.
rng(1);
if(nargin<6)
    uss=Uss{1}(x).*abs(1+1e-1*randn(N,1));
    vss=Uss{2}(x).*abs(1+1e-1*randn(N,1));
    uinit = [uss;vss];
end
ui = 1:N; vi=N+1:2*N;

T = linspace(0,1e4,1e3);
%T = linspace(0,50,1e3);

RHS = @(t,U)[F{1}(U(ui),U(vi))+Dx*Lap(D{1,1}(U(ui),U(vi)),U(ui))+Dx*Lap(D{1,2}(U(ui),U(vi)),U(vi));F{2}(U(ui),U(vi))+Dx*Lap(D{2,1}(U(ui),U(vi)),U(ui))+Dx*Lap(D{2,2}(U(ui),U(vi)),U(vi))];

%Construct Jacobian Sparsity Pattern
lap = spdiags([ones(N,1),-2*ones(N,1),ones(N,1)],[1,0,-1],N,N);
%Neumann conditions:
lap(1) = -1; lap(end) = -1;
LP = lap~=0; 
JPattern = [LP, LP; LP, LP];
% RelTol and AbsTol are the timestepping error tolerances.
odeparams = odeset('RelTol',1e-11,'AbsTol',1e-11,'JPattern',JPattern);


[T,U] = ode15s(RHS,T,uinit,odeparams);

u = U(:,ui); v = U(:,vi);

% Version of (u_(i+1)-u_i)*(D_(i+1)+D_i)-(u_i-u_(i-1))*(D_i+D_(i-1))/2
function Lap = Lap(D,u)

    Lap = [(u(2)-u(1)).*(D(2)+D(1));...,
        (u(3:end)-u(2:end-1)).*(D(3:end)+D(2:end-1))-(u(2:end-1)-u(1:end-2)).*(D(2:end-1)+D(1:end-2));...,
        -(u(end)-u(end-1)).*(D(end)+D(end-1))]/2; 
    % The factor of 1/2 comes from averaging the D_i in half-steps
end

end