%-----Create by: Marwan Yasser------G:CS1----------------%
%parameter: -original image -mark image
%the original image must be bigger than the mark image or has the same size
function result=waterMark(in1,in2)

[r1,c1,ch1]=size(in1);
[r2,c2,ch2]=size(in2);

out=zeros(r1,c1,ch1);

if(ch1 == 1)%for Gray-scale images
    for i=1:r1
      for j=1:c1
          if(i < r2 && j < c2)
          im1= bitand(in1(i,j,1),240);
          im2= bitand(in2(i,j,1),15);
          out(i,j,1) = im1+im2;
          else
          out(i,j,1) = in1(i,j,1);    
          end
      end
    end
    
else%for RGB images
    for i=1:r1
      for j=1:c1
          if(i < r2 && j < c2)
              im1= bitand(in1(i,j,1),240);
              im2= bitand(in2(i,j,1),15);
              out(i,j,1) = im1+im2;

              im1= bitand(in1(i,j,2),240);
              im2= bitand(in2(i,j,2),15);
              out(i,j,2) = im1+im2;

              im1= bitand(in1(i,j,3),240);
              im2= bitand(in2(i,j,3),15);
              out(i,j,3) = im1+im2;
          else
              out(i,j,1) = in1(i,j,1);
              out(i,j,2) = in1(i,j,2);
              out(i,j,3) = in1(i,j,3);
          end
      end
    end
end

result = uint8(out);

end