%-------------------------------------------------------------------
%----------Acumuracy_hist-------------------------------------------
% This is the revised way of sorting. Begins with HH-files. Here the 
% coordinates are sorted and weighting is done by the scatering angle 
% or its sum/S-parameter. 
% In other words it is the code to find the elements of the filter matrix
%-------------------------------------------------------------------
%% Initialize variables.
filename = 'C:\Users\user\Documents\MATLAB\G220\CFST\File2\HH_CFST_NoDef_4e8_Theta30.txt';
delimiter = ' ';
formatSpec = '%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'EmptyValue' ,NaN, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Allocate imported array to column variable names
XX = dataArray{:, 1}; % x-coordinate
YY = dataArray{:, 2}; % y-coordinate
ZZ = dataArray{:, 3}; % scatering angle
%dim1 = round(size(XX,1)*0.33); % for scaling
%XX = XX(1:dim1,:);
%YY = YY(1:dim1,:);
%ZZ = ZZ(1:dim1,:);
HH = [XX,YY,ZZ];
HH2 = HH(:,1:2); % only coordinates
%hist3(HH2,[120,120]) % test the coordinates only
%set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
%shading interp; colorbar; colormap jet; view(0,90);
% Centers of bins (I use integers)
% sorting depending on the ROI: sometimes -300:300 or -150:150
bins = -300.0:5.0:300.0;  NumBins = numel(bins);
%ybins = -150.0:2.5:150.0;  NumBins_y = numel(ybins);

% Mapping data to bin indices
Xi = round( interp1(bins, 1:NumBins, HH(:,1), 'linear', 'extrap') );
Yi = round( interp1(bins, 1:NumBins, HH(:,2), 'linear', 'extrap') );
% Limit indices to the range [1, NumBins]
Xi = max( min(Xi,NumBins), 1);
Yi = max( min(Yi,NumBins), 1);

%HH(:,3) is the weight, i.e. vals = w, not 1. In otherwords histograms with weights (S-parameter)
H = accumarray([Yi(:) Xi(:)],HH(:,3),[NumBins NumBins]); 

%plotting
[XXX, YYY] = meshgrid(bins, bins);
%figure(1);
figure('Renderer', 'painters','Position', [2 2 800 600]);
surf(XXX, YYY, H); 
shading interp;
colorbar; colormap jet; view(0,90); 
hold on;

%figure(2);

%find the mean and sigma for filter matrix. 
%The target is identifed from histograms and average from that location is taken. 
% This is user-intervention or scouting.
AB = H(45:55,65:75); %
dup = zeros(size(H,1));
dup(45:55,65:75) =AB; 

% To test whether the correct target is chosen or not. We do not want zeros in our averages.
%figure('Renderer', 'painters','Position', [2 2 800 600]);
%surf(XXX, YYY, dup); 
%shading flat;
%colorbar; colormap copper; view(0,90); 

%size(AB)
AB = reshape(AB,[1,121]);
%hist(AB);
mAB = mean(AB) % Mean value of the target
stdAB = std(AB) % standard deviation. (One can ignore it while testing)
%F = normrnd(mAB,stdAB);
F = normrnd(mAB,stdAB,[4,4]); % Our filter matrix.
%F = normrnd(mAB,stdAB,[1,400]);
%hist(F)

box on;
title('CFST Without Defect','FontName','Times New Roman','FontSize',22,'FontWeight','bold');
xlabel('X-direction (mm)');
ylabel('Y-direction (mm)','FontName','Times New Roman');
ax = gca;
ax.FontSize = 22;
ax.Color = 'black';
ax.FontName = 'Times New Roman';
axis([-300 300 -300 300]);  
caxis([0 2])