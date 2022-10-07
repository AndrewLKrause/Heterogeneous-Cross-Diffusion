
clear;
L=1;eps=0.005;
N=10000;
x = linspace(0,L,N)';
D = {};D{1,1} = @(u,v,x)eps^2*1; D{1,2} = @(u,v,x)eps^2*(1+sin(3*x*pi)); 
D{2,1} = @(u,v,x)eps^2*(-2+2*x); D{2,2} = @(u,v,x)eps^2;
a = @(x)0.01+0.19*(1+cos(10*x*pi)); b=@(x)0.9+0.3*(1-cos(6*x*pi));

F = {};F{1} = @(u,v)a(x)-u+u.^2.*v;F{2} = @(u,v)b(x)-u.^2.*v;

%initial conditions 
Uss = @(x)a(x)+b(x); Vss = @(x)b(x)./(a(x)+b(x)).^2; 
uinit = {};uinit{1} = Uss;uinit{2} = Vss;

[u,v,T] = runSim(D,F,L,uinit,N);

%Jacobian of F:
J = @(x)[-1+2*Uss(x).*Vss(x), Uss(x).^2; -2*Uss(x).*Vss(x),-Uss(x).^2];

plotSim;
