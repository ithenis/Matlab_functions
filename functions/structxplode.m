function structxplode(s)
% extracts all the fields from a structure to the base workspace

names = fieldnames(s);
for kk = 1:numel(names)
   aa = names{kk};       
   eval([names{kk} '= s.'  names{kk} ';']);
   assignin('base',eval('aa'),eval(eval('names{kk}')));
end

end

