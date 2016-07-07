function altika_gdr_info( In_Pass, lat_range, File_Suffix_name )
% % Input areguments are ( PassNumber as String ,LatitudeRange as 1x2 array,
%   File Suffix name in   string)
%% This code is used for extracting data from netcdf files ordered
%% by cycles. The code goes into each of the cycle folders to search
%% for the Passno needed. Once found, it extracts the range of
%% the dataset into a textfile.
%% Written by: Dr Lee; Last Modifed on: 08/05/2015 by Dolu Okeowo

CycleNum=dir();
Cycle_Folders=CycleNum([CycleNum.isdir]);
Main_Dir=pwd;
%passno='0926'; % update this for a different altimetry track
%File_Suffix_name='_UW';% update this for a different altimetry track
%lat_range= [31.950202,32.096594]; % [min_lat, max_lat] % update the latitude range
filename1 = strcat(Main_Dir,'\altika_gdrT_p', In_Pass,'_',File_Suffix_name, '.txt');
fout1 = fopen(filename1, 'a');


% For each cycle
for i=3:length(Cycle_Folders)
    %AllFileName=dir(Cycle_Folders(i).name);
    cd(Cycle_Folders(i).name);
    NetFile=strcat('*_',In_Pass,'_*.nc');
    PathFile=dir(NetFile); % update this for a different altimetry track
    if length(PathFile)==0
        cd ..;
        continue
    end

    [data] = netcdf_read(PathFile.name);

    % Get cycle_number and pass_number
    cycno=data.AttArray(1,14).Val;
    passno=data.AttArray(1,16).Val;

    % Output file

    % Apply scale_factor and add_offset
    scale_factor=ones(1,102);
    add_offset=zeros(1,102);

    for k = 1:102
        for l = 1:length(data.VarArray(1,k).AttArray)
            if(strcmp(data.VarArray(1,k).AttArray(1,l).Str,'scale_factor')==1)
                scale_factor(1,k)=data.VarArray(1,k).AttArray(1,l).Val;
            end
            if(strcmp(data.VarArray(1,k).AttArray(1,l).Str,data.VarArray(1,33).AttArray(1,6).Str)==1)
                add_offset(1,k)=data.VarArray(1,k).AttArray(1,l).Val;
            end
        end

        if(scale_factor(1,k)~=1 || add_offset(1,k)~=0)
            data.VarArray(1,k).Data=scale_factor(1,k)*double(data.VarArray(1,k).Data)+add_offset(1,k);
        end
    end

    % Set parameters
    Parameter.g2m=0.312283; %unit:m/gate,Conversion factor from range gate
                            % speedoflight/(2*bandwidth), B=480MHz 
    Parameter.g2m=0.31;
    Parameter.flag=-999;
    Parameter.dim=data.DimArray(1,1).Dim;
    Parameter.hz=data.DimArray(1,2).Dim;
    Parameter.TODAY=1/86400;

    % Get variables from Data
    time=data.VarArray(1,1).Data;
    meas_ind=data.VarArray(1,2).Data;
    time_40hz=data.VarArray(1,3).Data;
    lat=data.VarArray(1,4).Data;
    lon=data.VarArray(1,5).Data;
    lon_40hz=data.VarArray(1,6).Data;
    lat_40hz=data.VarArray(1,7).Data;
    surface_type=data.VarArray(1,8).Data;
    rad_surf_type=data.VarArray(1,9).Data;
    qual_alt_1hz_range=data.VarArray(1,10).Data;
    qual_alt_1hz_swh=data.VarArray(1,11).Data;
    qual_alt_1hz_sig0=data.VarArray(1,12).Data;
    qual_alt_1hz_off_nadir_angle_wf=data.VarArray(1,13).Data;
    qual_inst_corr_1hz_range=data.VarArray(1,14).Data;
    qual_inst_corr_1hz_swh=data.VarArray(1,15).Data;
    qual_inst_corr_1hz_sig0=data.VarArray(1,16).Data;
    qual_rad_1hz_tb_k=data.VarArray(1,17).Data;
    qual_rad_1hz_tb_ka=data.VarArray(1,18).Data;
    alt_state_flag_acq_mode_40hz=data.VarArray(1,19).Data;
    alt_state_flag_tracking_mode_40hz=data.VarArray(1,20).Data;           
    orb_state_flag_diode=data.VarArray(1,21).Data;
    orb_state_flag_rest=data.VarArray(1,22).Data;
    ecmwf_meteo_map_avail=data.VarArray(1,23).Data;            
    trailing_edge_variation_flag=data.VarArray(1,24).Data;
    trailing_edge_variation_flag_40hz=data.VarArray(1,25).Data;
    ice_flag=data.VarArray(1,26).Data;
    interp_flag_mean_sea_surface=data.VarArray(1,27).Data;
    interp_flag_mdt=data.VarArray(1,28).Data;
    interp_flag_ocean_tide_sol1=data.VarArray(1,29).Data;
    interp_flag_ocean_tide_sol2=data.VarArray(1,30).Data;
    interp_flag_meteo=data.VarArray(1,31).Data;
    alt=data.VarArray(1,32).Data;
    alt_40hz=data.VarArray(1,33).Data;
    orb_alt_rate=data.VarArray(1,34).Data;
    range=data.VarArray(1,35).Data;
    range_40hz=data.VarArray(1,36).Data;
    range_used_40hz=data.VarArray(1,37).Data;
    range_rms=data.VarArray(1,38).Data;           
    range_numval=data.VarArray(1,39).Data;               
    number_of_iterations=data.VarArray(1,40).Data;
    net_instr_corr_range=data.VarArray(1,41).Data;
    model_dry_tropo_corr=data.VarArray(1,42).Data;
    model_wet_tropo_corr=data.VarArray(1,43).Data;
    rad_wet_tropo_corr=data.VarArray(1,44).Data;
    iono_corr_gim=data.VarArray(1,45).Data;
    sea_state_bias=data.VarArray(1,46).Data;
    swh=data.VarArray(1,47).Data;
    swh_40hz=data.VarArray(1,48).Data;
    swh_used_40hz=data.VarArray(1,49).Data;
    swh_rms=data.VarArray(1,50).Data;
    swh_numval=data.VarArray(1,51).Data;           
    net_instr_corr_swh=data.VarArray(1,52).Data;
    sig0=data.VarArray(1,53).Data;
    sig0_40hz=data.VarArray(1,54).Data;
    sig0_used_40hz=data.VarArray(1,55).Data;
    sig0_rms_=data.VarArray(1,56).Data;
    sig0_numval_=data.VarArray(1,57).Data;
    agc_=data.VarArray(1,58).Data;
    agc_rms_=data.VarArray(1,59).Data;
    agc_numval_=data.VarArray(1,60).Data;
    net_instr_corr_sig0=data.VarArray(1,61).Data;
    atmos_corr_sig0=data.VarArray(1,62).Data;            
    off_nadir_angle_wf=data.VarArray(1,63).Data;
    off_nadir_angle_wf_40hz=data.VarArray(1,64).Data;
    tb_k=data.VarArray(1,65).Data;
    tb_ka=data.VarArray(1,66).Data;
    mean_sea_surface=data.VarArray(1,67).Data;
    mean_topography=data.VarArray(1,68).Data;
    geoid=data.VarArray(1,69).Data;
    bathymetry=data.VarArray(1,70).Data;
    inv_bar_corr=data.VarArray(1,71).Data;
    hf_fluctuations_corr=data.VarArray(1,72).Data;
    ocean_tide_sol1=data.VarArray(1,73).Data;
    ocean_tide_sol2=data.VarArray(1,74).Data;
    ocean_tide_equil=data.VarArray(1,75).Data;
    ocean_tide_non_equil=data.VarArray(1,76).Data;
    load_tide_sol1=data.VarArray(1,77).Data;
    load_tide_sol2=data.VarArray(1,78).Data;
    solid_earth_tide=data.VarArray(1,79).Data;
    pole_tide=data.VarArray(1,80).Data;
    wind_speed_model_u=data.VarArray(1,81).Data;
    wind_speed_model_v=data.VarArray(1,82).Data;
    wind_speed_alt=data.VarArray(1,83).Data;
    rad_water_vapor=data.VarArray(1,84).Data;
    rad_liquid_water=data.VarArray(1,85).Data;
    ice1_range_40hz=data.VarArray(1,86).Data;
    ice1_sig0_40hz=data.VarArray(1,87).Data;
    ice1_qual_flag_40hz=data.VarArray(1,88).Data;                       
    seaice_range_40hz=data.VarArray(1,89).Data;
    seaice_sig0_40hz=data.VarArray(1,90).Data;
    seaice_qual_flag_40hz=data.VarArray(1,91).Data;
    ice2_range_40hz=data.VarArray(1,92).Data;
    ice2_le_sig0_40hz=data.VarArray(1,93).Data;
    ice2_sig0_40hz=data.VarArray(1,94).Data;
    ice2_sigmal_40hz=data.VarArray(1,95).Data;
    ice2_slope1_40hz=data.VarArray(1,96).Data;
    ice2_slope2_40hz=data.VarArray(1,97).Data;
    ice2_mqe_40hz=data.VarArray(1,98).Data;
    ice2_qual_flag_40hz=data.VarArray(1,99).Data;
    mqe_40hz=data.VarArray(1,100).Data;
    peakiness_40hz=data.VarArray(1,101).Data;
    ssha=data.VarArray(1,102).Data;            

    for p = 1:Parameter.dim
        % Select latitude boundary  
