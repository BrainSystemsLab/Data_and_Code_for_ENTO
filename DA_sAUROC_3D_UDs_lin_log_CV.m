clear;
close all
clc;


load('UDs_data.mat')







%%

Inc_LOG = mean(Inc_AUROC,3);
Inc_LIN = mean(Inc_AUROC,3);
Inc_POW12 = mean(Inc_AUROC,3);
Inc_POW13 = mean(Inc_AUROC,3);
LOG=[]
LIN=[]
POW12=[]
POW13=[]


for i=1:5
    for j=1:5
        if j>i

            Inc_LOG(i,j) = Inc_LOG(i,j) / (log2(j)-log2(i));
            LOG = [LOG Inc_LOG(i,j)];

            Inc_LIN(i,j) = Inc_LIN(i,j) / (j-i);
            LIN = [LIN Inc_LIN(i,j)];


            Inc_POW12(i,j) = Inc_POW12(i,j) / (j.^(1/2)-i.^(1/2));
            POW12 = [POW12 Inc_POW12(i,j)];

            Inc_POW13(i,j) = Inc_POW13(i,j) / (j.^(1/3)-i.^(1/3));
            POW13 = [POW13 Inc_POW13(i,j)];
        end
    end
end

Inc_4 = [std(LIN)/mean(LIN)  std(POW12)/mean(POW12) std(POW13)/mean(POW13) std(LOG)/mean(LOG) ]




%%

Dec_LOG = mean(-Dec_AUROC,3);
Dec_LIN = mean(-Dec_AUROC,3);
Dec_POW12 = mean(-Dec_AUROC,3);
Dec_POW13 = mean(-Dec_AUROC,3);
LOG=[]
LIN=[]
POW12=[]
POW13=[]


for i=1:5
    for j=1:5
        if j>i

            Dec_LOG(i,j) = Dec_LOG(i,j) / (log2(j)-log2(i));
            LOG = [LOG Dec_LOG(i,j)];

            Dec_LIN(i,j) = Dec_LIN(i,j) / (j-i);
            LIN = [LIN Dec_LIN(i,j)];


            Dec_POW12(i,j) = Dec_POW12(i,j) / (j.^(1/2)-i.^(1/2));
            POW12 = [POW12 Dec_POW12(i,j)];

            Dec_POW13(i,j) = Dec_POW13(i,j) / (j.^(1/3)-i.^(1/3));
            POW13 = [POW13 Dec_POW13(i,j)];
        end
    end
end

Dec_4 = [ std(LIN)/mean(LIN)  std(POW12)/mean(POW12) std(POW13)/mean(POW13) std(LOG)/mean(LOG)]

%%



Inc_AAA = mean(Inc_AUROC,3)
Dec_AAA = mean(-Dec_AUROC,3)

Inc_Dec_AAA = Inc_AAA;

for i=1:5
    for j=1:5
        if j>i
            Inc_Dec_AAA(i,j)= Dec_AAA(i,j);

        end

        if j==i
            Inc_Dec_AAA(i,j)= nan;

        end
    end
end


Inc_Dec_AAA_log2=[]
Inc_Dec_AAA_lin=[]
for i=1:5
    for j=1:5
        if j~=i
            Inc_Dec_AAA_log2(i,j)= Inc_Dec_AAA(i,j) / abs(log2(j)-log2(i));
            Inc_Dec_AAA_lin(i,j)= Inc_Dec_AAA(i,j) / abs(j-i);

        end


    end
end




A=Inc_Dec_AAA
triBar3_signed(A, coolwarm_mpl(256), 'DA-sAUROC');
pause(0.5)

A=Inc_Dec_AAA_log2
triBar3_signed(A, coolwarm_mpl(256), ['logarithmic scale '  ] );
pause(0.5)

A=Inc_Dec_AAA_lin
triBar3_signed(A, coolwarm_mpl(256), [' linear scale ' ]  );
pause(0.5)


