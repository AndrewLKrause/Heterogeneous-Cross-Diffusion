% This code produces line and kymograph plots after running a simulation.


Dc = @(x)[D{1,1}(Uss(x),Vss(x),x), D{1,2}(Uss(x),Vss(x),x);...,
    D{2,1}(Uss(x),Vss(x),x), D{2,2}(Uss(x),Vss(x),x)];

[T0, xs] = computeTuringBoundaries(Dc,J,x);

close all;
g = figure;
plot(x, u(end,:),'linewidth',2);hold on;
plot(x,Uss(x),'--k','linewidth',2)
xlabel('$x$','interpreter','latex')
ylabel('$u$','interpreter','latex')
umax = max(u(end,:)); umin = min(u(end,:));
for Xs = xs
    line([Xs,Xs], [umin, umax],'linestyle','--','color','r','linewidth',2);
end
axis tight;
ax = gca; set(ax,'fontsize',20)

% This code produces a kymograph to check for any spatiotemporal behaviour.
g = figure;
imagesc(flipud(u)); hold on
for Xs = xs
    Xs = find(x-Xs>0,1);
    line([Xs,Xs], [1, length(T)],'linestyle','--','color','r','linewidth',2);
end
xlabel('$x$','interpreter','latex')
ylabel('$t$','interpreter','latex')
ax = gca; set(ax,'Fontsize',20);
ax.XTick = [1, ax.XTick];
%The rounding below is to make nicer axes labels
ax.XTickLabel = round(x(ax.XTick)*10)/10; 
ax.YTick = [1, ax.YTick];
ax.YTickLabel = round(flip(T((ax.YTick)))/10)*10;
