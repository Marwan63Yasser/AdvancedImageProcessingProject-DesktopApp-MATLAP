%-----Create by: Marwan Yasser------G:CS1----------------%
%Sharpening Filter: Line Sharpening filter (Diagonal \)
%parameter: -original image

function result=Sharp_lineDiagonalL(in)
in = double(in);
[r,c,ch]=size(in);
res=ones(r,c,ch);

%set paddind in the image
out=padarray(in,[1 1],'replicate','both'); 


if (ch == 1)
    for i=2:r+1
            for j=2:c+1
                %apply the mask on each pixel in the image
                res(i-1,j-1) = (out(i-1,j+1)) + (out(i,j)) + (-1*out(i+1,j-1));
            end
    end

else

    for i=2:r+1
            for j=2:c+1
                %apply the mask on each pixel in the image - (RED Component)
                res(i-1,j-1,1) = (out(i-1,j+1,1)) + (out(i,j,1)) + (-1*out(i+1,j-1,1));

                %apply the mask on each pixel in the image - (GREEN Component)
                res(i-1,j-1,2) = (out(i-1,j+1,2)) + (out(i,j,2)) + (-1*out(i+1,j-1,2));

                %apply the mask on each pixel in the image - (BLUE Component)
                res(i-1,j-1,3) = (out(i-1,j+1,3)) + (out(i,j,3)) + (-1*out(i+1,j-1,3));
            end
    end

end



%show the result
result = uint8(res);

end