figure('Color','w'); 
hold on;plot(Inc_4,'LineWidth',1,'LineStyle',':', 'Color',[215,48,39]/255)
hold on;plot(Inc_4, '.','MarkerSize',24,'Color',[215,48,39]/255)
hold on;plot(Dec_4, 'LineWidth',1,'LineStyle',':','Color',[69,117,180]/255)
hold on;plot(Dec_4, '.','MarkerSize',24,'Color',[69,117,180]/255)

xticks([1 2 3 4]); 


xticklabels({'linear', 'power(1/2)', 'power(1/3)', 'log'})

ylabel('CV');









% Inc = Inc_4;
% Dec = Dec_4;
% scales = {'lin','Power(1/2)','Power(1/3)','log2'};
% 
% 
% cA = [59 76 192]/255;  % Inc
% cB = [180 4 38]/255;   % Dec
% 
% 
% x1 = 1:4;        
% gap = 1;         
% x2 = (x1(end)+gap) + (1:4);  
% 
% 
% figure('Color','w','Position',[100 100 800 420]); hold on
% b1 = bar(x1, Inc, 0.8, 'FaceColor','flat','EdgeColor','none'); b1.CData = repmat(cA,4,1);
% b2 = bar(x2, Dec, 0.8, 'FaceColor','flat','EdgeColor','none'); b2.CData = repmat(cB,4,1);
% 
% ax = gca;
% ax.Box = 'off';
% ax.YGrid = 'on'; ax.GridAlpha = 0.25; ax.LineWidth = 1;
% ax.XTick = [x1 x2];
% ax.XTickLabel = [scales scales];   
% xlabel('scale'); ylabel('CV');
% legend([b1 b2], {'Inc','Dec'}, 'Location','northwest');
%
% 
% 
% for h = [b1 b2]
%     x = h.XEndPoints; y = h.YEndPoints;
%     text(x, y, compose('%.3f', y), 'HorizontalAlignment','center', ...
%         'VerticalAlignment','bottom', 'FontSize',9);
% end
% 
% 
% yTop = max([Inc Dec]) * 1.12;
% text(mean(x1), yTop, 'Inc', 'HorizontalAlignment','center','FontWeight','bold');
% text(mean(x2), yTop, 'Dec', 'HorizontalAlignment','center','FontWeight','bold');
% 
% xlim([0.25 x2(end)+0.75]);
% ylim([0 yTop*1.05]);






%%



% % n      = 5;
% % a      = 1.2;                  
% % b      = 0.9;                   
% % theta  = linspace(0,pi,n);
% % x      = a*cos(theta);
% % y      = b*sin(theta);
% 
% 
% n     = 5;
% a     = 1.2;     
% b     = 0.9;     
% theta = linspace(-pi/2, pi/2, n);  
% x     = a*cos(theta);
% y     = b*sin(theta);
% 
% x=x(end:-1:1);
% % ------------------------------------------------------------------
% addpath cmocean             
% 
% 
% 
% cmap   =  bluewhitered(256);
% 
% 
% nCol   = size(cmap,1);
% idxFun = @(v) round(((max(-1,min(1,v))+1)/2)*(nCol-1))+1;
% 
% 
% % ---- --------------------------------------------------------------
% figure
% subplot(1,2,2)
% % clf; 
% hold on;
% axis equal off
% for i = 1:n
%     for j = i+1:n
%         % if dist(i,j)>0.15
% 
%             c  = cmap( idxFun(-Dec_AAA(i,j)), : );
%             plot([x(i) x(j)], [y(i) y(j)], 'Color', c, 'LineWidth', 2);
% 
%         % end
%     end
% end
% 
% Color_sum=[[220 18 20]/255; [173 76 167]/255; [0 177 63]/255; [0 127 187]/255; [250 127 0]/255];
% for jm=1:5
%     % scatter(x(jm), y(jm), 80, Color_sum(jm,:), 'filled', 'MarkerEdgeColor','k', 'LineWidth',1.2)  
%     scatter(x(jm), y(jm), 80, Color_sum(jm,:), 'filled', 'MarkerEdgeColor',Color_sum(jm,:), 'LineWidth',1.2) 
% end
% 
% % scatter(x, y, 80, 'b', 'filled', 'MarkerEdgeColor','k', 'LineWidth',1.2)
% 
% % for k = 1:n
% %     text(x(k), y(k)+0.05, sprintf('%d',k), ...
% %         'HorizontalAlignment','center','FontSize',11);
% % end
% colormap(cmap); caxis([-1 1])
% cb = colorbar('southoutside');
% cb.Label.String = '2(ROC_{area}-0.5)';
% title('Category distinction coded by 2(AUC-0.5)');
% 
% 
% 
% subplot(1,2,1)
% % clf; 
% hold on;
% axis equal off
% for i = 1:n
%     for j = i+1:n
%         % if dist(i,j)>0.15
% 
%             c  = cmap( idxFun(Inc_AAA(i,j)), : );
%             plot([x(i) x(j)], [y(i) y(j)], 'Color', c, 'LineWidth', 2);
% 
%         % end
%     end
% end
% 
% Color_sum=[[220 18 20]/255; [173 76 167]/255; [0 177 63]/255; [0 127 187]/255; [250 127 0]/255];
% for jm=1:5
%     % scatter(x(jm), y(jm), 80, Color_sum(jm,:), 'filled', 'MarkerEdgeColor','k', 'LineWidth',1.2)  
%     scatter(x(jm), y(jm), 80, Color_sum(jm,:), 'filled', 'MarkerEdgeColor',Color_sum(jm,:), 'LineWidth',1.2) 
% end
% 
% % scatter(x, y, 80, 'b', 'filled', 'MarkerEdgeColor','k', 'LineWidth',1.2)
% 
% % for k = 1:n
% %     text(x(k), y(k)+0.05, sprintf('%d',k), ...
% %         'HorizontalAlignment','center','FontSize',11);
% % end
% colormap(cmap); caxis([-1 1])
% cb = colorbar('southoutside');
% cb.Label.String = '2(ROC_{area}-0.5)';
% title('Category distinction coded by 2(AUC-0.5)');
% 
% 




