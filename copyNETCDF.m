%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code copies file into the cycle directories.
% It needs the dirwalk Function to run
% This code was written by M.A. Okeowo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[pathNames, dirNames, fileNames] = dirwalk(pwd) 

for j=2:length(pathNames)
        copyfile('netcdf_read.m',pathNames{j,1})
        
end