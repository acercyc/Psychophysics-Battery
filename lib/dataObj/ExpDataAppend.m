% Append data from experimental data STRUCTURE to a file 
% 1.0 - Acer2011/03/10_12:53
% 1.1 - Acer2011/03/13_15:25

function ExpDataAppend(filename, data)
%% Preset
field_cell = fieldnames(data);

% if there have already been this file, delete it
if length(data) == 1 
    if exist(filename, 'file')
        delete(filename);
    end
end
%% Open file
fid = fopen(filename, 'a+');

%% write headline
if length(data) == 1    
    for field_ptr = 1:length(field_cell)
        fprintf(fid,'%s\t',field_cell{field_ptr});
    end
    fprintf(fid,[char(13) '\n']);    
end

%% write the lastline
for field_ptr = 1:length(field_cell)
    data_t = data(end).(field_cell{field_ptr});
    if ischar(data_t)
        fprintf(fid,'%s\t',data_t);
    elseif isnumeric(data_t) || islogical(data_t)
        fprintf(fid,'%.15g\t', data_t);
    end
end
fprintf(fid,[char(13) '\n']);
    
%% Close file
fclose(fid);
