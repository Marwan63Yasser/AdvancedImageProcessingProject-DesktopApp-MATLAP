%-----Create by: Marwan Yasser------G:CS1----------------%
%parameter: -original image

function result=convert_to_gray(in)
[r,c,ch]=size(in);
out=ones(r,c,1);

for i=1:r
  for j=1:c
      %converting ways to gray scale-----------------
      %out(i,j,1) = ( in(i,j,1)+in(i,j,2)+in(i,j,3) )/3;
      out(i,j,1) = (0.3*in(i,j,1)) + (0.59*in(i,j,2)) + (0.11*in(i,j,3));%Best Way
      %out(i,j,1) = in(i,j,1);
      %out(i,j,1) = in(i,j,2);
      %out(i,j,1) = in(i,j,3);
      %arr = [in(i,j,1) in(i,j,2) in(i,j,3)];
      %out(i,j,1) = max(arr);
      %out(i,j,1) = min(arr);
      %out(i,j,1) = (max(arr) + min(arr))/2;
  end
end

result = uint8(out);

end