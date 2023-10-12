%-----Create by: Marwan Yasser------G:CS1----------------%
%parameter: -original image -K value in range(1 --> 8) (optional - default:6)

function result=quantization(in,k)

[r,c,ch]=size(in);
out=ones(r,c,ch);

%var fo check validation for (k) value
ex = 0;
%set default (k) value , if its parameter is empty
if ~exist('k','var')
      k = 6;
end

%check validation for (k) value
k = round(k);
if ( k < 1 || k > 8)
    disp("Error!!! -- (k) value must be from 1 to 8 only");
    ex = 1;
end

if(ex == 0)

gray_level = power(2,k);
gap = 256/gray_level;
colors = gap:gap:256;

if(ch == 1)

for i=1:r
  for j=1:c
      temp = in(i,j)/gap;
      index = floor(temp);
      if(index == 0)
        index = 1;
      end
      out(i,j) = colors(index);
  end
end

else

    for i=1:r
      for j=1:c
      temp = in(i,j,1)/gap;
      index = floor(temp);
      if(index == 0)
        index = 1;
      end
      out(i,j,1) = colors(index);

      temp = in(i,j,2)/gap;
      index = floor(temp);
      if(index == 0)
        index = 1;
      end
      out(i,j,2) = colors(index);

      temp = in(i,j,3)/gap;
      index = floor(temp);
      if(index == 0)
        index = 1;
      end
      out(i,j,3) = colors(index);
      end
    end

end

end


%show the result
result = uint8(out);

end