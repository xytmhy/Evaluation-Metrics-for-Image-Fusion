function [ Qmi ] = QualityMetrics( A,B,F )

Ha=ent(A);
Hb=ent(B);
Hf=ent(F);

MIaf=Ha+Hf-entjoint(A,F);
MIbf=Hb+Hf-entjoint(B,F);
Qmi=2*(MIaf/(Ha+Hf)+MIbf/(Hb+Hf));

end

function shang = ent(X)  
[m,n,~]=size(X);     I3 = double(X)+1;  
s(256) = 0;  
for i = 1:m  
    for j = 1:n  
        va = I3(i,j);  
        s(va) = s(va)+1;  
    end  
end  
p = s./(m*n);  
en = 0.;  
for i = 1:256  
    if p(i)~=0  
       en = en+p(i)*log2(p(i));  
    end  
end  
shang = -en;  
end

function abshang = entjoint(X,Y)  
[m,n,t]=size(X);     a = double(X)+1;  
b = double(Y)+1;  
hab=zeros(256,256);  
for i = 1:m  
    for j = 1:n  
        index_x=a(i,j);  
        index_y=b(i,j);  
        hab(index_x,index_y)=hab(index_x,index_y)+1;  
    end  
end  
p = hab./(m*n);  
en = 0.;  
for i = 1:256  
    for j = 1:256  
        if p(i,j)~=0  
           en = en+p(i,j)*log2(p(i,j));
        end  
    end  
end  
abshang = -en;  
end