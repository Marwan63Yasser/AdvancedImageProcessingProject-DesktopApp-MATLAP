%-----Create by: Marwan Yasser------G:CS1----------------%
%parameter: -image1 -image2

function result=sub(in1,in2)
[r1,c1,ch1]=size(in1);
[r2,c2,ch2]=size(in2);

if(r1 < r2)
    final_r = r1;
else
    final_r = r2;
end

if(c1 < c2)
    final_c = c1;
else
    final_c = c2;
end

ime=zeros(final_r,final_c,ch1);

if(ch1 == 1)
    for i=1:final_r
      for j=1:final_c
          ime(i,j,1) = in1(i,j,1)- in2(i,j,1);
      end
    end
    
else
    for i=1:final_r
      for j=1:final_c
          ime(i,j,1) = in1(i,j,1)- in2(i,j,1);
          ime(i,j,2) = in1(i,j,2)- in2(i,j,2);
          ime(i,j,3) = in1(i,j,3)- in2(i,j,3);
      end
    end
end


ime = contrast(ime,255,0);

result = uint8(ime);

end