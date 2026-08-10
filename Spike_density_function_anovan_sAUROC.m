clc;
clear;
close all;

load('Spike_data.mat')



edgesBins = -0.299 : 0.001 : 2.1;




addpath cmocean 

figure1 = figure('Color',[1 1 1]);
Color_sum=[[220 18 20]/255; [173 76 167]/255; [0 177 63]/255; [0 127 187]/255; [250 127 0]/255];
    for j=1:5
        

        temp_X = Spike_FF_Gauss(factorA==j,:);
       
        
         [lineOut1, fillOut1] = stdshade_W(temp_X,0.1,[],edgesBins(:,1:10:end)); hold on
         lineOut1.Color = Color_sum(j,:);
         fillOut1.FaceColor = Color_sum(j,:);

       


    end

     xlim([-0.15 2])

     xticks([0 0.8 1.8]); 


xticklabels({'0', '0.8', '1.8'})

xlabel('Time (s)');
ylabel('Spike rate (Hz)');




for bb=1:size(Spike_rate_sum,2)
    [p, tbl, stats] = anovan(Spike_rate_sum(:,bb), {factorA, factorB}, 'model', 'interaction', ...
        'varnames', {'Num', 'Std_Con'},'display','off');

    ANO_R_SUM(:,bb)=p;


end




P_T = 0.01;

P_A=(ANO_R_SUM(1,:) < P_T) & (ANO_R_SUM(2,:) >= P_T) & (ANO_R_SUM(3,:) >= P_T);


YYPP=find(P_A>0);

YYP0 = [0 find(diff(find(P_A>0))>1) size(find(P_A>0),2)];
YYP1 = (diff(YYP0));
YYP2 = find(YYP1==max(YYP1));
YYP3 = YYPP(YYP0(YYP2)+1 : YYP0(YYP2+1));

yl=ylim
hold on;plot(temp_time(YYP3),ones(1,size(YYP3,2))*(yl(end)-1),'Color',[0 0 0],'LineWidth',2)







%%






% yl = ylim;  
% 
% patch([  -0.15  -0.15 0 0], ...
%       [yl(1) yl(2) yl(2) yl(1)], ...
%       [0.7 0.7 0.7], 'EdgeColor','none','FaceAlpha',0.3)
% patch([  0.8  0.8 2 2], ...
%       [yl(1) yl(2) yl(2) yl(1)], ...
%       [0.7 0.7 0.7], 'EdgeColor','none','FaceAlpha',0.3)




%%