%%


n     = 5;
a     = 0.9;     
b     = 0.83;      
ccm=20;
theta = linspace(-pi/2 + pi/ccm, pi/2 - pi/ccm, n);  


x     = a*cos(theta);
y     = b*sin(theta);

x=x(end:-1:1);
% -----------------------------------------------------------------
addpath cmocean             



cmap   =  bluewhitered(256);


nCol   = size(cmap,1);
idxFun = @(v) round(((max(-1,min(1,v))+1)/2)*(nCol-1))+1;


% ------------------------------------------------------------------
figure('Color','w'); 

% subplot(1,2,2)
% clf; 
hold on;
axis equal off
% axis equal
% axis off
for i = 1:n
    for j = i+1:n
        
        
            c  = cmap( idxFun(-Dec_AAA(i,j)), : );
            plot([x(i) x(j)], [y(i) y(j)], 'Color', c, 'LineWidth', 2);
            pause(0.1)

       
    end
end

Color_sum=[[220 18 20]/255; [173 76 167]/255; [0 177 63]/255; [0 127 187]/255; [250 127 0]/255];
for jm=1:5
    % scatter(x(jm), y(jm), 80, Color_sum(jm,:), 'filled', 'MarkerEdgeColor','k', 'LineWidth',1.2)  
    scatter(x(jm), y(jm), 80, Color_sum(jm,:), 'filled', 'MarkerEdgeColor',Color_sum(jm,:), 'LineWidth',1.2) 
    pause(0.1)
    
end

% scatter(x, y, 80, 'b', 'filled', 'MarkerEdgeColor','k', 'LineWidth',1.2)

% for k = 1:n
%     text(x(k), y(k)+0.05, sprintf('%d',k), ...
%         'HorizontalAlignment','center','FontSize',11);
% end


ax = subplot(1,1,1);     





colormap(ax,cmap); caxis(ax,[-1 1])
cb = colorbar(ax,'southoutside');
cb.Label.String = '2(ROC_{area}-0.5)';
% title('Category distinction coded by 2(AUC-0.5)');

%%


theta = linspace(-pi/2 + pi/ccm, pi/2 - pi/ccm, n);  % cos(theta) >= 0


x     = -a*cos(theta);
y     = -b*sin(theta);