%               if(lat(p)<22.46 || lat(p)>22.78)  % Pass 810 Kaptai Dam
        if(lat(p)<lat_range(1) || lat(p)>lat_range(2))  % Pass 0416 Kainji Dam
            continue
        end
%%                
                if(model_dry_tropo_corr(p) == 32767) 
                    %continue
                    dry_count= 1;       
                else 
                   dry_count= 0; 
                end
%%                
                if(model_wet_tropo_corr(p)==32767) 
                    wet_count=  1;    
                else 
                   wet_count= 0;
%                     continue
                end
%%                
                if(iono_corr_gim(p) == 32767)
                    iono_count= 1;      
                else 
                   iono_count= 0;
%                     continue
                end
%%                
                if(solid_earth_tide(p) == 32767)
                    sTide_count=  1;   
                else 
                   sTide_count= 0;
%                     continue
                end
%%                
                if(pole_tide(p) == 32767 )
                    pTide_count=  1;
                else 
                   pTide_count= 0;
%                     continue
                end 
%%
        media_corr = model_dry_tropo_corr(p) + model_wet_tropo_corr(p) + iono_corr_gim(p) + solid_earth_tide(p) + pole_tide(p);
%%
        for q = 1:Parameter.hz
%%            
            if(lat_40hz(p,q) == 2147483647)
                 lat_count= 1;  
            else 
                 lat_count= 0;
