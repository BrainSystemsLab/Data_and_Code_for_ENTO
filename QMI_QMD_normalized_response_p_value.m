
clear;
close all
clc;





load('Response_anovan_data.mat')


% Inc_Dec = [Inc_spike_end;Dec_spike_end];
% % Inc_Dec = [Dec_spike_end;Inc_spike_end];
% figure;
% pcolor(Inc_Dec(end:-1:1,:))
% % figure;
% % imagesc(Inc_Dec)
% 
% 
% P_Inc_Dec = [Inc_P;Dec_P];
% 
% % P_Inc_Dec = [Inc_P;Dec_P(end:-1:1,:)];
% P_Inc_Dec_log10 =-log10(P_Inc_Dec)
% 
% 
% figure1 = figure;
% axes1 = axes('Parent',figure1);
% imagesc(temp_time,1:size(P_Inc_Dec_log10,1),P_Inc_Dec_log10)
% set(axes1,'CLim',[0 3],'Layer','top');
% colorbar(axes1);
% 
% 
% % figure2 = figure;
% % axes2= axes('Parent',figure2);
% % pcolor(temp_time,1:size(P_Inc_Dec_log10,1),P_Inc_Dec_log10(end:-1:1,:))
% % set(axes2,'CLim',[0 3],'Layer','top');
% % colorbar(axes2);






Z = [Inc_spike_end;Inc_spike_end(end,:);Dec_spike_end]; 


[m,n] = size(Z);
% figure('Color','w');
% figure1 = figure('Color',[1 1 1]);


figure1 = figure('Color',[1 1 1],...
    'OuterPosition',[482.333333333333 671 1668.66666666667 740]);
subplot(1,2,1)

% ——— pcolor———
[X,Y] = meshgrid(0:n,0:m);
Zp = [Z, Z(:,end); Z(end,:), Z(end,end)];   

h = pcolor(X,Y,Zp);
% shading flat                          
axis tight ij                        
colormap(parula); colorbar
% set(h,'EdgeColor','none');            
set(h,'EdgeAlpha','0.1');            


colCuts = [17 34 51 68];   
rowCuts = [156]; 

hold on
for x = colCuts
    plot([x x],[0 m],'w','LineWidth',2);   
end
for y = rowCuts
    plot([0 n],[y y],'w','LineWidth',3);   
end


plot([0 n n 0 0],[0 0 m m 0],'w','LineWidth',1,'Color',[0 0 0]);
% plot([0 n n 0 0],[0 0 m m 0],'w');

xticks([9 26 43 60 77]); 


xticklabels({'1', '2', '3', '4', '5'})

xlabel('Sample numerosity');
ylabel('Neuron #');
% pause(0.5)

P_Inc_Dec = [Inc_P;Inc_P(end,:);Dec_P];

P_Inc_Dec_log10 =-log10(P_Inc_Dec)

Z = P_Inc_Dec_log10;

[m,n] = size(Z);



subplot2 = subplot(1,2,2,'Parent',figure1);
hold(subplot2,'on');


% ——— pcolor———
[X,Y] = meshgrid(0:n,0:m);
Zp = [Z, Z(:,end); Z(end,:), Z(end,end)];   

% h = pcolor(X,Y,Zp);

h = pcolor([temp_time temp_time(1,end)],[1:size(Zp,1)]-1,Zp)

% shading flat                          
axis tight ij                          
colormap(parula); colorbar
% pause(0.5)
colormap(subplot2, "hot");

% set(h,'EdgeColor','none');            
set(h,'EdgeAlpha','0.1');  

xticks([0 0.8]); 


xticklabels({'0', '0.8'})

xlabel('Time (s)');



set(subplot2,'CLim',[0 3]);



cb = colorbar(subplot2);          
cb.Direction = 'reverse';         
cb.Ticks = 0:1:3;                  
cb.TickLabels = {'10^0','10^{-1}','10^{-2}','10^{-3}'};
cb.TickLabelInterpreter = 'tex';  
cb.Label.String = 'p-value';



colCuts = [0 0.8];    
% % rowCuts = [155];  

hold on
for x = colCuts
    plot([x x],[0 m],'w','LineWidth',2);  
end
for y = rowCuts
    plot([temp_time(1,1) temp_time(1,end)],[y y],'w','LineWidth',3);   
end


% plot([0 temp_time(1,end) temp_time(1,end) 0 0],[0 0 m m 0],'w','LineWidth',1,'Color',[0 0 0]);
% plot([0 n n 0 0],[0 0 m m 0],'w');



% axL = ax1;          
% axR = subplot2;      
% 

% linkaxes([axL, axR], 'y');
% 

% z = zoom(figure1);      z.Motion = 'vertical';   
% p = pan(figure1);       p.Motion = 'vertical';   
% 







