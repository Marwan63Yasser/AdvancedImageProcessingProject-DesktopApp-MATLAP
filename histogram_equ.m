%-----Create by: Marwan Yasser------G:CS1----------------%
%parameter: -original image

function result=histogram_equ(in)
[r,c,ch]=size(in);
out=zeros(1,256);
res=zeros(1,256);

ime=zeros(r,c,ch);

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

out(1) = res(1);
for p=1:255
    res(p+1) = out(p+1)+res(p);
end    

res = res/max(res);
res = res*255;
res = round(res);


if(ch == 1)
    for i=1:r
      for j=1:c

          for k = 0:255
             if(in(i,j,1) == k)
                 ime(i,j,1) = res(k+1);
             end
          end    

      end
    end
    
else
    
    for i=1:r
      for j=1:c

          for k = 0:255
             if(in(i,j,1) == k)
                 ime(i,j,1) = res(k+1);
             end

             if(in(i,j,2) == k)
                 ime(i,j,2) = res(k+1);
             end

             if(in(i,j,3) == k)
                 ime(i,j,3) = res(k+1);
             end

          end    

      end
    end

end

result = uint8(ime);

end