

%% write some data in a named sheet
filename = 'testdata.xlsx';
headers = {'Time','Temperature'};
x = 0:0.0005:0.1;
phi = linspace(20*10^-6,120*10^-6,numel(x));
data = [x' phi'];

sheet_name = 'sheetname';
start_cell = 'b2';
start_cell2 = 'b3';
xlswrite(filename,headers,sheet_name,start_cell)
xlswrite(filename,data,sheet_name,start_cell2)
return

%% get info about an excel file

[status,sheetnames] = xlsfinfo('testdata.xlsx');
sheetValid = any(strcmp(sheetnames, 'Barb'));