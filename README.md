# Jason2_Altika_TimeseriesGeneration

Jason 2 and SARAL/AltiKa Time Series
This algorithm was developed to automate the process of generating Jason 2 and SARAL/AltiKa altimetry time series plot directly from the raw netCDF file. 
- Supported by: NASA Applied Sciences Program & SERVIR Program
- Version 1.0 and 08/08/2015
- Contact Email: maokeowo@uh.edu, hlee@uh.edu
******************************************************************************
To run this program, you need the following matlab file functions in your directory
Required matlab files:
	altika_gdr_info.m & jason2_gdr_info.m
	altimetryoutlier.m
	uncertainty.m
	iqrange.m
	netcdf_read.m (This should be copied in each of the cycle folders)
	mjd2gre.m
	gre2mjd.m
	copyNETCDF.m
	dirwalk.m
******************************************************************************
Disclaimer:
The software developer is not responsible for any liability or damages arising from the use of this algorithm.  The use of all or any part of this algorithm is prohibited without the express reference to the developer/paper below:

Okeowo, M. A., Lee, H., Hossain, F., & Getirana, A. (2017). Automated Generation of Lakes and Reservoirs Water Elevation Changes From Satellite Radar Altimetry. IEEE Journal of Selected Topics in Applied Earth Observations and Remote Sensing.

M.A. Okeowo1, 2, Hyongki Lee1, 2, Faisal Hossain3, Augusto Getirana4
1. Department of Civil and Environmental Engineering, University of Houston, Houston, TX, USA
2. National Center for Airborne Laser Mapping, University of Houston, Houston, TX, USA
3. Department of Civil and Environmental Engineering, University of Washington, Seattle, WA, USA
4. Hydrological Sciences Laboratory, NASA Goddard Space Flight Center, Greenbelt, MD, USA


 Read the Licence.txt file.

Jason-2 Time Series
Step 1:  
•	Copy the netCDF_read.m file into each downloaded cycle folder by running the copyNETCDF.m file.
•	Run the jason2_extract.m file. Ensure you change the input arguments of the jason2_gdr_info in Line 9 of jason2_extract.m file. You can extract multiple record by duplicating line 9 and changing the arguments.
To use the function; jason2_gdr_info (In_Pass, lat_range, File_Suffix_name). Where the input arguments are:
	 In_Pass: The pass number 
	lat_range: [MINlatitude, MAXlatitude] 
	File_Suffix_name: you may use any name to output the txt result.
E.g. jason2_gdr_info (135, [10.5, 10.7], ‘Kainji_Dam’)
NB: In the case of this folder, we have already extracted the j2_gdr_p135_Kainji_Dam_info.txt.  We can skip step 1.
Step 2: 
•	Run the file, Kainji_J2_Pass135.m to generate the time series plot of the study area. 
NB: A dialogue box will appear, select the txt file generated from step 1. To customize to your study area, change the lat_range input to the latitude range of the satellite track overlap extent.

SARAL/AltiKa
Step 1:  
•	Copy the netCDF_read.m file into each downloaded cycle folder by running the copyNETCDF.m file.
•	Run the altika_extract.m file. Ensure you change the input arguments of the altika_gdr_info in Line 9 of jason2_extract.m file. You can extract multiple record by duplicating line 9 and changing the arguments.
•	To use the function; altika_gdr_info (In_Pass, lat_range, File_Suffix_name). Where the input arguments are:
	 In_Pass: The pass number (As String)
	lat_range: [MINlatitude, MAXlatitude] 
	File_Suffix_name: you may use any name to output the txt result.
E.g. altika_gdr_info ('0549', [-21.0695771177,-20.6337422718], 'Furnas'); see Data_Extraction_Altika.m file.
NB: In the case of this folder, we have already extracted the altika_gdrT_p0549_Furnas .txt.  We can skip step 1.
Step 2: 
•	Run the file, Furnas_Altika.m to generate the time series plot of the study area. 
NB: A dialogue box will appear, select the txt file generated from step 1. To customize to your study area, change the lat_range input to the latitude range of the satellite track overlap extent.
