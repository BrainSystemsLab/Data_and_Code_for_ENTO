
function triBar3_signed(A, cmap, ttl)

A = A.';

n = size(A,1); A(1:n+1:end)=NaN;
Zup=A; Zup(~triu(true(n),1))=NaN;   
Zlo=A; Zlo(~tril(true(n),-1))=NaN;  

barW=0.70;
figure('Color','w'); 

hold on
hU = bar3(Zup,barW,'detached');
view(135,60);
hL = bar3(Zlo,barW,'detached');

% —— —— 
for k=1:numel(hU)
    z=get(hU(k),'ZData'); C=NaN(size(z)); r=reshape(1:size(z,1),6,[])';
    kill=isnan(Zup(:,k)); z(r(kill,:),:)=NaN;
    for i=find(~kill).'
        di = (k - i);              
        C(r(i,:),:) = di;          
    end
    set(hU(k),'ZData',z,'CData',C,'FaceColor','flat','EdgeColor','k','LineWidth',0.6);
end
% —— （i>j） —— 
for k=1:numel(hL)
    z=get(hL(k),'ZData'); C=NaN(size(z)); r=reshape(1:size(z,1),6,[])';
    kill=isnan(Zlo(:,k)); z(r(kill,:),:)=NaN;
    for i=find(~kill).'
        di = (k - i);
        C(r(i,:),:) = di;
    end
    set(hL(k),'ZData',z,'CData',C,'FaceColor','flat','EdgeColor','k','LineWidth',0.6);
end

% 
m  = n - 1;                
L  = 2*m + 1;         
cmapL = cmap(round(linspace(1,size(cmap,1),L)),:);  
colormap(cmapL);
caxis([-m-0.5, m+0.5]);    
cb = colorbar;
cb.Ticks = -m:m;           
ylabel(cb,'j - i');

xlabel('j'); ylabel('i'); zlabel('');
set(gca,'XTick',1:n,'YTick',1:n); axis tight

% ==========
ax = gca;
ax.Box   = 'off';
ax.ZGrid = 'off';
ax.XGrid = 'off';
ax.YGrid = 'off';
gc = [0.85 0.85 0.85]; lw = 0.5; z0 = 0;
for yi = 1:n
    plot3([0.5 n+0.5], [yi yi], [z0 z0], '-', 'Color', gc, 'LineWidth', lw);
end
for xi = 1:n
    plot3([xi xi], [0.5 n+0.5], [z0 z0], '-', 'Color', gc, 'LineWidth', lw);
end
% =====================================

view(135,60); 
title([ttl])
% plot3([0.5 n+0.5],[0.5 n+0.5],[0 0],'k-','LineWidth',2,'Clipping','off'); 
end

% function triBar3_signed(A, cmap, ttl)
% n = size(A,1); A(1:n+1:end)=NaN;
% Zup=A; Zup(~triu(true(n),1))=NaN;   % i<j
% Zlo=A; Zlo(~tril(true(n),-1))=NaN;  % i>j
% 
% barW=0.70;
% figure('Color','w'); hold on
% hU = bar3(Zup,barW,'detached');
% hL = bar3(Zlo,barW,'detached');
% 
% % —— —— 
% for k=1:numel(hU)
%     z=get(hU(k),'ZData'); C=NaN(size(z)); r=reshape(1:size(z,1),6,[])';
%     kill=isnan(Zup(:,k)); z(r(kill,:),:)=NaN;
%     for i=find(~kill).'
%         d=(k-i)/(n-1);              % ∈[-1,1]
%         C(r(i,:),:)=d;              % 
%     end
%     set(hU(k),'ZData',z,'CData',C,'FaceColor','flat','EdgeColor','k','LineWidth',0.6);
% end
% % —— （i>j） —— 
% for k=1:numel(hL)
%     z=get(hL(k),'ZData'); C=NaN(size(z)); r=reshape(1:size(z,1),6,[])';
%     kill=isnan(Zlo(:,k)); z(r(kill,:),:)=NaN;
%     for i=find(~kill).'
%         d=(k-i)/(n-1);
%         C(r(i,:),:)=d;
%     end
%     set(hL(k),'ZData',z,'CData',C,'FaceColor','flat','EdgeColor','k','LineWidth',0.6);
% end
% 
% colormap(cmap); caxis([-1 1]);
% cb = colorbar; cb.Ticks = (-n+1:n-1)/(n-1); cb.TickLabels = string(-n+1:n-1);
% ylabel(cb,'j - i');
% 
% xlabel('j'); ylabel('i'); zlabel('');
% set(gca,'XTick',1:n,'YTick',1:n); axis tight
% 
% 
% ax = gca;
% ax.Box   = 'off';    
% ax.ZGrid = 'off';    
% ax.XGrid = 'off';    
% ax.YGrid = 'off';
% 
% 
% gc = [0.85 0.85 0.85]; lw = 0.5; z0 = 0;
% for yi = 1:1:n
%     plot3([0.5 n+0.5], [yi yi], [z0 z0], '-', 'Color', gc, 'LineWidth', lw);
% end
% for xi = 1:1:n
%     plot3([xi xi], [0.5 n+0.5], [z0 z0], '-', 'Color', gc, 'LineWidth', lw);
% end
% % =====================================
% 
% view(135,60); title([ttl])
% % plot3([0.5 n+0.5],[0.5 n+0.5],[0 0],'k-','LineWidth',2,'Clipping','off'); 
% end

