%% ============ lin_metrics ============

function M = lin_metrics(x, y)

    n  = numel(y);
    X  = [ones(n,1) x];
    beta = X \ y;                     
    a = beta(1); b = beta(2);
    yhat = X*beta;
    e    = y - yhat;

    SSE = sum(e.^2);
    SST = sum( (y - mean(y)).^2 );
    R2  = 1 - SSE/SST;

    RMSE  = sqrt(mean(e.^2));
    FS    = max(y) - min(y);          % full scale
    NRMSE = RMSE / FS;

    maxDev      = max(abs(e));
    maxDevPctFS = 100 * maxDev / FS;

    M = struct('a',a,'b',b,'yhat',yhat,'resid',e,'SSE',SSE,'SST',SST, ...
               'R2',R2,'RMSE',RMSE,'NRMSE',NRMSE,'FS',FS, ...
               'maxDev',maxDev,'maxDevPctFS',maxDevPctFS);
end