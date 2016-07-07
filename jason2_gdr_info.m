
function jason2_gdr_info( In_Pass, lat_range, File_Suffix_name )
%JASON2_GDR_EXTRACT Summary of this function goes here
%   Detailed explanation goes here
%------------------------------------------%
% To read Jason-2 GDR data version D
% % Input areguments are ( PassNumber as Integer ,LatitudeRange as 1x2 array,File Suffix name in
%  string)
% Ensure the netcdf_read file is in the current folder
% Coded by Hyongki Lee
% Department of Civil and Environmental Eng
% University of Houston
% hlee45@central.uh.edu
% 2013.13.29
% Modified by Modurodoluwa Okeowo: 08/08/2015
%------------------------------------------%

AllFileName=dir('*.nc');
    % For each file in cycle* folder
for j=1:length(AllFileName)
        FileName=AllFileName(j).name;

        % Choose specific pass
        if str2double(FileName(17:19))==In_Pass;
            [data] = netcdf_read(FileName);
 
            % Get cycle_number and pass_number
            cycno=data.AttArray(1,16).Val;
            passno=data.AttArray(1,18).Val;

%             % Output file
            filename1 = strcat('j2_gdr_p', int2str(passno), '_',File_Suffix_name,'_info.txt');
            fout1 = fopen(filename1, 'a');
