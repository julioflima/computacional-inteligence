classdef Population
    %POPULATION 
    %   Autor: Julio Lima
   
   properties
      population;
      maxRobots;
      pG = [0 0];
      epochs = 0;
   end
   methods
   function pop = Population(nPopulation)
        %Create population.
        pop.maxRobots = nPopulation;
        for i=1:pop.maxRobots
            newRobot = SwarmRobot();
            pop.population = [pop.population newRobot]; 
        end
        pop.epochs = pop.epochs + 1;
    end
    function [returnXF] = getXF(pop)
        %Get the evaluation and position of each robot of population.
        returnXF = zeros(pop.maxRobots,3);
        for i=1:pop.maxRobots
            [auxReturnX, auxReturnF] = pop.population(i).getXF();
            returnXF(i,:) = [auxReturnX(1) auxReturnX(2) auxReturnF];
        end
    end
    function pG = getPG(pop)
        %Get best global position.
        listXF = pop.getXF(); 
        listXF = sortrows(listXF,3);
        fullPG = listXF(pop.maxRobots,:);
        pG = [fullPG(1) fullPG(2)];
    end
    function swarming = movePop(pop)
        %Update population.
        pop.pG = pop.getPG();
        for i=1:pop.maxRobots
            pop.population(i) = pop.population(i).move(pop.pG);
        end
        pop.epochs = pop.epochs + 1;
        swarming = pop;
    end
    function epochs = getEpochs(pop)
        %Get the epochs of population.
        epochs = pop.epochs;
    end
   end
end