%-----Create by: Marwan Yasser------G:CS1----------------%
%parameter: -original image

function result=negative(in)
[r,c,ch]=size(in);
out=ones(r,c,ch);

if(ch == 1)
    for i=1:r
        for j=1:c
            out(i,j,1) = 255-in(i,j,1); 
        end
    end
    
else
    for i=1:r
        for j=1:c
            out(i,j,1) = 255-in(i,j,1);
            out(i,j,2) = 255-in(i,j,2);
            out(i,j,3) = 255-in(i,j,3);
            
        end
    end
end

result = uint8(out);

end