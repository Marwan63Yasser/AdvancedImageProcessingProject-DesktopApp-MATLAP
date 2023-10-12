%-----Create by: Marwan Yasser------G:CS1----------------%
%parameter: -original image -New Max(optional: defalut=200) -New Min(optional: defalut=50)

function result=contrast(in,maxN,minN)
[r,c,ch]=size(in);
out=ones(r,c,ch);

if ~exist('maxN','var')
      maxN = 200;
end

if ~exist('minN','var')
      minN = 50;
end

if (ch == 1)
    maxG = max(max(in(:,:,1)));
    minG = min(min(in(:,:,1)));
    for i=1:r
        for j=1:c
            out(i,j,1) = ( ( in(i,j,1)-minG ) / (maxG-minG) ) * (maxN-minN) + minN;
            
            if(out(i,j,1) > 255)
                out(i,j,1) = 255;
            elseif(out(i,j,1) < 0)
                out(i,j,1) = 0;
            end
            
        end
    end
 
else    
    max_red = max(max(in(:,:,1)));
    max_green = max(max(in(:,:,2)));
    max_blue = max(max(in(:,:,3)));

    min_red = min(min(in(:,:,1)));
    min_green = min(min(in(:,:,2)));
    min_blue = min(min(in(:,:,3)));

    for i=1:r
      for j=1:c

          out(i,j,1) = ( ( in(i,j,1)-min_red ) / (max_red-min_red) ) * (maxN-minN) + minN; 
          out(i,j,2) = ( ( in(i,j,2)-min_green ) / (max_green-min_green) ) * (maxN-minN) + minN;
          out(i,j,3) = ( ( in(i,j,3)-min_blue ) / (max_blue-min_blue) ) * (maxN-minN) + minN;

            if(out(i,j,1) > 255)
                out(i,j,1) = 255;
            elseif(out(i,j,1) < 0)
                out(i,j,1) = 0;
            end
            
            if(out(i,j,2) > 255)
                out(i,j,2) = 255;
            elseif(out(i,j,2) < 0)
                out(i,j,2) = 0;
            end
            
            if(out(i,j,3) > 255)
                out(i,j,3) = 255;
            elseif(out(i,j,3) < 0)
                out(i,j,3) = 0;
            end
          
      end
    end

end

result = uint8(out);

end