classdef Population
    %POPULATION 
    %   Autor: Julio Lima
   
   properties
      population;
      maxRobots;
      pG = [0 0];
      epochs = 0;
      fG = 0;
      scope;
   end
   methods
   function pop = Population(nPopulation,rScope)
        %Create population.
        pop.maxRobots = nPopulation;
        pop.scope = rScope;
        for i=1:pop.maxRobots
            newRobot = SwarmRobot(pop.scope);
            pop.population = [pop.population newRobot]; 
        end
        pop.epochs = pop.epochs + 1;
    end
    function [returnXF] = getXF(pop)
        %Get the evaluation and position of each robot of population.
        returnXF = zeros(pop.maxRobots,3);
        for i=1:pop.maxRobots
            [auxReturnX, auxReturnF] = pop.population(i).getXF();
            returnXF(i,:) = [auxReturnX auxReturnF];
        end
    end
    function [pG, fG] = getPG(pop)
        %Get best global position.
        listXF = pop.getXF(); 
        for i=1:pop.maxRobots
            if((listXF(i,1)>pop.scope || listXF(i,1)<0) || (listXF(i,2)>pop.scope || listXF(i,2)<0))
                listXF(i,3) = 0;
            end
        end
        listXF = sortrows(listXF,3);
        fullPG = listXF(pop.maxRobots,:);
        newPG = [fullPG(1) fullPG(2)];
        newFG = fullPG(3);
        if(newFG>pop.fG)
            pG = newPG;
            fG = newFG;
        else
            pG = pop.pG;
            fG = pop.fG;
        end       
        fprintf('Maximum local finded: %f\n',fG);            
    end
    function swarming = movePop(pop)
        %Update population.
        [pop.pG, pop.fG] = pop.getPG();
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