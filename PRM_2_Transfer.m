%----------------------------------------------------------------
%------Pattern Recognition Method (new) -------------------------
% The code directly takes output H-matrix from the 'Accumuracy_hist.m'
% Instead, there is also a provisio  of using NY matrcies.
% loads the data from 2D histogram (Acumuracy_hist), convolute by filter
% matrix, and decides noise or signal
% PRM
%----------------------------------------------------
clear all;
data=load('C:\Users\user\Documents\MATLAB\G220\MatlabPlots\Void\File2New\H_6cmVoid_8e8');%mydata
HH=data.H;
lm9=size(HH); 
lm10=lm9(1);
m1 = lm10;
% for smaller files
%fact = 2;%88/3.5;


%m =round(m1/fact);
%HH = HH(1:m,:);

%J9=load('C:\Users\user\Documents\MATLAB\finalData2\FiveBlocks\replot\NY_FiveBlocks_500_6cm_7hr_replot'); % this is the matrix for XZ plane , please save the categorized matrix for minimisation of running time
%J=J9.NY(:,:,1);
%J7 = J9.NY(:,:,2);
J = HH;
%J=J9.NN;
div=2;%4.5 % setting the  restriction value for filtering
factor = 1.0; % If the objest is larger than the sample.
c2=3; % size of the weighted matrix
mAB = 6.58;%3.27; %mean obtained from a sample of known material obtained from Acumuracy_hist.
stdAB = 0.0; % std deviation for the same (can choose 0 or the value from Accumuracy_hist).
% filter matirx generated using gaussian dist. of mean and std obtained
% from sample distribution
F = normrnd(mAB,stdAB,[c2,c2]);
ev = mAB; % threshold per bin 
e = ones(c2,c2)*ev;
%High = (ev^2)*(c2^2)*factor;
High = sum(sum(F.*F));
si=size(J);
p1=si(1);
p2=si(2);

n10=0;
A=[];

%---------------------------------------------------------------------------
Jf = zeros(p1,p2);
for i = 1:p1-c2+1
    for j = 1:p2-c2+1
        J1 = J(i:i+2,j:j+2);
        sum1 = sum(sum(F.*J1));  %e.J1
       % disp(sum1);
        if sum1 > High
          Jf(i:i+2,j:j+2) = J(i:i+2,j:j+2);
        end
    end
end
%----------------------------------------------------------------------------
%--------------------------reverse filtering--------------

for i = p1:-1:1+c2
    for j = p2:-1:1+c2
        J1 = J(i-2:i,j-2:j);
        sum1 = sum(sum(F.*J1));
        if sum1 > High
          Jf(i-2:i,j-2:j) = J(i-2:i,j-2:j);
        end
    end
end
% %--------------------------------downside-------------------------------------------
% Jf = zeros(p1,p2);
% for i = 1:p1-c2+1
%     for j = 1:p2-c2+1
%         J1 = J(j:j+3,i:i+3);
%         sum1 = sum(sum(e.*J1));
%         if sum1 > High
%           Jf(j:j+3,i:i+3) = J(j:j+3,i:i+3);
%         end
%     end
% end
% %----------------------------------------------------------------------------
% %--------------------------upside filtering--------------
% 
% for i = p1:-1:1+c2
%     for j = p2:-1:1+c2
%         J1 = J(j-3:j,i-3:i);
%         sum1 = sum(sum(e.*J1));
%         if sum1 > High
%           Jf(j-3:j,i-3:i) = J(j-3:j,i-3:i);
%         end
%     end
% end


%contour(Jf); % can be polotted to see the filtered plot contour




Nf = Jf;




% ---plot cubes at the reconstructed locations---------------------
%--------------------------------------------------------------------

nn =size(Nf);   % size of the matrix generated from 
n1 =nn(1);        % x-size
n2 =nn(2);        % y-size
%n3 =nn(3);        % z-size
cnt =0;           % a counter
PlotAvg2 = zeros(n1*n2,3);

tic;
for ij = 1:n1
    for jk = 1:n2
            if Nf(ij,jk,1)>0
                cnt =cnt+1; 
            PlotAvg2(cnt,1)= ij;
            PlotAvg2(cnt,2)= jk;
            PlotAvg2(cnt,3)= Nf(ij,jk);
            %PlotAvg(cnt,4)= avg(ij,jk,kl);
            end
    end
          % disp(cnt);
end
    %end

toc;
%disp(cnt);
fprintf('count =%d \n',cnt);
PlotAvg2 =PlotAvg2 (1:cnt,:);      % throw away other zeros
for ii=1:cnt
  %if PlotAvg(ii,4)==nan
  if isnan(PlotAvg2(ii,3))
     PlotAvg2(ii,3)=0;
  end
end


% %---- plotting the cube----------------
% 
%scatter(HH(:,1),HH(:,2),2,'black');

bins = -400.0:10:400.0;  NumBins = numel(bins);
[XX, YY] = meshgrid(bins, bins);
%figure(1);
figure('Renderer', 'painters', 'Position', [2 2 800 600]);
surf(XX, YY, HH); 
shading flat
colorbar;
colormap jet;%(flipud(jet)); %flipud flips the color map

hold on;
cl = zeros(size(Nf,1));
bg = zeros(size(Nf,1));
an = ones(size(Nf,1));
for sk =1:size(Nf,1)
    for tk = 1:size(Nf,1)
        if Nf(sk,tk)>0
            cl(sk,tk) = 1;
        else bg(sk,tk) =1;
        end
    end
end

CO(:,:,1) = an;
CO(:,:,2) = bg;%zeros(size(XX,1));
CO(:,:,3) = bg;%zeros(size(XX,1));
%surf(XX, YY, Nf,CO);
view(0,90); 

%--------------------------------------
Y=PlotAvg2(:,1);
X=PlotAvg2(:,2);
Z=PlotAvg2(:,3);
 %for i=i:cnt
    
    % plotcube([1 1 1]*6,[ X(i)*6-156 Y(i)*6-156 0],.8,[1,0,0]);%,
    % plotcube([1 1 1]*5.0,[ X(i)*5.0-305 Y(i)*5.0-305 0],.99,[1,0,0]);% for 5mm  % tool used to completely paint the target pixel
    
    hold on;

 %end
 axis([-390 390 -390 390]); 
 %view(0,90);  
 
% %-------------------------------------
%plotting cosmetics 
box on;
title('(e) Deck With 6 cm Void ','FontName','Times New Roman','FontSize',22,'FontWeight','bold');
xlabel('X-direction (mm)','FontName','Times New Roman');
ylabel('Y-direction (mm)','FontName','Times New Roman');
ax = gca;
ax.FontSize = 22;
ax.Color = 'black';
ax.FontName = 'Times New Roman';


%saveas(gcf,'C:\Users\user\Documents\MATLAB\G220\MatlabPlots\Void\Void6cm.png')
    