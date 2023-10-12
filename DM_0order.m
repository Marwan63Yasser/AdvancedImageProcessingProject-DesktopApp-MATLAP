function result=DM_0order(in,fact)
[r,c,ch]=size(in);
new_r=r*fact;
new_c=c*fact;
out=ones(new_r,new_c,ch);
for k=1:ch
    x=fact;
    a=1;
    for i=1:r
        y=fact;
        b=1;
        for j=1:c
            out(a:x,b:y,k)=in(i,j,k);
            b=b+fact;
            y=y+fact;
        end
        x=x+fact;
        a=a+fact;
    end   
end

result = uint8(out);

end