% subplot(1,2,1)
% clf; 
hold on;
% axis equal off
% axis equal
% axis off

for i = 1:n
    for j = i+1:n
        % if dist(i,j)>0.15
        
            c  = cmap( idxFun(Inc_AAA(i,j)), : );
            plot([x(i) x(j)], [y(i) y(j)], 'Color', c, 'LineWidth', 2);
            pause(0.1)

        % end
    end
end

Color_sum=[[220 18 20]/255; [173 76 167]/255; [0 177 63]/255; [0 127 187]/255; [250 127 0]/255];
for jm=1:5
    % scatter(x(jm), y(jm), 80, Color_sum(jm,:), 'filled', 'MarkerEdgeColor','k', 'LineWidth',1.2)  
    scatter(x(jm), y(jm), 80, Color_sum(jm,:), 'filled', 'MarkerEdgeColor',Color_sum(jm,:), 'LineWidth',1.2) 
    pause(0.1)
end

% scatter(x, y, 80, 'b', 'filled', 'MarkerEdgeColor','k', 'LineWidth',1.2)

% for k = 1:n
%     text(x(k), y(k)+0.05, sprintf('%d',k), ...
%         'HorizontalAlignment','center','FontSize',11);
% end
% colormap(cmap); caxis([-1 1])
% cb = colorbar('southoutside');

colormap(ax,cmap); caxis(ax,[-1 1])
cb = colorbar(ax,'southoutside');
cb.Label.String = '2(ROC_{area}-0.5)';
% title('Category distinction coded by 2(AUC-0.5)');





% if ispc
%     fontCN = 'Microsoft YaHei';
% elseif ismac
%     fontCN = 'PingFang SC';
% else
%     fontCN = 'SimHei';
% end
% 
% 
% load('cmapL.mat')
% 
% 
% Reds = cmapL(6:end,:)
% 
% Blues = cmapL(4:-1:1,:)
% % Reds  = [254 229 217;
% %          252 174 145;
% %          251 106  74;
% %          203  24  29] / 255;
% % Blues = [222 235 247;
% %          158 202 225;
% %           66 146 198;
% %            8  81 156] / 255;
% 
% figure('Color','w','Units','centimeters','Position',[2 2 14 8]);
% 
% % ax = axes('Position',[0.06 0.12 0.90 0.80]);
% ax = subplot(1,1,1);
%  hold(ax,'on');
% xlim([0 5]); ylim([0 3]);
% axis ij; 
% axis equal; 
% % axis off;  
% 
% % for r = 0:2
% %     for c = 0:4
% %         rectangle('Position',[c r 1 1], 'EdgeColor',[0 0 0], ...
% %                   'LineWidth',0.8, 'FaceColor','none');
% %     end
% % end
% % rectangle('Position',[0 0 5 3], 'EdgeColor','k', 'LineWidth',1.0, 'FaceColor','none');
% 
% 
% text(0+0.08, 0+0.5, 'Large-preferring neurons',  'FontSize',12, ...
%      'HorizontalAlignment','left','VerticalAlignment','middle');
% 
% 
% 
% 
% text(0+0.08, 1+0.5, 'Small-preferring neurons', 'FontSize',12, ...
%      'HorizontalAlignment','left','VerticalAlignment','middle');
% text(0+0.08, 2+0.5, 'Numerical distance',  'FontSize',12, ...
%      'HorizontalAlignment','left','VerticalAlignment','middle');
% 
% 
% for k = 1:4
%     rectangle('Position',[k+0.2 0.2 0.6 0.6], 'FaceColor',Reds(k,:), ...
%               'EdgeColor','k', 'LineWidth',0.6);
% end
% 
% for k = 1:4
%     rectangle('Position',[k+0.2 1+0.2 0.6 0.6], 'FaceColor',Blues(k,:), ...
%               'EdgeColor','k', 'LineWidth',0.6);
% end
% 
% for k = 1:4
% 
%     text(k+0.5, 2+0.5, num2str(k), 'HorizontalAlignment','center', ...
%         'VerticalAlignment','middle', 'FontSize',12, 'FontName','Arial');
% end







