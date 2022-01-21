classdef PsySound < handle
% 1.0 - Acer 2012/10/31 10:47

    properties
        soundArray
        freq = 44100
        nrchannels
        pahandle
        startTime
        endTime
    end
    
    methods
        function obj = PsySound(freq)
            InitializePsychSound;
            if exist('freq', 'var')
                obj.freq = freq;
            end            
        end
        
        function set.soundArray(obj, soundArray)
            obj.soundArray = soundArray;
            obj.open();
            obj.bufferLoading();
            
        end
                
        function open(obj)
             obj.pahandle = PsychPortAudio('Open', [], [], 0, obj.freq, min(size(obj.soundArray)));
        end
        
        function close(obj)
            PsychPortAudio('Close', obj.pahandle);
        end
        
        function play(obj)
            obj.startTime  = PsychPortAudio('Start', obj.pahandle);
        end
        
        function stop(obj)
            obj.endTime = PsychPortAudio('Stop', obj.pahandle);
        end

        function bufferLoading(obj)
            PsychPortAudio('FillBuffer', obj.pahandle, obj.soundArray);    
        end
        
        function delete(obj)
            obj.close();
        end        
    end
    
end