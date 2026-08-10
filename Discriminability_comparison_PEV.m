clear;
close all
clc;


load('UDs_data.mat')
load('W2_PEV.mat')

UU=[]
UP=[]

% CMM=[]

for i=1:5
    for j=1:5
        if j>i
            TT1 = squeeze(Inc_AUROC(i,j,:))
            TT2 = squeeze(-Dec_AUROC(i,j,:))

            % [h,p,ci,stats] = ttest2(TT1, TT2);

            [p_rs, h_rs, stats_rs] = ranksum(TT1, TT2);





            % [i,j,h,p]

% A=TT1;
% B=TT2;
% % [p_rs, h_rs, stats_rs] = ranksum(A, B);   
% % Cliff's delta
% m = numel(A); n = numel(B);
% Ux = stats_rs.ranksum - m*(m+1)/2;        % Mann–Whitney 
% cles = Ux/(m*n);                          % Common language effect size
% cliffs_delta = 2*cles - 1;                % Cliff's delta
% fprintf('ranksum: p=%.4g, Cliff''s delta=%.3f\n', p_rs, cliffs_delta);
% 
% %% 
% %
% epsi = 1e-6;
% A1 = min(max(A, epsi), 1-epsi);
% B1 = min(max(B, epsi), 1-epsi);
% A_logit = log(A1./(1-A1));
% B_logit = log(B1./(1-B1));
% [~, p_welch, ~, stats_t] = ttest2(A_logit, B_logit, 'Vartype','unequal');
% 
% fprintf('Welch t (logit AUC): p=%.4g, t=%.3f, df=%.1f\n', ...
%         p_welch, stats_t.tstat, stats_t.df);
% 
% %% （
% figure('Color','w'); hold on
% boxchart(categorical([repmat("A",m,1); repmat("B",n,1)]), [A;B]);
% ylabel('AUROC'); title('A vs B: AUROC ');
% yline(0.5,'--','Chance','LabelVerticalAlignment','bottom');




           


            UU = [UU; [mean(TT1) std(TT1)/sqrt(size(TT1,1))  mean(TT2) std(TT2)/sqrt(size(TT2,1))]];
            % UP =[UP p]
            UP =[UP p_rs]
            % UP =[UP p_welch]

            % CMM=[CMM;[i j]];

        end
    end
end

% figure;
figure('Color','w'); 

Y = UU(:, [1 3]);      
E = UU(:, [2 4]);     
n = size(Y,1);


% xlabels = compose('G%d', 1:n);
xlabels = compose('P%.4f', UP);


hold on;
hb = bar(Y, 'grouped');                
% hb(1).FaceColor = [0.35 0.60 0.98];
% hb(2).FaceColor = [0.98 0.55 0.25];

% hb(1).FaceColor = [59 76 192]/255;
% hb(2).FaceColor = [180 4 38]/255;



for k = 1:2
    hb(k).FaceColor = 'flat';
end



load('cmapL.mat')


Reds = cmapL(6:end,:)

hb(2).CData(1,:) = cmapL(4,:);   
hb(1).CData(1,:) = cmapL(6,:);

hb(2).CData(2,:) = cmapL(3,:);   
hb(1).CData(2,:) = cmapL(7,:);

hb(2).CData(3,:) = cmapL(2,:);   
hb(1).CData(3,:) = cmapL(8,:);

hb(2).CData(4,:) = cmapL(1,:);   
hb(1).CData(4,:) = cmapL(9,:);




hb(2).CData(5,:) = cmapL(4,:);   
hb(1).CData(5,:) = cmapL(6,:);


hb(2).CData(6,:) = cmapL(3,:);   
hb(1).CData(6,:) = cmapL(7,:);

hb(2).CData(7,:) = cmapL(2,:);   
hb(1).CData(7,:) = cmapL(8,:);




hb(2).CData(8,:) = cmapL(4,:);   
hb(1).CData(8,:) = cmapL(6,:);

hb(2).CData(9,:) = cmapL(3,:);   
hb(1).CData(9,:) = cmapL(7,:);



hb(2).CData(10,:) = cmapL(4,:);   
hb(1).CData(10,:) = cmapL(6,:);




% hb(1).FaceColor = [40 55 150]/255;
% hb(2).FaceColor = [140 4 32]/255;



for k = 1:2
    xk = hb(k).XEndPoints;
    errorbar(xk, Y(:,k), E(:,k), 'k', 'linestyle','none', 'LineWidth', 1);
