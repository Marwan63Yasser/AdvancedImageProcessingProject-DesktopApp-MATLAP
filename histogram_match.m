%-----Create by: Marwan Yasser------G:CS1----------------%
%parameter: -bad image -good image

function result=histogram_match(in1,in2)
[r1,c1,ch]=size(in1);
[r2,c2,ch]=size(in2);

out1=zeros(1,256);
res1=zeros(1,256);

out2=zeros(1,256);
res2=zeros(1,256);

ime=zeros(r1,c1,ch);

if(ch == 1)
    for i=1:r1
      for j=1:c1
          for k = 0:255
             if(in1(i,j,1) == k)
                 out1(k+1) = out1(k+1)+1;
             end
          end    
      end
    end
    %----------------------------
      for i=1:r2
        for j=1:c2

          for k = 0:255
             if(in2(i,j,1) == k)
                 out2(k+1) = out2(k+1)+1;
             end
          end    

      end
    end
    %--------------------------------------
else
    
    for i=1:r1
      for j=1:c1
          for k = 0:255
             if(in1(i,j,1) == k)
                 out1(k+1) = out1(k+1)+1;
             end

             if(in1(i,j,2) == k)
                 out1(k+1) = out1(k+1)+1;
             end

             if(in1(i,j,3) == k)
                 out1(k+1) = out1(k+1)+1;
             end
          end    
      end
    end
    
    %-----------------------------------------------
    
    for i=1:r2
      for j=1:c2
          for k = 0:255
             if(in2(i,j,1) == k)
                 out2(k+1) = out2(k+1)+1;
             end

             if(in2(i,j,2) == k)
                 out2(k+1) = out2(k+1)+1;
             end

             if(in2(i,j,3) == k)
                 out2(k+1) = out2(k+1)+1;
             end
          end    
      end
    end

end

out1(1) = res1(1);
for p=1:255
    res1(p+1) = out1(p+1)+res1(p);
end    

res1 = res1/max(res1);
res1 = res1*255;
res1 = round(res1);

%---------------------------------

out2(1) = res2(1);
for p=1:255
    res2(p+1) = out2(p+1)+res2(p);
end    

res2 = res2/max(res2);
res2 = res2*255;
res2 = round(res2);


if(ch == 1)
    for i=1:r1
      for j=1:c1

          for k = 0:255
             if(in1(i,j,1) == k)
                 ime(i,j,1) = res1(k+1);
             end
          end    

      end
    end
    
else
    
    for i=1:r1
      for j=1:c1

          for k = 0:255
             if(in1(i,j,1) == k)
                 ime(i,j,1) = res1(k+1);
             end

             if(in1(i,j,2) == k)
                 ime(i,j,2) = res1(k+1);
             end

             if(in1(i,j,3) == k)
                 ime(i,j,3) = res1(k+1);
             end

          end    

      end
    end

end

result = uint8(ime);

end