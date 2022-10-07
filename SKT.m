
clear;
L=1;eps=0.006;
N=10000;
x = linspace(0,L,N)';

d1 = @(x)1; d11 = @(x)0*cos(5*pi*x); d12 = @(x)0+0*cos(11*pi*x);
d2 = @(x)1; d21 = @(x)x*200; d22 = @(x)0*cos(4*pi*x);

D = {};D{1,1} = @(u,v,x)eps^2*(d1(x)+d11(x).*u+d12(x).*v);
D{1,2} = @(u,v,x)eps^2*(d12(x).*u);
D{2,1} = @(u,v,x)eps^2*(d21(x).*v);
D{2,2} = @(u,v,x)eps^2*(d2(x)+d21(x).*u+d22(x).*v);

r1 = @(x)1+0*0.9*cos(x*pi);r2 = @(x)2+0*0.9*cos(x*3*pi);

a1 = @(x)0.9+0.2*cos(3*pi*x); b1 = @(x).6+0*cos(3*pi*x);
b2 = @(x)0.2+0*cos(5*pi*x); a2 = @(x).9+0.2*cos(4*pi*x);

F = {};F{1} = @(u,v)r1(x).*u.*(1-a1(x).*u-b1(x).*v);
F{2} = @(u,v)r2(x).*v.*(1-b2(x).*u-a2(x).*v);

%initial conditions 
Uss = @(x)(b1(x)-a2(x))./(b1(x).*b2(x)-a1(x).*a2(x)); 
Vss = @(x)(b2(x)-a1(x))./(b1(x).*b2(x)-a1(x).*a2(x)); 
uinit = {};uinit{1} = Uss;uinit{2} = Vss;

[u,v,T] = runSim(D,F,L,uinit,N);

%Jacobian of F:
J = @(x)[r1(x).*(1-2*a1(x).*Uss(x)-b1(x).*Vss(x)),-r1(x).*b1(x).*Uss(x);...,
    -r2(x).*b2(x).*Vss(x),r2(x).*(1-2*a2(x).*Vss(x)-b2(x).*Uss(x))];


plotSim;
