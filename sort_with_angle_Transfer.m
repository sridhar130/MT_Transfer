%---------------------------------------------------------------------------
%Sorting with Scattering Angle
%This is old code for sorting data from HH-files. The HH-Files contain the 
%coordinates and scattering angles. l1, l2 decide the bin-widths
%or pixel size. 'a' and 'b' are multi-dimensional cells which contain the 
% scattering coordinates and scattering angle.
%THIS IS A CODE WHICH PRE_DATES THE USE OF S-PARAMETER.
%---------------------------------------------------------------------------

data=load('C:\Users\user\Documents\MATLAB\finalData2\RectRod\HHRectRod_10320');% loads the matlab-format file, whcih contains corrdinates and angles.
HH=data.HH;
lm9=size(HH);
lm10=lm9(1);
m1 = lm10; % extracting size or the number of events.
% for smaller files
fact = 1;%88/3.5; % if scaling needed
m =round(m1/fact); % rounding of fractional event numbers

tic; % stopwatch starts
%----------------------------------------------------------------------------
%first sorting along the X axis
for i=1:m
    for j=1:m-1
        if HH(j,1)>HH(j+1,1)
            b=HH(j+1,:);
            HH(j+1,:)=HH(j,:);
            HH(j,:)=b;   
        end 
    end
   % disp(i);
end
 toc; % stopwatch stops
 l1=-150:4:150;% 300/4 = 75, if used 6; 50 
 l2=-150:4:150;
 
for j=1:75%50 %Number of bins
      n1=0;
    for k=1:m
       
    if HH(k,1)>=l1(j) && HH(k,1)<l1(j+1)
        n1=n1+1;
   
        h1(:,j,:,n1)={HH(k,1:4)};
        h2(j,n1) = {HH(k,1:4)};
       % break 
    end
    
    end
   NX(j)=n1; 
end
% sorting along the Y axis for each column in X direction
% NX has been already sorted along one direction and same will be used for other dierection.
% for j3=1:50
% for j2=1:50
%     n2=0;
%          for j1=1:NX(j3)
%          a=h{1,j3,1,j1};
%          
%          %disp('done');
%          
%         if a(2)>=l1(j2) && a(2)<=l1(j2+1)
%             
%              n2=n2+1;
%              %disp(s); 
%              h(j2,j3,1,n2)={a};
%          
%         end
%         NY(j2,j3,1)=n2;% ploting this will give us contour plot and save it for further work as a mat file.
%         NY(j2,j3,2)=a(4); % scattering angle is assigned to the second dimension of 'NY'
%        %disp(j2);
%      end
% end
% end
% --------------------------------for a two storied system with angle in the second dimension--------------------------------------------------------
for j3=1:75%50
for j2=1:75%50
    n2=0;
    s=0;
    
     for j1=1:NX(j3)
         a=h1{1,j3,1,j1};
         b1= h2{j3,j1};
         
        % disp('done');
         
        %if a(2)>=l1(j2) && a(2)<l1(j2+1)
         if b1(2)>=l1(j2) && b1(2)<l1(j2+1)
             n2=n2+1;
             %ang = ((a(4))^2)/12;
             ang = b1(4);
             
             s=s+ang; % sum of the scattering angles in the given pixel.
           % h(j2,j3,1,n2)={a};
      
        end
   
     end
        NY(j2,j3,1)=n2;  % ploting this will give us contour plot and save it for further work as a mat file.
        NN(j2,j3)=n2;
       % formatSpec = 'j2 = %5d j3 = %5d n2 = %5d \n';
        %fprintf(formatSpec,j2,j3,n2);
        NY(j2,j3,2)=s*n2;
        NN2(j2,j3) =s*n2; % the angle parameter
end
end
