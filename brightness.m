%-----Create by: Marwan Yasser------G:CS1----------------%
%parameters: -original image -offest(optional- default=50)
function result=brightness(in,offest)
[r,c,ch]=size(in);
out=ones(r,c,ch);

if ~exist('offest','var')
      offest = 50;
end

if(ch == 1)
    for i=1:r
        for j=1:c
            out(i,j,1) = in(i,j,1)+offest;
            
            if(out(i,j,1) > 255)
                out(i,j,1) = 255;
            elseif(out(i,j,1) < 0)
                out(i,j,1) = 0;
            end
            
        end
    end
    
else
    for i=1:r
        for j=1:c
            out(i,j,1) = in(i,j,1)+offest;
            out(i,j,2) = in(i,j,2)+offest;
            out(i,j,3) = in(i,j,3)+offest;
            
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