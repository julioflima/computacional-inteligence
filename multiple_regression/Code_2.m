%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
% Universidade Federal do Ceará                                     %
% Class: Inteligência Computacional                                 %
% Student: Julio Cesar Ferreira Lima                                %
% Professor: Jarbas Joaci de Mesquita Sá Junior                     %
% Enrrollment: 393849                                               %
% Homework: D Plan Regression                                       %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Loading the resource of data.
D =[   122 139 0.115; 
       114 126 0.120; 
       086 090 0.105; 
       134 144 0.090; 
       146 163 0.100; 
       107 136 0.120; 
       068 061 0.105; 
       117 062 0.080; 
       071 041 0.100; 
       098 120 0.115 ]; 

%Geting the dimension of resource of data D.
[dM dN]= size(D);

%Seting the data D by order 1. 
X=[ones(dM,1),D(:,1), D(:,2)];

%Applying the Multiple Regression Method to obtain Beta.
beta=((X'*X)^(-1)*X'*D(:,3));

%Display Beta matrix.
disp('Betas parameters for polynomial regression: ');
disp(beta);

%Draw a plan that can fit at D.
[X1,X2]=meshgrid(30:0.8:150,30:0.8:150);

%Determination of rotation and orientation of mesh plan.
regressionPlan = beta(1)+beta(2)*X1+beta(3)*X2;

%Determination of distance of points to chart.
regressionPlanDistance = beta(1)+beta(2)*D(:,1)+beta(3).*D(:,2);

%Stop updating chat to put more than one curve.
hold on;

%Activate the grid at chart.
grid on;

%Plot the D chart and set the plot parameters.
plot3(D(:,1),D(:,2),D(:,3),'o');
title('3D Chart of D Data');
xlabel('Axis X');
ylabel('Axis Y');
zlabel('Axis Z');

%Plot Regression Plan.
mesh(X1,X2,regressionPlan);

%Geting the Z componente of D data.
Z = (D(:,3));

%Determining the Z Medium.
medZ = mean(Z);

%Determining the Sum of Squares Total.
difReg = minus(Z, regressionPlanDistance).^2;
sumDifReg = sum(difReg);

%Determining the Sum of Squares of Residues.
difMed = minus(Z, medZ).^2;
sumDifMed = sum(difMed);

%Determining the Determination Coeficient.
coefR2 = 1 -sumDifReg/sumDifMed;
disp('Determination Coeficient:');
disp(coefR2);

%Determining the Determination Coeficient Adjusted.
coefR2Adj = 1 - (sumDifReg/(dM-2))/(sumDifMed/(dM-1));
disp('Determination Coeficient Adjusted:');
disp(coefR2Adj);
