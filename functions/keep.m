function keep(varargin)

c = evalin('base','who;');
c = c(~ismember(c,varargin));
c = c(~ismember(c,{'c','kk'}));

assignin('base','c',c);
for kk = 1:numel(c)   
   assignin('base','kk',kk) ;
   evalin('base','clear(c{kk});');
end
evalin('base','clear(''c'',''kk'');');
% evalin('base','clc');