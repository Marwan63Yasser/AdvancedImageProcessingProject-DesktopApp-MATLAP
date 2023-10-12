%-----Create by: Marwan Yasser------G:CS1----------------%
%parameter: -original image

function out=histogram(in)
[r,c,ch]=size(in);
out=zeros(1,256);

if(ch == 1)
    for i=1:r
      for j=1:c

          for k = 0:255
             if(in(i,j,1) == k)
                 out(k+1) = out(k+1)+1;
             end
          end    

      end
    end
    
else
    
    for i=1:r
      for j=1:c

          for k = 0:255
             if(in(i,j,1) == k)
                 out(k+1) = out(k+1)+1;
             end

             if(in(i,j,2) == k)
                 out(k+1) = out(k+1)+1;
             end

             if(in(i,j,3) == k)
                 out(k+1) = out(k+1)+1;
             end

          end    

      end
    end

end

end