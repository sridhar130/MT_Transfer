%----------------------------------------------------------------
%------Pattern Recognition Method (old) -------------------------
% It starts with the NY-files saved by 'sort_with_angle_Transfer.m'
% Initially the PRM used to find out the maximum values along the  
% whole mother-matrix instead of looking for a given value corresponding 
% to a material. 

%----------------------------------------------------------------
J9=load('NY_Mix2_200um.mat'); % this is the matrix for one plane , please save the categorized matrix for minimisation of running time
J=J9.NY(:,:,1); % coordinates
J7 = J9.NY(:,:,2); % angles

div=2.0; % setting the restriction value for filtering

c2=3; % size of the weighted matrix

val1=0;
si=size(J);
p1=si(1);
p2=si(2);
n10=0;
A=[];

% finding the weighted matrix
% finsing the maximums
for a=1:p1-c2
    for b=1:p2-c2
    
p=a;
q=b;

J2=zeros(c2,c2);
    valq =0;       
               for i=1:c2
                    q=b;
                   for j=1:c2
                         J2(i,j)=J(p,q);
                         q=q+1;
   %     disp(J(p,q));   
                        val2=sum(sum(J2));
                         
                         %disp(J2); disp(val2);
                         if val2>=val1
                             J1=J2;
                             val1=val2;
    %    disp(p);disp(q);
                         end
                       
                   end
                      p=p+1;
               end
               valq = sum(sum(J2.*J2));
               disp(valq)
                A = [A;valq];
 p=p-c2;
 q=q-c2;
    end
end
% s = size(A,1)
% sum1 = sum(A)
% avg = sum1/s

% filtering
 val3=sum(sum(J1.*J1)); % finding the value for exactness

 for a=1:p1-c2
    for b=1:p2-c2

p=a;
q=b;

J2=zeros(c2,c2);
          
               for i=1:c2
                    q=b;
                   for j=1:c2
                         J2(i,j)=J(p,q);
                         q=q+1;
   %     disp(J(p,q));
    %    disp(p);disp(q);
                   end
                      p=p+1;
               end
 
p=p-c2;
q=q-c2;

val=sum(sum(J2.*J1));
disp(val);
%disp(J2); disp(J2.*J1);

%disp(val);
if val<=val3/div
    J(p,q)=0;
   %disp('less than 1');
    %disp('done');
end
   if val>val3/div
      for i2=1:J(p,q)
         % a1=h{p,q,r,i2}; disp(a1);
          %disp(a1);
          
          %plot3(a1(1),a1(2),a1(3),'.'); hold on;
          n10=n10+1;
          %S(n10,:)=a1; disp('greater than 1');
      end
   end


    end
    disp('done');
 end
 
 % filtering in the reverse order
  
  for a=p1:-1:1+c2
    for b=p2:-1:1+c2
 
p=a;
q=b;

J2=zeros(c2,c2);
          
               for i=1:c2
                    q=b;
                   for j=1:c2
                         J2(i,j)=J(p,q);
                         q=q-1;
   %     disp(J(p,q));
    %    disp(p);disp(q);
                   end
                      p=p-1;
               end
 
p=p+c2;
q=q+c2;

val=sum(sum(J2.*J1));
disp(val);
%disp(J2); disp(J2.*J1);

%disp(val);
if val<=val3/div
    J(p,q)=0;
   %disp('less than 1');
    %disp('done');
end
   if val>val3/div
      for i2=1:J(p,q)
         % a1=h{p,q,r,i2}; disp(a1);
          %disp(a1);
          
          %plot3(a1(1),a1(2),a1(3),'.'); hold on;
          n10=n10+1;
          %S(n10,:)=a1; disp('greater than 1');
      end
   end


    end
    disp('done');
  end
% %%%%%%%%%%%%%%%%%%%%
%  
%  
% %contour(J); % This represnts the filtered-NY or the PRM results.
NN2(:,:,1)= J;

NN2(:,:,2)=NY(:,:,2); % assinging the scattering angles.

% marking some pixels in NN2 those pixels which are 0 in J.  
for ii =1:p1
    for jj = 1:p2
        if NN2(ii,jj,1)==0
           NN2(ii,jj,2)= 0;
           n5(ii,jj) = 0;
        else
            NN2(ii,jj,2)=J7(ii,jj,1);
            n5(ii,jj) = J7(ii,jj,1);
        end
    end
end