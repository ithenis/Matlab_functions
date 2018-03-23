for iFile = 1:numFiles
  FileName = list(iFile).name; 
  Data(iFile).FileName = FileName;
  Data(iFile).T = readtable(FileName);
end



return
% Create an Excel object.
e = actxserver('Excel.Application');

% Add a workbook.
eWorkbook = e.Workbooks.Add;
e.Visible = 1;

% Make the first sheet active.
eSheets = e.ActiveWorkbook.Sheets;
eSheet1 = eSheets.get('Item',1);
eSheet1.Activate

% Put MATLAB data into the worksheet.
A = [1 2; 3 4];
eActivesheetRange = get(e.Activesheet,'Range','A1:B2');
eActivesheetRange.Value = A;

% Read the data back into MATLAB, where array B is a cell array.
eRange = get(e.Activesheet,'Range','A1:B2');
B = eRange.Value;

% Convert the data to a double matrix. Use the following command if the cell array contains only scalar values.
B = reshape([B{:}],size(B));

% Save the workbook in a file.
SaveAs(eWorkbook,'myfile.xls')

%If the Excel program displays a dialog box about saving the file, select the appropriate response to continue.
% If you saved the file, then close the workbook.

eWorkbook.Saved = 1;
return
Close(eWorkbook)

% Quit the Excel program and delete the server object.

Quit(e)
delete(e)



return
% To hide a worksheet called "Barb":
Workbook.Worksheets.Item('Barb').Visible = false;
% make sheet invisible?
Activesheet.Visible = 0;