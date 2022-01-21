classdef PsyData < handle
% 1.0 - Acer 2011/06/21_22:38
    properties
        subjID = 'Test';
        expStartTime;
        dataFilename;
    end
    
    properties (Dependent)  
        dataFilename_temp;
    end

%% constructor    
    methods 
        function obj = PsyData
            obj.expStartTime = datestr(now);
        end
    end
    
%% Regular Function   
    methods 
        function enterSubjID(obj)
            obj.subjID = input('SubjectID = ', 's');
        end 
    end

%% get Function   
    methods 
        function value = get.dataFilename(obj)
            if isempty(obj.dataFilename)
                obj.dataFilename = sprintf('s%s', obj.subjID);
            end
            value = obj.dataFilename;            
        end
        
        function value = get.dataFilename_temp(obj)
            value = sprintf('%s_temp', name);         
        end              
    end
    
    %% output function
    methods (Static = true)
        ExpDataAppend(filename, data)
        Struct2File(file_name,input_struct,delimiter,precision)
    end
end