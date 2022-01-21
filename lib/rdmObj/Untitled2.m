clc;
clear all;
clear classes;

rdmObj.demo()
% n = 30;
% 
% p = rand(n, 2);
% dirt = rand(n, 1)*2*pi;
% dist = 0.01%rand(n, 1)/30;
% b = [-1 -1 1 1];
% 
% % r = rdmObj;
% 
% %%
% for ii = 1:100
% 
%     p = rdmObj.nextFrame(p, dirt, dist);
%     p = rdmObj.returnToBoundary(p, b);
% 
% %     if sum( p(:, 1) > b(3) )
% %         a = 1
% %     end
% %     p(:, 1) = p(:, 1) + ( double(p(:, 1) < b(1) - p(:, 1) > b(3) ) * ( b(3) - b(1) );
% %     p(:, 2) = p(:, 2) + ( p(:, 2) < b(2) - p(:, 2) > b(4) ) * ( b(4) - b(2) );
%     
%     
%     plot(p(:,1), p(:,2), '.');
%     set(gca, 'xLim', [-1 1]);
%     set(gca, 'yLim', [-1 1]);
%     ii
%     
%     pause(0.1)
% end