M_spike=mean(Spike_rate_sum(:,YYP3(1):YYP3(end))')'*5;



AA=[mean(M_spike(factorA==1)) mean(M_spike(factorA==2)) mean(M_spike(factorA==3)) mean(M_spike(factorA==4)) mean(M_spike(factorA==5))];
BB=[std(M_spike(factorA==1))/sqrt(length(M_spike(factorA==1)))
std(M_spike(factorA==2))/sqrt(length(M_spike(factorA==2)))
std(M_spike(factorA==3))/sqrt(length(M_spike(factorA==3)))
std(M_spike(factorA==4))/sqrt(length(M_spike(factorA==4)))
std(M_spike(factorA==5))/sqrt(length(M_spike(factorA==5)))]';



AA1=[mean(M_spike(factorA==1 & factorB==1)) mean(M_spike(factorA==2 & factorB==1)) mean(M_spike(factorA==3 & factorB==1)) mean(M_spike(factorA==4 & factorB==1)) mean(M_spike(factorA==5 & factorB==1))];
BB1=[std(M_spike(factorA==1 & factorB==1))/sqrt(length(M_spike(factorA==1 & factorB==1)))
std(M_spike(factorA==2 & factorB==1))/sqrt(length(M_spike(factorA==2 & factorB==1)))
std(M_spike(factorA==3 & factorB==1))/sqrt(length(M_spike(factorA==3 & factorB==1)))
std(M_spike(factorA==4 & factorB==1))/sqrt(length(M_spike(factorA==4 & factorB==1)))
std(M_spike(factorA==5 & factorB==1))/sqrt(length(M_spike(factorA==5 & factorB==1)))]';


AA2=[mean(M_spike(factorA==1 & factorB~=1)) mean(M_spike(factorA==2 & factorB~=1)) mean(M_spike(factorA==3 & factorB~=1)) mean(M_spike(factorA==4 & factorB~=1)) mean(M_spike(factorA==5 & factorB~=1))];
BB2=[std(M_spike(factorA==1 & factorB~=1))/sqrt(length(M_spike(factorA==1 & factorB~=1)))
std(M_spike(factorA==2 & factorB~=1))/sqrt(length(M_spike(factorA==2 & factorB~=1)))
std(M_spike(factorA==3 & factorB~=1))/sqrt(length(M_spike(factorA==3 & factorB~=1)))
std(M_spike(factorA==4 & factorB~=1))/sqrt(length(M_spike(factorA==4 & factorB~=1)))
std(M_spike(factorA==5 & factorB~=1))/sqrt(length(M_spike(factorA==5 & factorB~=1)))]';

figure1 = figure('Color',[1 1 1]);

hold on;errorbar([1:5], AA1, BB1, '-', 'LineWidth', 1.5, 'CapSize', 6,'Color',[0.5 0.5 0.5]);
hold on;errorbar([1:5], AA2, BB2, ':', 'LineWidth', 1.5, 'CapSize', 6,'Color',[0.5 0.5 0.5]);
hold on;errorbar([1:5], AA, BB, '-', 'LineWidth', 2.5, 'CapSize', 6,'Color',[0 0 0]);

% errorbar([1:5], AA2, BB2, '-o', 'LineWidth', 1.5, 'CapSize', 6);
xlabel('Numerosity');
ylabel('Response');
% title('Mean ± SEM Line Plot');
grid on;





% AUROC_sum = nan(5,5);

AUROC_sum = ones(5,5)/2;
% AAA=[];
for i=1:4
        for j=2:5
            if j>i 
               
                [~, ~, ~, AUC] = perfcurve([factorA(factorA==i);factorA(factorA==j)], [M_spike(factorA==i);M_spike(factorA==j)], j);


                % AAA = [AAA; [i j abs(AUC-0.5)]];
                % AAA = [AAA; [i j 2*(AUC-0.5)]];
                % AAA = [AAA; [i j AUC]];

                AUROC_sum(i,j)=AUC;
                AUROC_sum(j,i)=AUC;


                
              

            end
        end
end






dist = 2*(AUROC_sum - 0.5);           % [-1,1]



n      = size(AUROC_sum,1);
a      = 1.2;                  
b      = 0.9;                   
theta  = linspace(0,pi,n);
x      = a*cos(theta);
y      = b*sin(theta);

x=x(end:-1:1);


         



figure1 = figure('Color',[1 1 1]);

cmap   =  bluewhitered(256);
% caxis([-1 1]);



nCol   = size(cmap,1);
idxFun = @(v) round(((max(-1,min(1,v))+1)/2)*(nCol-1))+1;


                
% cmap   = cmocean('balance',256); %  brewermap(…, 'RdBu')
% nCol   = size(cmap,1);
% 
% warp = @(v) ...
%     ( v <= -core ).*          (edgeFrac*(v+1)/(1-core) )         + ...
%     ( v >  -core & v < core ).*(edgeFrac + (1-2*edgeFrac)*(v+core)/(2*core) ) + ...
%     ( v >=  core ).*          (1-edgeFrac + edgeFrac*(v-core)/(1-core) );
% 
% 
% idxFun = @(v) round(warp(max(-1,min(1,v)))*(nCol-1))+1;


% ------------------------------------------------------------------

% clf; 
hold on;
axis equal off
for i = 1:n
    for j = i+1:n
        
        
            c  = cmap( idxFun(dist(i,j)), : );
            plot([x(i) x(j)], [y(i) y(j)], 'Color', c, 'LineWidth', 2);

        
    end
end


for jm=1:5
    % scatter(x(jm), y(jm), 80, Color_sum(jm,:), 'filled', 'MarkerEdgeColor','k', 'LineWidth',1.2)  
    scatter(x(jm), y(jm), 80, Color_sum(jm,:), 'filled', 'MarkerEdgeColor',Color_sum(jm,:), 'LineWidth',1.2) 
end

% scatter(x, y, 80, 'b', 'filled', 'MarkerEdgeColor','k', 'LineWidth',1.2)

% for k = 1:n
%     text(x(k), y(k)+0.05, sprintf('%d',k), ...
%         'HorizontalAlignment','center','FontSize',11);
% end
colormap(cmap); caxis([-1 1])
cb = colorbar('southoutside');
cb.Label.String = '2(ROC_{area}-0.5)';
% title('Category distinction coded by 2(AUC-0.5)');