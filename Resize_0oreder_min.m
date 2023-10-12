%-----Create by: Marwan Yasser------G:CS1----------------%
function New_im = Resize_0oreder_min(im,fact)
y=1;
x=1;
[r, c, ch]=size(im);

New_im = [];

for k=1:ch
    for i=1:fact:r
        for j=1:fact:c
            New_im(x,y,k)= im(i,j,k);
            y = y+1;
        end
        x = x+1;
        y=1;
    end
    x=1;
end

New_im = uint8(New_im);
end