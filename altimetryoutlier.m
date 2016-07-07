function [ timeseries ] = altimetryoutlier( data1 )
% [timerseries]= [Cycle,Year, Longitude, Latitude, Height, Uncertainty,
% S.Dev, ****, PercentageLeft]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The altimetry altimetryoutlier.m function is an algorithm
% that was written to automatically remove the outliers
% in altimetry data.It is based on using K-means classification/clustering
% and statistical parameters to remove outliers.
% The reference datum of the height is same as the Jason input data
% Author: Modurodoluwa Okeowo, Univerity of Houston Email: maokeowo@uh.edu
% Supervised by: Hygonki Lee (PhD) Email: hlee45@central.uh.edu
% Date: August 08, 2015
% Department of Civil and Environmental Eng
% University of Houston
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data=data1;
count=0;
cycle=unique(data(:,1)); %determines the cycles in the data
timeseries=zeros(length(cycle),9);
for i=1: length(cycle)
    count=count+1;      % counts the number of circles
    cycN=cycle(i);
    indy=find(data(:,1)==cycle(i));
    cyc_Pass=data(indy,:);
    [ini_sampl col1]=size(cyc_Pass);
    
    out_mean=mean(cyc_Pass(:,5));
    out_std=std(cyc_Pass(:,5));
    out_err=cyc_Pass(:,5)-out_mean;
        
    Range=range(cyc_Pass(:,5));
    while Range>5
        indx= kmeans(cyc_Pass(:,5),2);    
        cyc_Pass=cyc_Pass(find(indx==mode(indx)),:);
        Range=range(cyc_Pass(:,5));
    end

    out_mean=mean(cyc_Pass(:,5));
    out_std=std(cyc_Pass(:,5));
    out_err=cyc_Pass(:,5)-out_mean;
    stdhgt_cyc=uncertainty(cyc_Pass(:,5));

    while out_std>0.3

        out_err=cyc_Pass(:,5)-out_mean;
        locate=find((abs(out_err))==max(abs(out_err)));
        cyc_Pass(locate,:)=[];
        out_std=std(cyc_Pass(:,5));
        stdhgt_cyc=uncertainty(cyc_Pass(:,5));
                      
    end
    [final_sampl col]=size(cyc_Pass);
    
    avgmjd= mean(cyc_Pass(:,2));
    Julyr = (avgmjd+2108-50000)/365.25 +1990; % COnvert to Julian Year
    Hgt_WGS = mean(cyc_Pass(:,5)); % 
    
    timeseries(count,:)=[cycN Julyr mean(cyc_Pass(:,3)) mean(cyc_Pass(:,4))...
    Hgt_WGS uncertainty(cyc_Pass(:,5)) std(cyc_Pass(:,5))...
    std(cyc_Pass(:,5)) (final_sampl*100/ini_sampl)];
end


end   