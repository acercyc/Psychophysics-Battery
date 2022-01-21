clc;
clear all;
clear classes;
para = paraObj;

r = rfObj;
r.setPara(para.shape);

%%
r.createStandPic();
r.createTestPic(0.03);
imshow(r.picArray{2})