%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%       Universidade Federal do Ceará                               %
%       Class: Inteligência Computacional                           %
%       Student: Julio Cesar Ferreira Lima                          %
%       Professor: Jarbas Joaci de Mesquita Sá Junior               %
%       Enrrollment: 393849                                         %
%       Homework: Radial Basis Function                             %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function workspace = Code_5()
    %Call the main function of simulation.
    main();
end

function main()
    clear all;
    close all;
    clc;

    load iris_log.dat

    global base percent sumAwards m n auxNumTest numRuns ;

    base = iris_log;

    percent = 0;
    while percent == 0 || percent > 0.4
        clc;
        close all;
        disp('Neural Network Radial Base Function');
        percent = double(input('Pecentage of sample test? (enter a number below then 0.4): '));

    end

    numRuns = input('How much time do you wanna run before get media?: ');
    sumAwards = 0;
    [m, n] = size(base);    
    auxNumTest =  m * percent;

    while numRuns == 0 
        numRuns = input('Percent of test samples?: ');

    end

    %Base of test and training.
    [baseTest, baseTraining]  = getBaseTest();
    X = baseTraining(:,1:4);
    D = baseTraining(:,5:7);

    for it  = 1:numRuns
        net = feedforwardnet([]);

        net = newrb(X', D');
        
        y = net(baseTest(:,1:4)');
        close all;
        [l c] = size(baseTest(:,5:7)');  
        classTest = baseTest(:,5:7)'; 

        awards = 0;

        for i = 1: c  

            if classTest(1, i) == 1
                aux = 1;
            end
            if classTest(2, i) == 1
                aux = 2;
            end
            if classTest(3, i) == 1
                aux = 3;
            end

            for j = 1:3        
                if (y(j,i) == max(y(:,i)) && j == aux)
                    awards = awards + 1;
                end
            end
        end
        sumAwards = awards + sumAwards;
        clearvars -except base percent sumAwards cont m n auxNumTest baseTest baseTraining X D numRuns;
    end
    taxAwards = sumAwards / (auxNumTest * numRuns) * 100;
    fprintf('Tax media of awards: %.2f %% \n',taxAwards);
end


function testSample = randomTrainingTester()
    global m auxNumTest;   
    test = [];
    
    for i = 1:auxNumTest
        r = cast(((m + 1) *rand() ) , 'uint32');
        for k = 1:length(test)
            while (test(k) == r)
                r = cast((m*rand() ) , 'uint32');
            end
        end
        test = [test r];
    end
    testSample = test;
end
 
function [baseTest, baseTraining ] = getBaseTest()
    testIndex = randomTrainingTester();
    testIndex = sort(testIndex, 'descend');
    
    global base  auxNumTest;
    
    baseTest = [];
    baseTraining = base;
    
    for j = 1:auxNumTest
        aux = testIndex(1,j) - 1;
        b = base(aux,:);
        baseTest = [baseTest; b];
        baseTraining(abs(aux), :) = [];
    end
end