classdef rdmObj < handle
%======================================================================%
% 1.0 - Acer 2013/02/15 15:13
%======================================================================%

   properties
   end
   
   
   
   
   
   
   
   
   methods       
       
       
       function obj = rdmObj
       end
       
       
   end
   
   
   
   
   
   
   methods(Static) 
       
       
       
       
       
        function [p, dirt] = generateDot(n, coh, b)
        %-------------------------------------------------------------------
        % n : number of dots
        % coh : coherence,  = 0 ~ 1
        % b : boundary
        % 1.0 - Acer 2013/02/15 17:06
        %-------------------------------------------------------------------
            if coh > 1 || coh < 0
                error('coherence value must be withing 0~1');
            end
            
            p = rand(n, 2);
            p(:, 1) = p(:, 1) * ( b(3) - b(1) ) + b(1);
            p(:, 2) = p(:, 2) * ( b(4) - b(2) ) + b(2);
            
            dirt = rand(n, 1)*2*pi;
            dirt( 1 : round(n*coh) ) = dirt(1);
            
        end
       
       
       
        
        
        function np = nextFrame(p, dirt, dist)
        % ------------------------------------------------------------------
        % dist : could be a column vector or a scalar
        % 1.0 - Acer 2013/02/15 15:21       
        % ------------------------------------------------------------------

           np = p + bsxfun(@times, [cos(dirt) sin(dirt)], dist);    

        end
       
       
       
       
       
        function np = returnToBoundary(p, b)
        % ------------------------------------------------------------------
        % b = [x1, y1, x2, y2]
        %
        % 1.0 - Acer 2013/02/15 16:22
        % ------------------------------------------------------------------       

            np(:, 1) = p(:, 1) + ( double(p(:, 1) < b(1)) - double(p(:, 1) > b(3)) ) *...
                ( b(3) - b(1) );
            np(:, 2) = p(:, 2) + ( double(p(:, 2) < b(2)) - double(p(:, 2) > b(4)) ) *...
                ( b(4) - b(2) );

        end
        
        
        
        
        
        function demo()            
        % 1.0 - Acer 2013/02/15 17:35
        
            % parameters
            % ---------------------------------------%
            n = 90;
            coh = 0.4;
            dist = 5;
            b = [400 400 700 700];
            
            
            % Run RDM matlab demo
            % ---------------------------------------%
            [p, dirt] = rdmObj.generateDot(n, coh, b);
            
            for ii = 1:100
                
                p = rdmObj.nextFrame(p, dirt, dist);
                p = rdmObj.returnToBoundary(p, b);
                plot(p(:,1), p(:,2), '.');
                set(gca, 'xLim', [b(1) b(3)]);
                set(gca, 'yLim', [b(2) b(4)]);
                fprintf('...%d%%\n', ii);
                pause(0.1);
           
            end                            
            
        end     % end of Demo
       


        
                
   end      % end of Static function
    
    
    
    
   
   
   
end