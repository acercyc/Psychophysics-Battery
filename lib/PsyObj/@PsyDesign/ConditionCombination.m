function [output_data condi_num] = ConditionCombination(varargin)
% <將放進來的各個variable的level 輸出所有有可能的組合>
%  兩種使用方式：
%     1.
%         [output_data condi_num] = ConditionCombination(var1,var2,...)
%         將要做組合的一個一個列出來：不管是 array 或是 cell 都可以。只要是一維就行        
%     2.
%         [output_data condi_num] = ConditionCombination(input_cell,'package')
%     >input_cell : 每個cell放著每個condition的level
%         如 input_cell{1} = [1 2 3 4]
%            input_cell{2} = [0.1 0.2 0.3 0.4]
%     >output_data : 回傳的組合直的排列
%     >condi_num : 總共有幾種組合


if strcmp(varargin{2},'package') %如果是使用package的話...
    input_cell = varargin{1};
    
    if isnumeric(input_cell{1})
    %%  < 如果input的cell裡面裝的是array的話
    output_data = input_cell{1};
    group_num = length(input_cell);
    for loop_index = 2:group_num
        output_data = repmat(output_data,1,length(input_cell{loop_index}));
        output_data = [output_data;sort(repmat(input_cell{loop_index},1,length(output_data)/length(input_cell{loop_index})))];
    end
    output_data = output_data';
    condi_num = size(output_data,1);
    %%  如果input的cell裡面裝的是array的話>

    elseif iscell(varargin)
    %%  <如果input的cell裡面裝的是cell的話
    output_data = input_cell{1};
    group_num = length(input_cell);

    for loop_index = 2:group_num
        temp_out1 = {};
        output_data = repmat(output_data,1,length(input_cell{loop_index}));
        for i = 1:length(input_cell{loop_index})
            temp_out1 = [temp_out1 repmat(input_cell{loop_index}(i),1,length(output_data)/length(input_cell{loop_index}))];
        end
        output_data = [output_data;temp_out1];
    end
    output_data = output_data';
    condi_num = size(output_data,1);
    %% 如果input的cell裡面裝的是cell的話 >
    end

else %如果式是使用條列式的話..
    iscell_index = [];
    for i = 1:length(varargin)
        if isnumeric(varargin{i})
            varargin{i} = num2cell(varargin{i});            
            iscell_index(i) = 1;
        else
            iscell_index(i) = 0;
        end
    end 
    [output_data condi_num] = PsyDesign.ConditionCombination(varargin,'package');
    if all(iscell_index);output_data = cell2mat(output_data);end
end