%                continue         
            end
 %%
            if (ice1_qual_flag_40hz(p,q)~=0)
%                 continue
                        ice_count= 1;     
                    else 
                        ice_count= 0;
            end
%%
            mjd_40hz = time_40hz(p,q)*Parameter.TODAY + 51544;  % Modified Julian Date

            oceanhgt_40hz = alt_40hz(p,q) - (media_corr+range_40hz(p,q));
            ice1hgt_40hz = alt_40hz(p,q) - (media_corr+ice1_range_40hz(p,q));
            seaicehgt_40hz = alt_40hz(p,q) - (media_corr+seaice_range_40hz(p,q));
            ice2hgt_40hz = alt_40hz(p,q) - (media_corr+ice2_range_40hz(p,q));                    
%%

%%
            Flags=dry_count+ wet_count+ iono_count+ sTide_count+pTide_count+ lat_count+ ice_count;
            fprintf(fout1, '%4d %4d %4d %4d', dry_count, wet_count, iono_count, sTide_count);
            fprintf(fout1, '%4d %4d %4d %4d', pTide_count, lat_count, ice_count,Flags);
            fprintf(fout1, '%4d %20.6f %20.6f %20.6f', cycno, mjd_40hz, lon_40hz(p,q), lat_40hz(p,q));
            fprintf(fout1, '%20.6f %20.6f %20.6f',ice1hgt_40hz,ice2hgt_40hz,seaicehgt_40hz);
            fprintf(fout1, '%4d %4d %4d',ice1_qual_flag_40hz(p,q),ice2_qual_flag_40hz(p,q),seaice_qual_flag_40hz(p,q));
            fprintf(fout1, '%10.3f \n', ice1_sig0_40hz(p,q));
        end
    end
    cd ..;
end

fclose(fout1); 
fclose('all');
end
