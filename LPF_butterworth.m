%-----Create by: Marwan Yasser------G:CS1----------------%
%Lowpass Filrer (smoothing): Butterworth Lowpass Filrer
%parameter: -original image -D0 (optional-default:15) -Order(n) (optional-default:2) 

function result=LPF_butterworth(in,d,n)

if ~exist('d','var')
      d = 15;
end

if ~exist('n','var')
      n = 2;
end

%Convert original image from Spatial Domain into Frequency Domain
ft = fft2(in);
fts = fftshift(ft);
%Create mask and result matrices
[r,c,ch]=size(in);
mask=ones(r,c);
res=ones(r,c,ch);

%setting values to mask matix
for u=1:r
   for v=1:c
       mask(u,v) = sqrt(power(u-(r/2),2) + power(v-(c/2),2));
       %apply low-pass Butterworth function
       mask(u,v) = 1/( 1 + power((mask(u,v)/d),2*n) );
   end
end

%process for gray-scale images
if(ch == 1)    
    
    for u=1:r
       for v=1:c
           %apply the filter (Multiply orginal image (fourier form) element by mask element)
           res(u,v) = fts(u,v)*mask(u,v);    
       end
    end
    
%process for RGB images   
else
    
    for u=1:r
       for v=1:c
           %apply the filter (Multiply orginal image (fourier form) element by mask element)
           res(u,v,1) = fts(u,v,1)*mask(u,v);%for (RED Component)
           res(u,v,2) = fts(u,v,2)*mask(u,v);%for (GREEN Component)
           res(u,v,3) = fts(u,v,3)*mask(u,v);%for (Blue Component)
       end
    end
    
end

%Convert Result image from Frequency Domain into Spatial Domain
Real = real(res);
Imag = imag(res);
res = ifftshift(Real+1i*Imag);
res = ifft2(res);

%show the result
result = uint8(real(res));

end