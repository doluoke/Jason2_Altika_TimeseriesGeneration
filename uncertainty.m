%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function was provided to Modurodoluwa Okeowo by Hygonki Lee (PhD)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function rmse = uncertainty(hgt)

[m n]=size(hgt);
if n~=1
    hgt = hgt';
end

if length(hgt)==0
    rmse=0;
else
    e = hgt - mean(hgt);
    sigma2 = (e'*e)/(length(hgt)-1);
    for i=1:length(hgt)
        tau(i,1) = 1;
    end
    rmse = sqrt( sigma2/(tau'*tau) );
    
    if isnan(rmse)
        rmse=0;
    end
end