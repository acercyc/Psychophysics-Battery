% Struct2File(file_name,input_struct,delimiter,precision)
%
% 20090411 Acer Chang
% Rewrite Struct2File
% No redundant \t and \n
% Default delimiter is '\t'
% Default precision is '%f'
function Struct2File(file_name,input_struct,delimiter,precision)

%% function function
error(nargchk(2,4, nargin));
if (~exist('delimiter','var'))||(isempty(delimiter)),delimiter = '\t';end
if (~exist('precision','var'))||(isempty(delimiter)),precision = '%f';end
%% open file
fid = fopen(file_name,'w+');

%% first row
field_name = fieldnames(input_struct);
fprintf(fid,'%s',field_name{1});%first label
fprintf(fid,[delimiter '%s'],field_name{2:end}); %other label

%% other data
strtuct_data = squeeze(struct2cell(input_struct));
str_unit = ['%s' delimiter];

str_cell = cellfun(@num2str,strtuct_data,repmat({precision},size(strtuct_data)),'UniformOutput',0);
fprintf(fid,['\n' repmat(str_unit,1,length(field_name)-1) '%s'],str_cell{:}); %其他的欄位

%% close file
fclose(fid);
