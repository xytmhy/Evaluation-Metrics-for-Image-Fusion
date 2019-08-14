function [mssim, ssim_map,sigma1_sq, sigma2_sq] = Qssim(img1, img2, window)
% input window is a matrix
% output
%ssim_map  every window is a element in the matrix ssim_map
%mssim the average of all elements in the matrix ssim_map
%sigma1_sq is consist of  every window 's variance in img1
%sigma2_sq is consist of  every window 's variance in img2
if (nargin < 2 | nargin > 4)
   ssim_index = -Inf;
   ssim_map = -Inf;
   return;
end

if (size(img1) ~= size(img2))
   ssim_index = -Inf;
   ssim_map = -Inf;
   return;
end

[M N C] = size(img1);

if (nargin == 2)
   if ((M < 11) | (N < 11))
	   ssim_index = -Inf;
	   ssim_map = -Inf;
      return;
   end
   window = ones(7,7);	
 C1=2*10^(-6);
 C2=2*10^(-6);
end

if (nargin == 3)
   if ((M < 11) | (N < 11))
	   ssim_index = -Inf;
	   ssim_map = -Inf;
      return;
   end
   [H W] = size(window);
   if ((H*W) < 4 | (H > M) | (W > N))
	   ssim_index = -Inf;
	   ssim_map = -Inf;
      return;
   end
   C1=2*10^(-6);
 C2=2*10^(-6);
end
window = window/sum(sum(window));

ssim_map=zeros(M,N);

for i=1:C
temp_img1=img1(:,:,i);
temp_img2=img2(:,:,i);
ave1=filter2(window,temp_img1,'same');
ave2=filter2(window,temp_img2,'same');
ave_squ1=ave1.*ave1;
ave_squ2=ave2.*ave2;

sigma1_sq=abs(filter2(window,temp_img1.*temp_img1,'same')-ave_squ1);
sigma2_sq=abs(filter2(window,temp_img2.*temp_img2,'same')-ave_squ2);
sigma12=filter2(window,temp_img1.*temp_img2,'same')-ave1.*ave2;

if (C1 > 0 & C2 > 0)
   temp= ((2*ave1.*ave2 + C1).*(2*sigma12 + C2))./((ave_squ1 + ave_squ2+ C1).*(sigma1_sq + sigma2_sq + C2));
end
ssim_map=ssim_map+temp;
end
ssim_map=ssim_map/C;
mssim = mean2(ssim_map);

end