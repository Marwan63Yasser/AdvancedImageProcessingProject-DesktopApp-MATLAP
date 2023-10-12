%-----Create by: Marwan Yasser------G:CS1----------------%
%Edge Detection Filter: line edge detect (Diagonal \) filter
%parameter: -original image

function result=EdgeDetect_lineDiagonalL(in)
in = double(in);
[r,c,ch]=size(in);
new=ones(r,c,ch);

%convert image into gray-scale image, if the image is RGB image
if (ch == 3)
    for i=1:r
       for j=1:c
          new(i,j,1) = (0.3*in(i,j,1)) + (0.59*in(i,j,2)) + (0.11*in(i,j,3));
       end
    end
end

%set paddind in the image
out=padarray(new,[1 1],'replicate','both'); 
res=ones(r,c);


for i=2:r+1
        for j=2:c+1
            %apply the mask on each pixel in the image
            res(i-1,j-1)=( (out(i,j+1)) + (2*out(i+1,j+1)) ...
            + (-2*out(i-1,j)) + (out(i+1,j)) ...
            + (-2*out(i-1,j-1)) + (-1*out(i,j-1)) );
        end
end

%show the result
result = uint8(res);

end