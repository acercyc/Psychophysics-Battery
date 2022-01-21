function acc = resp2accQCSF(respOrder, choice, resp, answer)
%======================================================================%
% 1.0 - Acer 2013/03/05 00:38
%======================================================================%

    % Change response by  order
    %----------------------------------------------------------------------
    %s
    if ~respOrder
        choice = fliplr(choice);
    end
    
    
    
    % Check answer data type
    %----------------------------------------------------------------------
    if ~answer
        answer = 2;
    end
    
    
    
    % Key to index of choice
    %----------------------------------------------------------------------
    if ischar(resp)
        iResp = find(strcmp(resp, choice));
        
    elseif iscell(resp)
        for ii = 1:length(choice)
            isResp(ii) = isequal(choice{ii}, resp);
        end
        iResp = find(isResp);
        
    end

    
    % Compare response to answer
    %----------------------------------------------------------------------
    acc = iResp == answer;

end