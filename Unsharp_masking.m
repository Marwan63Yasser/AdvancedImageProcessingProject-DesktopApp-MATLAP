%-----Create by: Marwan Yasser------G:CS1----------------%
%Smoothing Filter: Weighted (Guassian) filter
%Parameters: -Original image  -Sigma (optional - default:1)

function result=Unsharp_masking(in)
in = double(in);
[r,c,ch]=size(in);
res=ones(r,c,ch);
edge=ones(r,c);
final=ones(r,c,ch);

resG=ones(r,c);
inG=ones(r,c);

sigma = 2;

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
 
    for i=1:r
      for j=1:c
          edge(i,j) = res(i,j) - in(i,j);

          final(i,j) = in(i,j) - edge(i,j);
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

    for i=1:r
      for j=1:c
          inG(i,j,1) = (0.3*in(i,j,1)) + (0.59*in(i,j,2)) + (0.11*in(i,j,3));
          resG(i,j,1) = (0.3*res(i,j,1)) + (0.59*res(i,j,2)) + (0.11*res(i,j,3));
          edge(i,j) = resG(i,j) - inG(i,j);

          final(i,j,1) = in(i,j,1) - edge(i,j);
          final(i,j,2) = in(i,j,2) - edge(i,j);
          final(i,j,3) = in(i,j,3) - edge(i,j);
      end
    end 

end



%show the result
result = uint8(final);

end