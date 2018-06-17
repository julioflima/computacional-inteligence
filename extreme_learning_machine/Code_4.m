%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%       Universidade Federal do Ceará                               %
%       Class: Inteligência Computacional                           %
%       Student: Julio Cesar Ferreira Lima                          %
%       Professor: Jarbas Joaci de Mesquita Sá Junior               %
%       Enrrollment: 393849                                         %
%       Homework: Extreme Leraning Machine                          %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('twomoons.dat');
base = twomoons;

hiddenNeurons = 7;
params = 2;

%Get vector of dataset
X = base(:,1:2)';

%Output vector
D = base(:,3)';

for i = 1:2
    X(i,:) = (X(i,:)-mean(X(i,:)))/std(X(i,:));
end

% Bias.
X = [(-1)*ones(1,1001);X];

W = 0.1*rand(hiddenNeurons,(params+1));

u = W*X;
z = 1./(1+exp(-u));
z = [(-1)*ones(1,1001);z];

M = D*z'*inv(z*z');

xTest = zeros(3,1);
z = zeros(3,1);

for i = -2:0.05:2
    for j = -2.5:0.05:2.5
        xTest = [-1;j;i];
        u = W*xTest;
        z = 1./(1+exp(-u));
        z = [-1;z];
        aTest = M*z;

        if (aTest>=-0.1)&&(aTest<=0.1)
            
            %Plot delimiter.
            scatter(xTest(2),xTest(3),3,'o', 'green')
            %Wait for plot the second one.
            hold on
        end
    end
end

%Plot chart using the classifier.
scatter(X(2,:), X(3,:), 4, D>0 ,'^');