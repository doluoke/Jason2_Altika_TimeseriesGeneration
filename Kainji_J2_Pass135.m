%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This code is for the Jason 2 Analysis script
%   It may be necessary to do modification for Envisat 
%   This was written on 11/04/2015: Date format on computer
%   Last modified on 2/20/2016
%   Written by: Modurodoluwa Okeowo
%   Supervised by: Hyongki Lee, Ph.D.
%Reference:
%Automated Generation of Lakes and Reservoir Water Elevation Changes From Satellite Radar Altimetry.
%  M.A. Okeowo1, 2, Hyongki Lee1, 2, Faisal Hossain3, Augusto Getirana4
% 1. Department of Civil and Environmental Engineering, University of Houston, Houston, TX, USA
% 2. National Center for Airborne Laser Mapping, University of Houston, Houston, TX, USA
% 3. Department of Civil and Environmental Engineering, University of Washington, Seattle, WA, USA
% 4. Hydrological Sciences Laboratory, NASA Goddard Space Flight Center, Greenbelt, MD, USA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 clc,clear all;
%%
%load('geoidegm2008grid.mat'); % loads the EMG2008 Grid file
Alldata_info = load(uigetfile('*.txt')); % loads the extracted txt file
Uniq_cyc_info= unique(Alldata_info(:,10)); % Check unique cycles
Index =find(Alldata_info(:,9)==0); % Index the non-flagged data
Alldata=Alldata_info(Index,10:end); %Data without the flags
%%
lat_range=[ 10.324720, 10.631642]; % Choose latitude range for data extraction
indx=find(Alldata(:,4)>lat_range(1) & Alldata(:,4)<lat_range(2)); % Limit by latitude range
Data_Seg=Alldata(indx,:); % Data for Virtual Station along track
cyc_Seg=unique(Data_Seg(:,1));
%%
[Lower_All,Upper_All] =iqrange(Data_Seg); %Performs IQR on Global data
indx_limit_All = find(Data_Seg(:,5)>Lower_All & Data_Seg(:,5)<Upper_All);
Data_Seg_IQR= Data_Seg(indx_limit_All,:);
%%
timeseries_report=altimetryoutlier( Data_Seg_IQR );% Pass data into algorithm
Hgt_Datum=timeseries_report(:,5);
%%
[Lower,Upper] =iqrange(timeseries_report);
indx_limit = find(timeseries_report(:,5)>Lower & timeseries_report(:,5)<Upper);
FinalSeries= timeseries_report(indx_limit,:);
% N=interp2(lonbp,latbp,grid,FinalSeries(:,3),FinalSeries(:,4));%Geoidal undulation;
N=0;
Hgt_Datum=FinalSeries(:,5)-N-0.7; % Reduces to WGS 84 Ellipsoid
FinalSeries(:,5)=Hgt_Datum;
%%
% MAKE PLOT
Name='Kainji Reservoir';
Satellite=' Jason 2 ';
PassNo=' 135 ';
Cycle_range='';
Gap=range(FinalSeries(:,5))/16;
figure(501)
clf;
plot(FinalSeries(:,2),FinalSeries(:,5),'b.-','linewidth',2,'markersize',15);
xlabel('Year','FontSize',15);  
ylabel('Water Elevation w.r.t WGS 84 (m)','FontSize',15);
ylim([floor(min(FinalSeries(:,5))-Gap) ceil(max(FinalSeries(:,5))+Gap) ]);
title(strcat(Name,', ',Satellite,' Pass-',PassNo),'FontSize',18,'FontWeight','normal');
set(gca,'FontName','Times New Roman','FontSize',13 );
grid on;