%             
            % Apply scale_factor and add_offset
            scale_factor=ones(1,177);
            add_offset=zeros(1,177);

            for k = 1:177
                for l = 1:length(data.VarArray(1,k).AttArray)
                    if(strcmp(data.VarArray(1,k).AttArray(1,l).Str,'scale_factor')==1)
                        scale_factor(1,k)=data.VarArray(1,k).AttArray(1,l).Val;
                    end
                    if(strcmp(data.VarArray(1,k).AttArray(1,l).Str,data.VarArray(1,60).AttArray(1,6).Str)==1)
                        add_offset(1,k)=data.VarArray(1,k).AttArray(1,l).Val;
                    end
                end
    
                if(scale_factor(1,k)~=1 || add_offset(1,k)~=0)
                    data.VarArray(1,k).Data=scale_factor(1,k)*double(data.VarArray(1,k).Data)+add_offset(1,k);
                end
            end

            % Set parameters
            Parameter.flag=-999;
            Parameter.dim=data.DimArray(1,1).Dim;
            Parameter.hz=data.DimArray(1,2).Dim;
            Parameter.TODAY=1/86400;

            % Get variables from Data
            time=data.VarArray(1,1).Data;
            meas_ind=data.VarArray(1,2).Data;
            time_20hz=data.VarArray(1,3).Data;
            lat=data.VarArray(1,4).Data;
            lon=data.VarArray(1,5).Data;
            lon_20hz=data.VarArray(1,6).Data;
            lat_20hz=data.VarArray(1,7).Data;
            surface_type=data.VarArray(1,8).Data;
            alt_echo_type=data.VarArray(1,9).Data;
            rad_surf_type=data.VarArray(1,10).Data;
            rad_distance_to_land=data.VarArray(1,11).Data;
            qual_alt_1hz_range_ku=data.VarArray(1,12).Data;
            qual_alt_1hz_range_ku_mle3=data.VarArray(1,13).Data;
            qual_alt_1hz_range_c=data.VarArray(1,14).Data;
            qual_alt_1hz_swh_ku=data.VarArray(1,15).Data;
            qual_alt_1hz_swh_ku_mle3=data.VarArray(1,16).Data;
            qual_alt_1hz_swh_c=data.VarArray(1,17).Data;
            qual_alt_1hz_sig0_ku=data.VarArray(1,18).Data;
            qual_alt_1hz_sig0_ku_mle3=data.VarArray(1,19).Data;
            qual_alt_1hz_sig0_c=data.VarArray(1,20).Data;
            qual_alt_1hz_off_nadir_angle_wf_ku=data.VarArray(1,21).Data;
            qual_inst_corr_1hz_range_ku=data.VarArray(1,22).Data;
            qual_inst_corr_1hz_range_ku_mle=data.VarArray(1,23).Data;
            qual_inst_corr_1hz_range_c=data.VarArray(1,24).Data;
            qual_inst_corr_1hz_swh_ku=data.VarArray(1,25).Data;
            qual_inst_corr_1hz_swh_ku_mle=data.VarArray(1,26).Data;
            qual_inst_corr_1hz_swh_c=data.VarArray(1,27).Data;
            qual_inst_corr_1hz_sig0_ku=data.VarArray(1,28).Data;
            qual_inst_corr_1hz_sig0_ku_mle=data.VarArray(1,29).Data;
            qual_inst_corr_1hz_sig0_c=data.VarArray(1,30).Data;
            qual_rad_1hz_tb187=data.VarArray(1,31).Data;
            qual_rad_1hz_tb238=data.VarArray(1,32).Data;
            qual_rad_1hz_tb340=data.VarArray(1,33).Data;
            rad_averaging_falg=data.VarArray(1,34).Data;
            rad_land_frac_187=data.VarArray(1,35).Data;
            rad_land_frac_238=data.VarArray(1,36).Data;
            rad_land_frac_340=data.VarArray(1,37).Data;            
            alt_state_flag_oper=data.VarArray(1,38).Data;
            alt_state_flag_c_band=data.VarArray(1,39).Data;
            alt_state_flag_band_seq=data.VarArray(1,40).Data;
            alt_state_flag_ku_band_status=data.VarArray(1,41).Data;
            alt_state_flag_c_band_status=data.VarArray(1,42).Data;
            alt_state_flag_acq_mode_20hz=data.VarArray(1,43).Data;
            alt_state_flag_tracking_mode_20hz=data.VarArray(1,44).Data;
            rad_state_flag_oper=data.VarArray(1,45).Data;
            orb_state_flag_diode=data.VarArray(1,46).Data;
            orb_state_flag_rest=data.VarArray(1,47).Data;
            ecmwf_meteo_map_avail=data.VarArray(1,48).Data;
            rain_flag=data.VarArray(1,49).Data;
            rad_rain_flag=data.VarArray(1,50).Data;
            ice_flag=data.VarArray(1,51).Data;
            rad_sea_ice_flag=data.VarArray(1,52).Data;
            interp_flag_tb=data.VarArray(1,53).Data;
            interp_flag_mean_sea_surface=data.VarArray(1,54).Data;
            interp_flag_mdt=data.VarArray(1,55).Data;
            interp_flag_ocean_tide_sol1=data.VarArray(1,56).Data;
            interp_flag_ocean_tide_sol2=data.VarArray(1,57).Data;
            interp_flag_meteo=data.VarArray(1,58).Data;
            alt=data.VarArray(1,59).Data;
            alt_20hz=data.VarArray(1,60).Data;
            orb_alt_rate=data.VarArray(1,61).Data;
            range_ku=data.VarArray(1,62).Data;
            range_20hz_ku=data.VarArray(1,63).Data;
            range_c=data.VarArray(1,64).Data;
            range_20hz_c=data.VarArray(1,65).Data;
            range_used_20hz_ku=data.VarArray(1,66).Data;
            range_used_20hz_c=data.VarArray(1,67).Data;
            range_rms_ku=data.VarArray(1,68).Data;
            range_rms_c=data.VarArray(1,69).Data;
            range_numval_ku=data.VarArray(1,70).Data;
            range_numval_c=data.VarArray(1,71).Data;
            range_ku_mle3=data.VarArray(1,72).Data;
            range_20hz_ku_mle3=data.VarArray(1,73).Data;
            range_used_20hz_ku_mle3=data.VarArray(1,74).Data;
            range_rms_ku_mle3=data.VarArray(1,75).Data;
            range_numval_ku_mle3=data.VarArray(1,76).Data;                 
            number_of_iterations_ku=data.VarArray(1,77).Data;
            number_of_iterations_ku_mle3=data.VarArray(1,78).Data;
            number_of_iterations_c=data.VarArray(1,79).Data;
            net_instr_corr_range_ku=data.VarArray(1,80).Data;
            net_instr_corr_range_ku_mle3=data.VarArray(1,81).Data;                       
            net_instr_corr_range_c=data.VarArray(1,82).Data;
            model_dry_tropo_corr=data.VarArray(1,83).Data;
            model_wet_tropo_corr=data.VarArray(1,84).Data;
            rad_wet_tropo_corr=data.VarArray(1,85).Data;
            iono_corr_alt_ku=data.VarArray(1,86).Data;
            iono_corr_alt_ku_mle3=data.VarArray(1,87).Data;            
            iono_corr_gim_ku=data.VarArray(1,88).Data;
            sea_state_bias_ku=data.VarArray(1,89).Data;
            sea_state_bais_ku_mle3=data.VarArray(1,90).Data;
            sea_state_bias_c=data.VarArray(1,91).Data;
            sea_state_bias_c_mle3=data.VarArray(1,92).Data;
            swh_ku=data.VarArray(1,93).Data;
            swh_20hz_ku=data.VarArray(1,94).Data;
            swh_c=data.VarArray(1,95).Data;
            swh_20hz_c=data.VarArray(1,96).Data;
            swh_used_20hz_ku=data.VarArray(1,97).Data;
            swh_used_20hz_c=data.VarArray(1,98).Data;
            swh_rms_ku=data.VarArray(1,99).Data;
            swh_rms_c=data.VarArray(1,100).Data;
            swh_numval_ku=data.VarArray(1,101).Data;
            swh_numval_c=data.VarArray(1,102).Data;
            swh_ku_mle3=data.VarArray(1,103).Data;
            swh_20hz_ku_mle3=data.VarArray(1,104).Data;
            swh_used_20hz_ku_mle3=data.VarArray(1,105).Data;
            swh_rms_ku_mle3=data.VarArray(1,106).Data;
            swh_numval_ku_mle3=data.VarArray(1,107).Data;            
            net_instr_corr_swh_ku=data.VarArray(1,108).Data;
            net_instr_corr_swh_ku_mle3=data.VarArray(1,109).Data;
            net_instr_corr_swh_c=data.VarArray(1,110).Data;
            sig0_ku=data.VarArray(1,111).Data;
            sig0_20hz_ku=data.VarArray(1,112).Data;
            sig0_c=data.VarArray(1,113).Data;
            sig0_20hz_c=data.VarArray(1,114).Data;
            sig0_used_20hz_ku=data.VarArray(1,115).Data;
            sig0_used_20hz_c=data.VarArray(1,116).Data;
            sig0_rms_ku=data.VarArray(1,117).Data;
            sig0_rms_c=data.VarArray(1,118).Data;
            sig0_numval_ku=data.VarArray(1,119).Data;
            sig0_numval_c=data.VarArray(1,120).Data;
            sig0_ku_mle3=data.VarArray(1,121).Data;
            sig0_20hz_ku_mle3=data.VarArray(1,122).Data;
            sig0_used_20hz_ku_mle3=data.VarArray(1,123).Data;
            sig0_rms_ku_mle3=data.VarArray(1,124).Data;
            sig0_numval_ku_mle3=data.VarArray(1,125).Data;
            agc_ku=data.VarArray(1,126).Data;
            agc_c=data.VarArray(1,127).Data;
            agc_rms_ku=data.VarArray(1,128).Data;
            agc_rms_c=data.VarArray(1,129).Data;
            agc_numval_ku=data.VarArray(1,130).Data;
            agc_numval_c=data.VarArray(1,131).Data;
            net_instr_corr_sig0_ku=data.VarArray(1,132).Data;
            net_instr_corr_sig0_ku_mle3=data.VarArray(1,133).Data;
            net_instr_corr_sig0_c=data.VarArray(1,134).Data;
            atmos_corr_sig0_ku=data.VarArray(1,135).Data;            
            atmos_corr_sig0_c=data.VarArray(1,136).Data;
            off_nadir_angle_wf_ku=data.VarArray(1,137).Data;
            off_nadir_angle_wf_20hz_ku=data.VarArray(1,138).Data;
            tb_187=data.VarArray(1,139).Data;
            tb_238=data.VarArray(1,140).Data;
            tb_340=data.VarArray(1,141).Data;
            tb_187_smoothed=data.VarArray(1,142).Data;
            tb_238_smoothed=data.VarArray(1,143).Data;
            tb_340_smoothed=data.VarArray(1,144).Data;
            mean_sea_surface=data.VarArray(1,145).Data;
            mean_topography=data.VarArray(1,146).Data;
            geoid=data.VarArray(1,147).Data;
            bathymetry=data.VarArray(1,148).Data;
            inv_bar_corr=data.VarArray(1,149).Data;
            hf_fluctuations_corr=data.VarArray(1,150).Data;
            ocean_tide_sol1=data.VarArray(1,151).Data;
            ocean_tide_sol2=data.VarArray(1,152).Data;
            ocean_tide_equil=data.VarArray(1,153).Data;
            ocean_tide_non_equil=data.VarArray(1,154).Data;
            load_tide_sol1=data.VarArray(1,155).Data;
            load_tide_sol2=data.VarArray(1,156).Data;
            solid_earth_tide=data.VarArray(1,157).Data;
            pole_tide=data.VarArray(1,158).Data;
            wind_speed_model_u=data.VarArray(1,159).Data;
            wind_speed_model_v=data.VarArray(1,160).Data;
            wind_speed_alt=data.VarArray(1,161).Data;
            wind_speed_alt_mle3=data.VarArray(1,162).Data;            
            wind_speed_rad=data.VarArray(1,163).Data;
            rad_water_vapor=data.VarArray(1,164).Data;
            rad_liquid_water=data.VarArray(1,165).Data;
            ice_range_20hz_ku=data.VarArray(1,166).Data;
            ice_range_20hz_c=data.VarArray(1,167).Data;
            ice_sig0_20hz_ku=data.VarArray(1,168).Data;
            ice_sig0_20hz_c=data.VarArray(1,169).Data;
            ice_qual_flag_20hz_ku=data.VarArray(1,170).Data;
            mqe_20hz_ku=data.VarArray(1,171).Data;
            mqe_20hz_ku_mle3=data.VarArray(1,172).Data;            
            mqe_20hz_c=data.VarArray(1,173).Data;
            peakiness_20hz_ku=data.VarArray(1,174).Data;
            peakiness_20hz_c=data.VarArray(1,175).Data;
            ssha=data.VarArray(1,176).Data;
            ssha_mle3=data.VarArray(1,177).Data;
           
            for p = 1:Parameter.dim
                % Select latitude boundary  
