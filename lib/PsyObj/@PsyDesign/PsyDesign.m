classdef PsyDesign < handle
% 1.0 - Acer 2011/06/15_00:35
    properties
        
        stimuli = {1:5, 6:10};
        blockRepeatTime = 2;
        blockNum = 10;
    end
    
    properties %(Dependent)
        allCombination;
        allCombinationNum;
        
        blockStimuli;
        blockStimuliNum
        
        allExpStimuli;
        allExpStimuliNum;
    end
    
    methods 
        function makeBlock(obj)
            [obj.allCombination obj.allCombinationNum]= obj.ConditionCombination(obj.stimuli{:});
            blockStimuli_t = repmat(obj.allCombination, obj.blockRepeatTime ,1);
            obj.blockStimuli = obj.randList(blockStimuli_t);
            obj.blockStimuliNum = size(obj.blockStimuli, 1);
        end
        
        function makeAllExp(obj)
            allExpStimuli_t = [];
            for ii = 1:obj.blockNum
                allExpStimuli_t = [allExpStimuli_t; obj.randList(obj.blockStimuli)]; %#ok<*AGROW>
            end
            obj.allExpStimuli = allExpStimuli_t;
            obj.allExpStimuliNum = size(obj.allExpStimuli, 1);
        end
        
    end
    
    methods (Static)
        [output_data condi_num] = ConditionCombination(varargin)
        
        function rList = randList(list)
            rList = list(randperm(size(list, 1)), :);
        end
    end
    
    methods
        function set.stimuli(obj, value)
            obj.stimuli = value;
            obj.makeBlock; 
        end
        
        function set.blockRepeatTime(obj, value)
            obj.blockRepeatTime = value;
            obj.makeBlock; %#ok<*MCSUP>
        end        
        
        function set.blockStimuli(obj, value)
            obj.blockStimuli = value; %#ok<*MCSUP>
            obj.makeAllExp;
        end               
        
        function set.blockNum(obj, value)
            obj.blockNum = value; %#ok<*MCSUP>
            obj.makeAllExp;
        end
    end
end