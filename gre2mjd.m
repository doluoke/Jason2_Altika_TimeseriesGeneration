%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function was provided to Modurodoluwa Okeowo by Hygonki Lee (PhD)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dmjd = gre2mjd(iDATE,fsec)

% Convert gregorian to modified julian date

% Updated by: Chang-Ki Hong
% Last updated: 03/01/2005
% SPIN Lab/CEEGS/The Ohio State Univ.
% mjd = gre2mjd([2000 1 1 1 1 1],0)

	if(iDATE(1) < 100 & iDATE(1) > 80)
		iyyyy = iDATE(1) + 1900;
	elseif(iDATE(1) < 80 & iDATE(1) >= 0)
		iyyyy = iDATE(1) + 2000;
	else
		iyyyy = iDATE(1);
	end;

	if(iDATE(2) > 2)
		ijy = iyyyy;
		ijm = iDATE(2) + 1;
	else
		ijy = iyyyy - 1;
		ijm = iDATE(2) + 13;
	end;
	
	aj = double(floor(ijy / 100.0));
	
	dmjd(1) = (double(floor(365.25*ijy)) + double(floor(30.6001*ijm)) + ...
				double(iDATE(3)) - 679006.0 + 2.0 - aj + double(floor(0.25*aj)))*86400.0;
	dmjd(1) = dmjd(1) + iDATE(4)*3600.0 + iDATE(5)*60.0 + double(iDATE(6));
	dmjd(2) = fsec;
	
	ti1 = double(floor(dmjd(1)));
	tf1 = dmjd(1) - ti1;
	ti2 = double(floor(dmjd(2)));
	tf2 = dmjd(2) - ti2;
	
	ti1 = ti1 + ti2;
	tf1 = tf1 + tf2;
	it = tf1;
	tf1 = tf1 - it;
	ti1 = ti1 + it;
	
	if(ti1 >= 1.0 & tf1 < 0.0)
		ti1 = ti1 - 1.0;
		tf1 = tf1 + 1.0;
	end;
	
	if(ti1 <=-1.0 & tf1 > 0.0)
		ti1 = ti1 + 1.0;
		tf1 = tf1 - 1.0;
	end
	
	dmjd(1) = ti1;
	dmjd(2) = tf1;


% End of algorithm