%%
                if(lat(p)<lat_range(1) || lat(p)>lat_range(2))    % pass 135 Kaiji

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
                if(iono_corr_gim_ku(p) == 32767)
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
                if(alt_state_flag_ku_band_status(p) ~= 0)
                   kFlag_count= 1;    
                else 
                   kFlag_count= 0;
%                     continue
                end
%%
    
                media_corr = model_dry_tropo_corr(p) + model_wet_tropo_corr(p) + iono_corr_gim_ku(p) + solid_earth_tide(p) + pole_tide(p);
%%
                for q = 1:Parameter.hz
%%                   
                    if(lat_20hz(p,q) == 2147.483648)
                        lat_count= 1;  
                    else 
                        lat_count= 0;
%                         continue
                    end
%%                    
                    if (ice_qual_flag_20hz_ku(p,q)~=0)
                        ice_count= 1;     
                    else 
                        ice_count= 0;
%                         continue
                    end
%%
                    mjd_20hz = time_20hz(p,q)*Parameter.TODAY + 51544;
                    icehgt_20hz = alt_20hz(p,q)- (media_corr+ice_range_20hz_ku(p,q));
%%                    
                    Flags=dry_count+ wet_count+ iono_count+ sTide_count+pTide_count+ kFlag_count+ lat_count+ ice_count;
                    fprintf(fout1, '%4d %4d %4d %4d', dry_count, wet_count, iono_count, sTide_count);
                    fprintf(fout1, '%4d %4d %4d %4d %4d', pTide_count, kFlag_count, lat_count, ice_count,Flags);
                    fprintf(fout1, '%4d %20.6f %20.6f %20.6f', cycno, mjd_20hz, lon_20hz(p,q), lat_20hz(p,q));
                    fprintf(fout1, '%20.6f %10.3f',icehgt_20hz,ice_sig0_20hz_ku(p,q));
                    fprintf(fout1, '%4d \n',ice_qual_flag_20hz_ku(p,q));                    

%                     end
                end
            end
        end

end
fclose(fout1);  
fclose('all');
