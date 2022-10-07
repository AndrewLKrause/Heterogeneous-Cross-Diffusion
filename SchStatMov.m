
clear;
L=1;eps=0.006;
N=10000;
x = linspace(0,L,N)';
D = {};D{1,1} = @(u,v,x)eps^2*1; D{1,2} = @(u,v,x)eps^2*(0.5+0.8*x); 
D{2,1} = @(u,v,x)eps^2*(-3+3*(x-1/2).^2); D{2,2} = @(u,v,x)eps^2;
a = @(x)0.8-12*x.^2.*(x-1).^2; b=@(x)1+0*0.2*(1+cos(x*pi));

F = {};F{1} = @(u,v)a(x)-u+u.^2.*v+0*x;F{2} = @(u,v)b(x)-u.^2.*v+0*x;

%initial conditions 
Uss = @(x)a(x)+b(x); Vss = @(x)b(x)./(a(x)+b(x)).^2; 
uinit = {};uinit{1} = Uss;uinit{2} = Vss;

[u,v,T] = runSim(D,F,L,uinit,N);

%Jacobian of F:
J = @(x)[-1+2*Uss(x).*Vss(x), Uss(x).^2; -2*Uss(x).*Vss(x),-Uss(x).^2];

plotSim;
