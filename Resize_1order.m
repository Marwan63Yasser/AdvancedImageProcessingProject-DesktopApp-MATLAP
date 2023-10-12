%-----Create by: Marwan Yasser------G:CS1----------------%
function result=Resize_1order(in,fact)
[r,c,ch]=size(in);
new_r=r*fact;
new_c=c*fact;
out=ones(new_r,new_c,ch);

%----------------------------------------------------------------------------------------
for k=1:ch
    x=fact;
    a=1;
    for i=1:r
        y=fact;
        b=1;
        for j=1:c
            
            if(j == c)
                out(a,b:y,k) = in(i,j,k);
            else
                if(in(i,j,k) < in(i,j+1,k))
                   out(a,b,k) = in(i,j,k);
                   out(a,b+1:y,k) = (((in(i,j+1,k) - in(i,j,k))/fact)*(1:1:fact-1) + in(i,j,k));
                else
                   out(a,b,k) = in(i,j,k);
                   out(a,b+1:y,k) = (((in(i,j,k) - in(i,j+1,k))/fact)*(fact-1:-1:1) + in(i,j+1,k));
                end
            end
                
            
            if(i == r)
                out(a:x,b,k) = in(i,j,k);
            else
                if(in(i,j,k) < in(i+1,j,k))
                   out(a,b,k) = in(i,j,k);
                   out(a+1:x,b,k) = (((in(i+1,j,k) - in(i,j,k))/fact)*(1:1:fact-1) + in(i,j,k));
                else
                   out(a,b,k) = in(i,j,k);
                   out(a+1:x,b,k) = (((in(i,j,k) - in(i+1,j,k))/fact)*(fact-1:-1:1) + in(i+1,j,k));
                end
            end
           
            b=b+fact;
            y=y+fact;
        end
        x=x+fact;
        a=a+fact;
    end   
end
%--------------------------------------------------------------------------------------------

%--------------------------------------------------------------------------------------------
for k=1:ch
    
    for i=1:new_r
        
         for j=1:new_c
              
             if(out(i,j,k) == 1)
             
                 if((j+fact-1) > new_c)
                     out(i,j:(j+fact-2),k) = out(i,j-1,k);
                 else
                     
                     if(out(i,j-1,k) < out(i,(j+fact-1),k))
                        out(i,j:(j+fact-2),k) = (((out(i,(j+fact-1),k) - out(i,j-1,k))/fact)*(1:1:fact-1) + out(i,j-1,k));
                     else
                        out(i,j:(j+fact-2),k) = (((out(i,j-1,k) - out(i,(j+fact-1),k))/fact)*(fact-1:-1:1) + out(i,(j+fact-1),k)); 
                     end    
                     
                 end    
                 
             end
               
         end 
        
    end    
    
end 
%---------------------------------------------------------------------------------------------------

result = uint8(out);

end