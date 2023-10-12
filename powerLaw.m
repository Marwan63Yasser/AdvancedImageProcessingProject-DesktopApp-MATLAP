
%-----Create by: Marwan Yasser------G:CS1----------------%
%parameter: -original image -Power(optional: defalut=2)

function result=powerLaw(in,pow)

[r,c,ch]=size(in);
out=ones(r,c,ch);

in = double(in);

if ~exist('pow','var')
      pow = 2;
end

if(ch == 1) 
    
    for i=1:r
        for j=1:c
            out(i,j) = power(in(i,j),pow);
        end
    end
  
else
    
    for i=1:r
        for j=1:c
            out(i,j,1) = power(in(i,j,1),pow);
            out(i,j,2) = power(in(i,j,2),pow);
            out(i,j,3) = power(in(i,j,3),pow);
        end
    end
    
end

out = contrast(out,255,0);
result = uint8(out);

end