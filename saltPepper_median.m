%-----Create by: Marwan Yasser------G:CS1----------------%
%Restoration: Add (Salt&pepper) Noise THEN Remove noise using Median (order filter)
%Parameters:-Original image  -Mask side size like 3 for 3*3 mask,
%                             5 for 5*5 mask and so on, (optional - default:3)

function result=saltPepper_median(in,mask)

%Adding Random noise (Salt&pepper Noise)
noised_in = imnoise(in,'salt & pepper');

noised_in = double(noised_in);

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
mask_size = mask*mask;
arr=ones(1,mask_size);

[r,c,ch]=size(noised_in);
%set padding in the image
out=padarray(noised_in,[ext ext],'replicate','both');
res=ones(r,c,ch);

%the process for gray-scale images
if (ch == 1)
    for i=1+ext:r+ext
        for j=1+ext:c+ext
            %put mask elements to the array
            p = 1;
            for x = inv_ext:ext
                for y = inv_ext:ext
                    arr(p) = out(i+x,j+y);
                    p = p+1;
                end
            end
            %choose the maximum element and put it in the pixel
            res(i-ext,j-ext) = median(arr);
            p = 1;
        end
    end
 
else %the process for RGB images   
    
    for i=1+ext:r+ext
      for j=1+ext:c+ext
          
           %put mask elements to the array - (RED Component)
           p = 1;
           for x = inv_ext:ext
                for y = inv_ext:ext
                    arr(p) = out(i+x,j+y,1);
                    p = p+1;
                end
           end
            %choose the maximum element and put it in the pixel
            res(i-ext,j-ext,1) = median(arr);
            p = 1;
            
           %put mask elements to the array - (GREEN Component) 
           for x = inv_ext:ext
                for y = inv_ext:ext
                    arr(p) = out(i+x,j+y,2);
                    p = p+1;
                end
           end
            %choose the maximum element and put it in the pixel
            res(i-ext,j-ext,2) = median(arr);
            p = 1;
        
           %put mask elements to the array - (BLUE Component)
           for x = inv_ext:ext
                for y = inv_ext:ext
                    arr(p) = out(i+x,j+y,3);
                    p = p+1;
                end
           end
            %choose the maximum element and put it in the pixel
            res(i-ext,j-ext,3) = median(arr);
            p = 1;
          
      end
    end

end

%show the result
result = uint8(res);

end

end