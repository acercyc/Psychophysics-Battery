classdef dataObj < handle
%======================================================================%
% 1.0 - Acer 2013/03/04 23:16
%======================================================================%

    properties
        para
        taskAbbv
        
        
        txtFilename
        txtFilename_t
        binFilename
        binFilename_t
    end
    
    
    
    
    
    
    
    methods
        
        

        
        
        function obj = dataObj(para, taskAbbv)
            obj.para = para;
            obj.taskAbbv = taskAbbv;    
            
       
            obj.txtFilename = sprintf('data_%s_%s.txt',...
                                      taskAbbv, obj.para.subjInfo.ID);
            obj.txtFilename_t = sprintf('data_%s_%s_temp.txt',...
                                      taskAbbv, obj.para.subjInfo.ID);
            obj.binFilename = sprintf('data_%s_%s.mat',...
                                      taskAbbv, obj.para.subjInfo.ID);
            obj.binFilename_t = sprintf('data_%s_%s_temp.mat',...
                                      taskAbbv, obj.para.subjInfo.ID);
        end
        
        
        
        
        
        
        function saveToTempFile(obj, data)
            save(obj.binFilename_t, 'data');
            ExpDataAppend(obj.txtFilename_t, data);            
        end
        
        
        
        
        
        function saveToFile(obj, data)
            save(obj.binFilename, 'data');
            ExpDataAppend(obj.txtFilename, data);              
        end
        
        
        
        
        
    end
    
    
    
    
    
end