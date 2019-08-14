

clear;
close all;
clc;

number=20;
FusionScore=zeros(number,4);

for count=1:number
    imagepath1=sprintf('LytroDataset/lytro-%02d-A.jpg',count);
    imagepath2=sprintf('LytroDataset/lytro-%02d-B.jpg',count);
    imagepathF=sprintf('resultsDSIFTm/lytro-%02d-FD.png',count);
%     imagepathF=sprintf('Result0814/lytro-%02d-Fusion.png',count);
    A=imread(imagepath1);
    B=imread(imagepath2);
    F=imread(imagepathF);
    
%     A=rgb2gray(A);
%     B=rgb2gray(B);
%     F=rgb2gray(F);
        
    Qmi1=QualityMetrics(A,B,F);
    Qg1=metricXydeas(A,B,F);
    Qy1=QY(A,B,F);
    Qcb1=metricChenBlum(A,B,F);
    
    FusionScore(count,1)=Qmi1;
    FusionScore(count,2)=Qg1;
    FusionScore(count,3)=Qy1;
    FusionScore(count,4)=Qcb1;
    
end

FF=sum(FusionScore)/20