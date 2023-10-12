%-----Create by: Marwan Yasser------G:CS1----------------%
%Smoothing Filter: Weighted (Guassian) filter
%Parameters: -Original image  -Sigma (optional - default:1)

function result=smooth_weighted(in,sigma)
in = double(in);
[r,c,ch]=size(in);
res=ones(r,c,ch);

%var fo check validation for Sigma
ex = 0;
%set default Sigma value , if its parameter is empty
if ~exist('sigma','var')
      sigma = 1;
end

%check validation for Sigma
if (sigma < 0.5)
    disp("Error!!! -- Sigma must equal 0.5 or larger");
    ex = 1;
end

%if ex = 1 the program will be trminate
if(ex == 0)

% the smallest value = 0.5 any value less than 0.5 represent pixel opreation 1x1
%Create mask based on Sigma value
N = floor(3.7*sigma-0.5);
mask_size = 2*N+1;
t = floor(mask_size/2);
x=(-t:t);
mask=zeros(mask_size,mask_size);
coef=(1/(2*pi*(sigma^2)));
for i=1:mask_size
    for j=1:mask_size
        mask(i,j)=coef*exp(-((x(i)^2)+(x(j)^2))/(2*(sigma^2)));
    end
end

ext = mask_size - round(mask_size/2);
inv_ext = -1*ext;
summ = 0;

%set padding in the image
out=padarray(in,[ext ext],'replicate','both');

%the process for gray-scale images
if (ch == 1)
   
    for i=1+ext:r+ext
        for j=1+ext:c+ext
            %apply the mask to the pixel
            ro = mask_size;
            co = 1;
            for x = inv_ext:ext
                for y = inv_ext:ext
                    summ = (out(i+x,j+y)*mask(ro,co)) + summ;
                    ro = ro - 1;
                end
                    co = co + 1;
                    ro = mask_size;
            end
            
            res(i-ext,j-ext) = summ / sum(sum(mask));
            summ = 0;
            ro = mask_size;
            co = 1;

        end
    end
 
else  %the process for RGB images     

    for i=1+ext:r+ext
      for j=1+ext:c+ext
          
            %apply the mask to the pixel - (RED Component)
            ro = mask_size;
            co = 1;
            for x = inv_ext:ext
                for y = inv_ext:ext
                    summ = (out(i+x,j+y,1)*mask(ro,co)) + summ;
                    ro = ro - 1;
                end
                    co = co + 1;
                    ro = mask_size;
            end
            res(i-ext,j-ext,1) = summ / sum(sum(mask));
            
            summ = 0;
            ro = mask_size;
            co = 1;
            %apply the mask to the pixel - (GREEN Component) 
            for x = inv_ext:ext
                for y = inv_ext:ext
                    summ = (out(i+x,j+y,2)*mask(ro,co)) + summ;
                    ro = ro - 1;
                end
                    co = co + 1;
                    ro = mask_size;
            end
            res(i-ext,j-ext,2) = summ / sum(sum(mask));
            
            summ = 0;
            ro = mask_size;
            co = 1;
            %apply the mask to the pixel - (BLUE Component)
            for x = inv_ext:ext
                for y = inv_ext:ext
                    summ = (out(i+x,j+y,3)*mask(ro,co)) + summ;
                    ro = ro - 1;
                end
                    co = co + 1;
                    ro = mask_size;
            end
            res(i-ext,j-ext,3) = summ / sum(sum(mask));
            
            summ = 0;
            ro = mask_size;
            co = 1;
          
      end
    end

end



%show the result
result = uint8(res);

end

end