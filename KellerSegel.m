
clear;
L=1;eps=0.005;
N=10000;
x = linspace(0,L,N)';

chi = @(x)3.05-0.1*x;%*0-0.5;

D = {};D{1,1} = @(u,v,x)eps^2*1; D{1,2} = @(u,v,x)eps^2*(-chi(x).*u); 
D{2,1} = @(u,v,x)0; D{2,2} = @(u,v,x)eps^2*1;

K = @(x)1.2-0.5*cos(2*pi*x); h = @(x)1-0.5*cos(pi*x);
F = {};F{1} = @(u,v)u.*(1-u./K(x));F{2} = @(u,v)h(x).*u-v;

%initial conditions 
Uss = @(x)K(x); Vss = @(x)K(x).*h(x); 
uinit = {};uinit{1} = Uss;uinit{2} = Vss;

[u,v,T] = runSim(D,F,L,uinit,N);

%Jacobian of F:
J = @(x)[1-2*Uss(x)./K(x), 0*Uss(x); h(x),-1-0*Vss(x)];

plotSim;
