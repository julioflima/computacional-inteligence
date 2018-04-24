%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
% Universidade Federal do Ceará                                     %
% Class: Inteligência Computacional                                 %
% Student: Julio Cesar Ferreira Lima                                %
% Professor: Jarbas Joaci de Mesquita Sá Junior                     %
% Enrrollment: 393849                                               %
% Homework: Aerogenerator Regression                                %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Loading the resource of data.
load aerogerador.dat;

%Geting the array the Speed Wing.
speedWind= aerogerador(:,1);
%Geting the array the Electrical Power.
electricalPower = aerogerador(:,2);
%Geting the dimension of resource of data.
[aeroM aeroN]= size(aerogerador);

%Defining variables, out of scope to test.
order = 999;
lambda = 999;

%Receiving by user the Lambda parameter, repeat if the user put it wrong.
while lambda < 0 || lambda > 1
    %Seting the Lambda parameter, that has to in between 0 <= lambda <= 1.
    lambda= input('Type the LAMBDA parameter, it has to in between 0 <= lambda <= 1, in real numbers: ');
end

%Receiving by user the Order of polynomial parameter.
while order < 2 || order > 5 || mod(order,1) ~= 0
    %Seting the Lambda parameter, that has to in between 2 <= lambda <= 1.
    order= input('Type the ORDER of polynomial 2 a 5, in natural numbers: ');
end

%Choicing the matrix by the order of polynomial.
switch order ~=0
    case order == 2
        X = [ones(aeroM,1) speedWind speedWind.^2];
    case order == 3
        X = [ones(aeroM,1) speedWind speedWind.^2 speedWind.^3];
    case order == 4
        X = [ones(aeroM,1) speedWind speedWind.^2 speedWind.^3 speedWind.^4];
    case order == 5
        X = [ones(aeroM,1) speedWind speedWind.^2 speedWind.^3 speedWind.^4 speedWind.^5];
end

%Geting the dimension of resource of matrix X.
[m n] = size(X); 

%Applying the Tikhonov regularization.
xMDim = order + 1;

%Applying the Multiple Regression Method to obtain Beta.
beta = (inv((X'*X + lambda*xMDim)))*(X'*electricalPower);

%Display Beta matrix.
disp('Betas parameters for polynomial regression: ');
disp(beta);

%Generate the Regression Curve.
regCurve = X*beta;

%Stop updating chat to put more than one curve.
hold on;

%Plot the Aerogenerator chart and set the plot parameters.
plot(speedWind, electricalPower, 'o');
title('Aerogenerator Regression');
xlabel('Speed (m/s)');
ylabel('Power (kW)');

%Plot Regression Curve.
plot(speedWind, regCurve, 'g');

%Determining the Power Medium.
medPower = mean(electricalPower);

%Determining the Sum of Squares Total.
difReg = minus(electricalPower, regCurve).^2;
sumDifReg = sum(difReg);

%Determining the Sum of Squares of Residues.
difMed = minus(electricalPower, medPower).^2;
sumDifMed = sum(difMed);

%Determining the Determination Coeficient.
coefR2 = 1 -sumDifReg/sumDifMed;
disp('Determination Coeficient:');
disp(coefR2);

%Determining the Determination Coeficient Adjusted.
coefR2Adj = 1 -(sumDifReg/(m-xMDim))/(sumDifMed/(m-1));
disp('Determination Coeficient Adjusted:');
disp(coefR2Adj);
