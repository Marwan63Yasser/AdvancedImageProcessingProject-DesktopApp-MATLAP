%-----Create by: Marwan Yasser------G:CS1----------------%
%Smoothing Filter: Average (mean) filter
%Parameters:-Original image  -Mask side size like 3 for 3*3 mask,
%                             5 for 5*5 mask and so on, (optional - default:3)

function result=smooth_avg(in,mask)

in = double(in);

%var fo check validation for mask size
ex = 0;
%set default mask side size , if its parameter is empty
if ~exist('mask','var')
      mask = 3;
end

%check validation for mask size
if ( mod(mask,2) == 0 || mask < 3)
    disp("Error!!! -- Mask side size must be odd and larger than 1");
    ex = 1;
end

%if ex = 1 the program will be trminate
if(ex == 0)
    
ext = mask - round(mask/2);
inv_ext = -1*ext;
sum=0;
mask_size = mask*mask;


[r,c,ch]=size(in);
%set padding in the image
out=padarray(in,[ext ext],'replicate','both');
res=ones(r,c,ch);

%the process for gray-scale images
if (ch == 1)
    for i=1+ext:r+ext
        for j=1+ext:c+ext
            %apply the mask to the pixel
            for x = inv_ext:ext
                for y = inv_ext:ext
                    sum = sum + out(i+x,j+y);
                end
            end
            
            res(i-ext,j-ext) = sum / mask_size;
            sum = 0;
        end
    end
 
else %the process for RGB images   
    
    for i=1+ext:r+ext
      for j=1+ext:c+ext
          
           %apply the mask to the pixel - (RED Component)
           for x = inv_ext:ext
                for y = inv_ext:ext
                    sum = sum + out(i+x,j+y,1);
                end
            end
            res(i-ext,j-ext,1) = sum / mask_size;
            sum = 0;
            
           %apply the mask to the pixel - (GREEN Component) 
           for x = inv_ext:ext
                for y = inv_ext:ext
                    sum = sum + out(i+x,j+y,2);
                end
            end
            res(i-ext,j-ext,2) = sum / mask_size;
            sum = 0;
        
           %apply the mask to the pixel - (BLUE Component)
           for x = inv_ext:ext
                for y = inv_ext:ext
                    sum = sum + out(i+x,j+y,3);
                end
            end
            res(i-ext,j-ext,3) = sum / mask_size;
            sum = 0;
          
      end
    end

end

%show the result
result = uint8(res);

end

end