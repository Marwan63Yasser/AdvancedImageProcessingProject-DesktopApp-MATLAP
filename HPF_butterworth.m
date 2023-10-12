%-----Create by: Marwan Yasser------G:CS1----------------%
%Highpass Filrer (edge detection): Butterworth Highpass Filrer
%parameter: -original image -D0 (optional-default:15) -Order(n) (optional-default:2)

function result=HPF_butterworth(in,d,n)

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
res=ones(r,c);

%setting values to mask matix
for u=1:r
   for v=1:c
       mask(u,v) = sqrt(power(u-(r/2),2) + power(v-(c/2),2));
       %apply high-pass Butterworth function
       mask(u,v) = 1/( 1 + power((d/mask(u,v)),2*n) );

   end
end

   
    
for u=1:r
  for v=1:c
   %apply the filter (Multiply orginal image (fourier form) element by mask element)
   res(u,v) = fts(u,v)*mask(u,v);    
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