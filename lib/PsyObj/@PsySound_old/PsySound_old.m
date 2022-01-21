classdef PsySound < PsyPresent
% 1.0 - Acer 2011/06/13_15:04    
    properties
        signal
        rate
        
        prueToneFreq = 1000;
        soundFade = 1;
        soundFadeDuration = 0.015;
        
        waitSound = 1;
    end
    
    methods
        function obj = PsySound
            Snd('Open');
            obj.rate = Snd('DefaultRate');
            obj.makePureTone(obj.prueToneFreq, obj.duration);
        end

%% control sound        
        function play(obj)
            obj.timerObj_G.wait;
            Snd('Play', obj.signal,obj.rate);
            if obj.waitSound
                Snd('Wait');
            end
        end
        
        function playPureTone(obj, varargin)
            makePureTone(obj, varargin{:});
            obj.play;
        end
        
        function stop(obj) %#ok<MANU>
            Snd('Quiet'); 
        end
        
        function delete(obj) %#ok<MANU>
            Snd('Close');
        end
%% make sound        
        function signal = makePureTone(obj, freq, dura)
        % signal = makePureTone(obj, freq, dura)
        % dura is in second
            if nargin >= 2
                if ~isempty(freq)
                    obj.prueToneFreq = freq;
                end
            end
            
            if nargin >= 3
                if ~isempty(dura)
                    obj.duration = dura;
                end                
            end
            
            obj.signal =  MakeBeep(obj.prueToneFreq, obj.duration, obj.rate);
            if obj.soundFade
                obj.signal = obj.SoundFade(obj.signal, obj.rate, obj.soundFadeDuration);
            end
            signal = obj.signal;
        end
    end

%% tool    
    methods (Static = true)
        output = SoundFade(sData, SF, secs, ydb)
    end
end