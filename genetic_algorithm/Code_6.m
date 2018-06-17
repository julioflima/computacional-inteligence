%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%       Universidade Federal do Ceará                               %
%       Class: Inteligência Computacional                           %
%       Student: Julio Cesar Ferreira Lima                          %
%       Professor: Jarbas Joaci de Mesquita Sá Junior               %
%       Enrrollment: 393849                                         %
%       Homework: Genetic Algorithm                                 %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function workspace = Code_6()
    %Call the main function of simulation.
    main();
    
    %Call the tests.
    clc; %Cleaning IDE.
    %workspace = geneticTest(10243,20);
    %workspace = populationTest(10243,20,6,10);
    %workspace = generations(1025,20,3,5000,0,0,2,1);
    
    %x=0:0.5:10;
    %y = exp(-x);
    %plot(x,y);
end

function godFamily = geneticTest(godDNA,lenGod)
   adam = GeneticRobot(godDNA,lenGod);
   eve = GeneticRobot(bin2dec([adam.x adam.y]),lenGod);
   cain = GeneticRobot(adam,eve,1);
   abel = GeneticRobot(adam,eve,1);
   seth = GeneticRobot(cain,abel,1);
   godFamily = [adam eve cain abel seth];
end

function eden = populationTest(godDNA,lenGod,maxAge,maxRobots)
    genesis = geneticTest(godDNA,lenGod);
    kernelGenesis = [genesis(1) genesis(2)];
    eden = Population(kernelGenesis,maxAge,maxRobots);
    eden = eden.reproduce();
end


function main()
    %Defining variables, out of scope to test.
    tests = 1;
    
    while tests > .5

        %Receiving parameters by user.
        %Cleaning IDE.
        close all;
        clear;
        clc;

        %Presentation.
        disp('This software gonna try to find the max value for the function:');
        disp('xsen(y?/4) + ysen(x?/4)');
        disp('Using Genetic Algorithm, what stop condition do you wanna use?');

        %Creating the first individuals.
        godDNA = input('Type the God DNA: ');
        lenGod = input('Type the max lenght of God DNA: ');

        %Creating the first individuals.
        maxRobots = input('Type max number of robots: ');
        maxGen = input('Type how much generations do you wanna run: ');
        maxAge = input('Type the max age of each robot: ');
        offsetMutation = input('Type the mutation offset (0 to infinite): ');
        
        %Selecting the type of chart ploted.
        typeChart = input('Type the type of chart that you wanna see (2 or 3): ');
        delay = 0;

        %Call to GA function to find the maximum.
        generations(godDNA,lenGod,maxRobots,maxGen,maxAge,delay,typeChart,offsetMutation)
        
        %Requesting with the user wanna try one more time.
        request = input('Do you wanna try one more test? (y\\n): ','s');
        tests = strcmp(request,'y');
    end
end

function population = generations(godDNA,lenGod,maxRobots,maxGen,maxAge,delay, typeChart, offsetMutation)
        actualGen = 0;
        adam = GeneticRobot(godDNA,lenGod);
        eve = GeneticRobot(bin2dec([adam.x adam.y]),lenGod);
        genesis = [adam eve];
        population = Population(genesis,maxAge,maxRobots, offsetMutation);
        count = 0;
    while actualGen<maxGen
        population = population.reproduce();
        actualGen = population.getGeneration();
        hold on;
        for i=1:population.getSize()
            x = population.population(i).getX();
            y = population.population(i).getY();
            z = population.population(i).getEvaluation();
            %Plot  chart.
            if(typeChart == 3)
                title('3D Chart of f(x,y)=|(x.sin((y.?)/4) + y.sin((x.?)/4)|;');
                xlabel('X');
                ylabel('Y');
                zlabel('f(x,y)');
                plot3(x,y,z,'o');
            else
                if(typeChart ==2)
                    title('3D Chart of f(x,y)=|(x.sin((y.?)/4) + y.sin((x.?)/4)|;');
                    xlabel('robots');
                    ylabel('f(x,y)');
                    plot(count,z,'^');
                end
            end                       
            pause(delay);
            count = count + 1;
        end
    end
end