end


set(gca, 'XTick', 1:n, 'XTickLabel', xlabels, 'Box','off', 'LineWidth',1);
xlim([0.5, n+0.5]);
ylim([0, max(Y(:)+E(:))*1.15]);
ylabel('DA-sAUROC');
% legend({'A','B'}, 'Location','northwest');
% title('（Mean \pm SEM）');


% for k = 1:2
%     xk = hb(k).XEndPoints;
%     text(xk, Y(:,k)+E(:,k), compose('%.3f', Y(:,k)), ...
%         'HorizontalAlignment','center', 'VerticalAlignment','bottom', 'FontSize',8);
% end
hold off;


%%
pvals = UP

ax   = gca; hold on;
n    = size(Y,1);
x1   = hb(1).XEndPoints;            
x2   = hb(2).XEndPoints;          
yTop = max(Y+E,[],2);               

yr   = diff(ax.YLim);
ygap = 0.04*yr;                    


needTop = max(yTop + 1.5*ygap);
if needTop > ax.YLim(2), ax.YLim(2) = needTop; end

for i = 1:n
    stars = p2stars(pvals(i));     
    if stars=="n.s.", continue; end   

    y = yTop(i) + ygap;
 
    line([x1(i) x1(i) x2(i) x2(i)], [y-0.4*ygap y y y-0.4*ygap], ...
         'Color','k','LineWidth',1);
    
    
    text(mean([x1(i) x2(i)]), y+0.15*ygap, stars, ...
         'HorizontalAlignment','center','VerticalAlignment','bottom', ...
         'FontWeight','bold','FontSize',12);
end





%%








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



figure('Color','w'); 


color_A=[215,48,39]/255;
color_B=[69,117,180]/255;

% color_A=[0.937 0.231 0.172]
% color_B=[0.122 0.471 0.706]


Inc_ANO_W2=Inc_ANO_W2*100;
Dec_ANO_W2=Dec_ANO_W2*100;

[lineOut1, fillOut1] = stdshade_W(squeeze(Inc_ANO_W2(1,:,:))',0.2,[],temp_time); hold on 
lineOut1.Color = color_A
fillOut1.FaceColor = color_A

[lineOut1, fillOut1] = stdshade_W(squeeze(Inc_ANO_W2(2,:,:))',0.2,[],temp_time); hold on 
lineOut1.Color = color_A
fillOut1.FaceColor = color_A

[lineOut1, fillOut1] = stdshade_W(squeeze(Inc_ANO_W2(3,:,:))',0.6,[],temp_time); hold on 
lineOut1.Color = color_A
fillOut1.FaceColor = color_A


[lineOut1, fillOut1] = stdshade_W(squeeze(Dec_ANO_W2(1,:,:))',0.2,[],temp_time); hold on 
lineOut1.Color = color_B
fillOut1.FaceColor = color_B


[lineOut1, fillOut1] = stdshade_W(squeeze(Dec_ANO_W2(2,:,:))',0.2,[],temp_time); hold on 
lineOut1.Color = color_B
fillOut1.FaceColor = color_B

[lineOut1, fillOut1] = stdshade_W(squeeze(Dec_ANO_W2(3,:,:))',0.6,[],temp_time); hold on 
lineOut1.Color = color_B
fillOut1.FaceColor = color_B




yl = ylim;                       
% yl = [0 10];

patch([  -0.15  -0.15 0 0], ...
      [yl(1) yl(2) yl(2) yl(1)], ...
      [0.7 0.7 0.7], 'EdgeColor','none','FaceAlpha',0.3)
patch([  0.8  0.8 1 1], ...
      [yl(1) yl(2) yl(2) yl(1)], ...
      [0.7 0.7 0.7], 'EdgeColor','none','FaceAlpha',0.3)

xlim([-0.15 1])
% hold on;plot([0 0],[0 11])
% hold on;plot([0.8 0.8],[0 11])


xticks([0 0.8]); 


xticklabels({'0', '0.8'})

xlabel('Time (s)');
ylabel('PEV (%)');







%%




%% 3x5 
% clear; clc;


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






%% ------
function s = p2stars(p)
    if p < 1e-3
        s = "***";
    elseif p < 1e-2
        s = "**";
    elseif p < 0.05
        s = "*";
    else
        s = "n.s.";   
    end
end

