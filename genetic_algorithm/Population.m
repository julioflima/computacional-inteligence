classdef Population
    %POPULATION 
    %   Are not possible couple with it self.(NOT IMPLEMENTED)
    %   The robots have a life time, and are killed if was a old ones.
    %   The robots are killed if there no space for the new ones.
    %   Autor: Julio Lima
   
   properties
      population;
      actualGen;
      maxAge;
      maxRobots;
      offsetMutation;
   end
   methods
    function pop = Population(genesis,maxAge,maxRobots,offsetMutation)
        %Create population.
        pop.population = genesis;
        pop.actualGen = 1;
        pop.maxAge = maxAge;
        pop.maxRobots = maxRobots;
        pop.offsetMutation = offsetMutation;
    end
    function eden = reproduce(pop)
        %Organize population by evaluation.
        pop.organize('E');
        %Get size of population.
        iPop = size(pop.population);
        nChildrens = fix(iPop(2)/2);
        while nChildrens > 0
            %Generating parents.
            iMom = 0;
            iDaddy = 0;
            parents = 1;
            while parents < 3
                evaluationSum = 0;
                %Randomizing evaluation.
                randomEval = fix(rand()*(pop.getEvaluation()));
                %Randomizing parents from possible parents list.
                for i=1:iPop(2)
                    %Sum evaluations.
                    evaluationSum = evaluationSum + pop.population(i).getEvaluation();
                    if(evaluationSum > randomEval)
                        if(parents == 1)
                            %Save parent.
                            iMom = i;
                            %Store index of parent.
                            evaluationSum = 0;
                        else
                            if(parents == 2 && iMom ~=  0)
                                %Save parent.
                                iDaddy = i;
                                %Creating new robot.
                                newRobot = GeneticRobot(pop.population(iMom),pop.population(iDaddy), pop.actualGen, pop.offsetMutation);
                                %Update population.
                                pop.population = [pop.population newRobot];
                                %Decrease childrens.
                                nChildrens = nChildrens - 1;
                                break;
                            end
                        end
                    end
                end
                parents = parents +1;
            end
        end
        %Update generation.
        pop.actualGen =  pop.turnGeneration();
        %Remove old generation.
        pop.population = pop.kill();
        %Return a bigger population;
        eden = pop;
    end
    function population = kill(pop)
        %Kill old generations.
        for i=1:size(pop.population)
            testRobot = pop.population(i);
            if((pop.actualGen-testRobot.generation) > pop.maxAge)
                pop.population(i) = [];
            end
        end
        %Organize population by generations in descent.
        pop.organize('G');
        %Kill by demand.
        if(getSize(pop)>pop.maxRobots)
            pop.population = pop.population(1:pop.maxRobots);
        end
        population = pop.population;
    end
    function result = getEvaluation(pop)
        popSize = size(pop.population);
        result = 0;
        for i=1:popSize(2)
            result = result + pop.population(i).getEvaluation();
        end
    end
    function sizePop = getSize(pop)
        sizePop = size(pop.population);
        sizePop = sizePop(2);
    end
    function result = turnGeneration(pop)
        result = pop.actualGen + 1;
    end
    function actualGen = getGeneration(pop)
        actualGen = pop.actualGen;
    end
    function organize(pop,typeOrg)
        switch typeOrg
            case 'E'
                robots = pop.population(1);
                evaluation = pop.population(1).getEvaluation();
                for i=2:pop.getSize()
                    robots = [robots ; pop.population(i)];
                    evaluation = [evaluation ; pop.population(i).getEvaluation()];
                end
                messy = table(robots,evaluation);
                neat = sortrows(messy,'evaluation','descend');
                pop.population = neat.robots;
            case 'G'
                for i=1:pop.getSize()
                    robots(i) = pop.population(i);
                    generation(i) = pop.population(i).getGeneration();
                end
                messy = table(robots,generation);
                neat = sortrows(messy,'generation','ascend');
                pop.population = neat.robots;
        end
    end
   end
end