function plot_fit_linearity(x, y, M)

    hold on
    scatter(x, y, 60, 'filled');              
    xx = linspace(min(x), max(x), 200);       
    yy = M.a + M.b*xx;
    plot(xx, yy, 'LineWidth', 2);            

    
    txt = sprintf('y = %.4f + %.4f x\\nR^2 = %.4f\\nRMSE = %.4f\\nMax dev = %.3f%% FS', ...
                  M.a, M.b, M.R2, M.RMSE, M.maxDevPctFS);
    
    xPos = min(x) + 0.05*(max(x)-min(x));
    yPos = max(y) - 0.08*(max(y)-min(y));
    text(xPos, yPos, txt, 'FontName','Consolas', ...
         'BackgroundColor','w', 'Margin',6, 'EdgeColor',[0.8 0.8 0.8]);

    legend({'data','OLS fit'}, 'Location','southeast')
    hold off
end
