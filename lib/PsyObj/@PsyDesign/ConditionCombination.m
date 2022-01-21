function [output_data condi_num] = ConditionCombination(varargin)
% <�N��i�Ӫ��U��variable��level ��X�Ҧ����i�઺�զX>
%  ��بϥΤ覡�G
%     1.
%         [output_data condi_num] = ConditionCombination(var1,var2,...)
%         �N�n���զX���@�Ӥ@�ӦC�X�ӡG���ެO array �άO cell ���i�H�C�u�n�O�@���N��        
%     2.
%         [output_data condi_num] = ConditionCombination(input_cell,'package')
%     >input_cell : �C��cell��ۨC��condition��level
%         �p input_cell{1} = [1 2 3 4]
%            input_cell{2} = [0.1 0.2 0.3 0.4]
%     >output_data : �^�Ǫ��զX�����ƦC
%     >condi_num : �`�@���X�زզX


if strcmp(varargin{2},'package') %�p�G�O�ϥ�package����...
    input_cell = varargin{1};
    
    if isnumeric(input_cell{1})
    %%  < �p�Ginput��cell�̭��˪��Oarray����
    output_data = input_cell{1};
    group_num = length(input_cell);
    for loop_index = 2:group_num
        output_data = repmat(output_data,1,length(input_cell{loop_index}));
        output_data = [output_data;sort(repmat(input_cell{loop_index},1,length(output_data)/length(input_cell{loop_index})))];
    end
    output_data = output_data';
    condi_num = size(output_data,1);
    %%  �p�Ginput��cell�̭��˪��Oarray����>

    elseif iscell(varargin)
    %%  <�p�Ginput��cell�̭��˪��Ocell����
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
    %% �p�Ginput��cell�̭��˪��Ocell���� >
    end

else %�p�G���O�ϥα��C������..
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



