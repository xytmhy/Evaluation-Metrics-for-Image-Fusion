function [ Q ] = QY(sourceimg1, sourceimg2,fusionimg)
%Q Summary of this function goes here
%   Detailed explanation goes here
sourceimg1=im2double(sourceimg1);
sourceimg2=im2double(sourceimg2);
fusionimg=im2double(fusionimg);
[mssim1, ssim_map1] = Qssim(sourceimg1, fusionimg);

[mssim2, ssim_map2] = Qssim(sourceimg2, fusionimg);

[mssim12, ssim_map12,variance1,variance2] = Qssim(sourceimg1, sourceimg2);

weight=variance1./(variance1+variance2);
weight(variance1==0)=0; 
[m,n]=size(ssim_map12);
for i=1:m
    for j=1:n
      
        if  ssim_map12(i,j)>=0.75
            Qy_map(i,j)=weight(i,j).*ssim_map1(i,j)+(1-weight(i,j)).*ssim_map2(i,j);
        else
             Qy_map(i,j)=max(ssim_map1(i,j),ssim_map2(i,j));
        end
    end
end
Q=mean2(Qy_map);
end

