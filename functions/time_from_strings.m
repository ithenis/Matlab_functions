 function time = time_from_strings(DateStrings, TimeStrings)
 % DateStrings = {'29/09/2017','28/09/2017','27/09/2017'};
 % TimeStrings = {'20:30:30','19:30:21','14:32:01'};
 

 dates = datetime(DateStrings,'Format','MM/dd/yyyy')';
 times = datenum(TimeStrings);
 
 %Format both columns to MM/dd/yyyy HH:mm:SS for addition.
 dates = datetime(dates,'Format','MM/dd/yyyy'); dates = dates(:);
 times = datetime(times,'Format','HH:mm:SS'); times = times(:);
 %Add dates to times.
 size(dates)
 size(times)
 time = dates + timeofday(times);
