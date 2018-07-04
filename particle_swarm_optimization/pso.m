%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%   Universidade Federal do Ceará                                         %
%   Class: Inteligência Computacional                                     %
%   Student: Julio Cesar Ferreira Lima                                    %
%   Professor: Jarbas Joaci de Mesquita Sá Junior                         %
%   Enrrollment: 393849                                                   %
%   Homework: Particle Swarm Optimization - PSO                           %
%   Repository: https://github.com/juloko/computacional-inteligence       %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%This structure was used to maintain the compatibility with all versions.
%In the main of file could be called not just the main but each function.
function pso()
    
    %Call the main function of simulation.
    main()
    
    %Call the tests.
    %clc; %Cleaning IDE.
    %clf; %Cleaning Figures.    
    %generations(500,500,20,3,'n',300);

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
        disp('This software gonna try to find the max value for the function: |x*sin(y*PI/4) + y*sin(x*PI/4)|');
        
        %Defining scope.
        scope = input('Type how so far you wanna see? (0 to infinite) ');

        
        %Creating the first individuals.
        maxRobots = input('Using Particle Swarm Optimization, how much particles do you wanna create? ');
        maxEpochs = input('How much epochs do you wanna run? ');
      
        %Selecting the type of chart ploted.
        typeChart = input('Which type of chart that you wanna see 2D or 3D (2 or 3)? ');
        if(typeChart == 3)
            trace = input('Do you wanna show the previous traces of particles (y\\n)? ','s');
        else
            trace = 'n';
        end
        
        %Selecting the delay between epochs.
        delay = input('Type the delay between epoochs (miliseconds): ');
        
        %Clean all figures
        clf;
        
        %Call to PSO function to find the maximum.
        generations(maxRobots, maxEpochs,scope, typeChart, trace, delay);
        
        %Requesting with the user wanna try one more time.
        request = input('Do you wanna try one more test? (y\\n): ','s');
        tests = strcmp(request,'y');
    end
end



function generations(maxRobots, maxEpochs, scope,typeChart, trace, delay)   
    %Create swarm population.
    population = Population(maxRobots, scope);
    %Receive parameters of population.
    actualGen = population.getEpochs();
    XF = population.getXF();
    %Plot config.
    hold on;
    title('3D Chart of f(x,y)=|(x*sin((y*PI)/4) + y*sin((x*PI)/4)|');
    if(typeChart == 3)
        %Include surface;
        x1=0:scope*.005:scope;
        y1=0:scope*.005:scope;
        [x,y] = meshgrid(x1,y1);
        z = abs(x.*sin((y.*pi())/4) + y.*sin((x.*pi())/4));
        mesh(x,y,z,'FaceLighting','gouraud','LineWidth',0.3);    
        xlabel('x-axis');
        ylabel('y-axis');
        zlabel('f(x,y)');
        xlim ([0 scope]);
        ylim ([0 scope]);
        zlim ([0 2*scope]);
        grid on;
        view(-45,45);
        hPlot = plot3(XF(:,1),XF(:,2),XF(:,3),'h',...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[1 0 1]);
        set(hPlot,'Color',[1 0 1]);
    else
        if(typeChart ==2)
            xlabel('Epochs');
            ylabel('f(x,y)');
            xlim auto;
            ylim auto;
            hPlot = plot(actualGen,XF(:,3),'^');
        end
    end
    %Loop of epochs.
    while actualGen<maxEpochs
        %Move population.
        %Show the population parameters in console, like pG and epochs.
        population = population.movePop();
        actualGen = population.getEpochs();
        XF = population.getXF();
        %Plot  chart.
        if(typeChart == 3)
            if(strcmp(trace,'y'))
                hPlot = plot3(XF(:,1),XF(:,2),XF(:,3),'x');
            else
                set(hPlot,'XData',XF(:,1), 'YData',XF(:,2) , 'ZData',  XF(:,3));
            end
            
        else
            if(typeChart == 2)
                height = size(XF);
                height = height(1);
                hPlot = plot(actualGen*ones(height,1),XF(:,3),'^');
            end
        end  
        %Pause update to user observation.
        pause(delay/1000);
    end
end