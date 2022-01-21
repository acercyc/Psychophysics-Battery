classdef rfObj < handle 
%======================================================================%
% 1.0 - Acer 2013/03/10 21:52
%======================================================================%

    properties
        para = [];
        picArray = {[],[]};
        PsyPicObj = [];
    end
    
    
    
    
    
    
    
    methods
        
        
        
        
        
        function setPara(obj, para)
            obj.para = para;
        end
        
        
        
        
        
        function setPsyPic(obj, w)
            obj.PsyPicObj = PsyPic(w);
        end
        
        
        
        
        
        function flipTime = flip(obj)
            flipTime = obj.PsyPicObj.flip();
        end
        
        
        
        
        
        function rf = rf_picCreator(obj, A)
            rf = rf_picCreator(obj.para.rf.picResolution,...
                               obj.para.rf.fr,...
                               rand()*pi,...
                               obj.para.rf.C,...
                               obj.para.rf.Lm,...
                               obj.para.rf.Rm,...
                               A,...
                               obj.para.rf.Wp);
        end     %-----------------------------------end of rf_picCreator
        
        
        
        
        
        function createStandPic(obj)
            obj.picArray{1} = obj.rf_picCreator(obj.para.standard);            
        end
        
        
        
        
        
        function createTestPic(obj, A)
            obj.picArray{2} = obj.rf_picCreator(A);
        end
        
        
        
        
        function draw(obj, isStandard)
            if isStandard
                obj.PsyPicObj.imgArray = obj.picArray{1} .* 255;
            else
                obj.PsyPicObj.imgArray = obj.picArray{2} .* 255;
            end
            obj.PsyPicObj.MakeTexture();
            obj.PsyPicObj.draw();
        end
        
        
        
        
        
    end


    
    
    
end