function [iDATE,fsec] = mjd2gre(dmjd)

% Convert modified julian date to gregorian time

% Updated by: Chang-Ki Hong
% Last updated: 03/01/2005
% SPIN Lab/CEEGS/The Ohio State Univ.


	idays = double(floor(dmjd(1) / 86400.0));
	julian = idays + 2400001;
	time_sec = dmjd(1) - idays*86400.0;

	if(time_sec < 0.0)
		time_sec = time_sec + 86400.0;
		julian = julian - 1;
	end;

	jalpha = double(floor(((julian-1867216)-0.25)/36524.25));
	ja = julian + 1 + jalpha - double(floor(0.25*jalpha));
	jb = ja + 1524;
	jc = double(floor(6680.+((jb-2439870)-122.1)/365.25));
	jd = 365*jc + double(floor(.25*jc));
	je = double(floor((jb-jd)/30.6001));
	iDATE(3) = jb - jd - double(floor(30.6001*je));
	iDATE(2) = je - 1;

	if(iDATE(2) > 12)
		iDATE(2) = iDATE(2) - 12;
	end;
	
	iDATE(1) = jc - 4715;

	if(iDATE(2) > 2)
		iDATE(1) = iDATE(1) - 1;
	end;
	
	iDATE(4) = double(floor(time_sec/3600));
	iDATE(5) = double(floor((time_sec-iDATE(4)*3600)/60));

	% iDATE(6) WILL BE ROUNDED TO THE NEAREST WHOLE NUMBER INTEGER
	iDATE(6) = double(floor(time_sec-(iDATE(4)*3600+iDATE(5)*60)));
	fsec = dmjd(2);
	
	iDATE = iDATE';


% End of algorithm
