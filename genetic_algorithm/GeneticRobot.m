classdef GeneticRobot
    %GENETICROBOT 
    %   The body of robot contain all data of parents.
    %   The mutation is generated based in a kinship between parents.
    %   Autor: Julio Lima
    
   properties
    x;
    xMom;
    xDaddy;
    y;
    yMom;
    yDaddy;
    generation;
    genMom;
    genDaddy;
    lenDNA;
    offsetMutation;
   end
   methods
    function robot = GeneticRobot(mom, daddy, gen,offsetMutation)
        if nargin == 2
            %Create a robot base in a DNA of God.
            godDNA = dec2bin(mom);
            compLen = size(godDNA);
            lenGodDNA = daddy;
            godDNA  = [ones(1,(lenGodDNA-compLen(2)))*48 godDNA];
            robot.x = godDNA(1:lenGodDNA/2);   
            robot.y = godDNA((lenGodDNA/2+1):lenGodDNA);
            robot.xMom = robot.x;
            robot.yMom = robot.y;
            robot.xDaddy = robot.x;
            robot.yDaddy = robot.y;
            robot.lenDNA = lenGodDNA;
            robot.generation = 1;
            robot.genMom = robot.generation;
            robot.genDaddy = robot.generation;
        else
            %Create a robot base in a Mom and Daddy.
            robot.offsetMutation = offsetMutation;
            robot.xMom = mom.x;
            robot.yMom = mom.y;
            robot.xDaddy = daddy.x;
            robot.yDaddy = daddy.y;
            robot.generation = gen;
            robot.genMom = mom.generation;
            robot.genDaddy = daddy.generation;
            robot.lenDNA = mom.lenDNA;
            cutoff = robot.crossover();
            momDNA = [mom.xMom robot.yMom];
            daddyDNA = [robot.xDaddy  robot.yDaddy];
            robotAuxDNA = [momDNA(1:cutoff) daddyDNA((cutoff+1):robot.lenDNA)];
            robotDNA = robot.mutation(mom.generation,daddy.generation,robotAuxDNA);
            robot.x = robotDNA(1:robot.lenDNA/2);
            robot.y = robotDNA((robot.lenDNA/2+1):robot.lenDNA);            
        end
    end
    function robotDNA = mutation(robot,momGen,daddyGen,robotAuxDNA)
        %Around 14% chance of mutation if in the same generation.
        %Decrease percentage which if not similar.
        %Find the kinship between the parents.
        sameGenLvl = abs(momGen-daddyGen);
        robotDNA = zeros(1,robot.lenDNA);
        for i = 1:robot.lenDNA
            %Generate a mutation probability. 
            mutationProb = exp(-(sameGenLvl+robot.offsetMutation));
            %Generate a number, if below then the mutation probability...
            if(rand()<mutationProb)
                robotDNA(:,i) = randi([48 49],1);
            else
                robotDNA(:,i) =  robotAuxDNA(:,i);
            end 
        end
        %Convert of char to char array of bin.
        robotDNA = minus(robotDNA,48);
        robotDNA = dec2bin(robotDNA)';
        disp(robotDNA);
    end
    function cutoff = crossover(robot)
        cutoff = randi([1 (robot.lenDNA-1)],1);
    end
    function gen = getGeneration(robot)
        %Get the robot generation.
        gen = robot.generation;
    end
    function x = getX(robot)
        %Get the robot X chromosome.
        x = bin2dec(robot.x);
    end
    function y = getY(robot)
        %Get the robot X chromosome.
        y = bin2dec(robot.y);
    end
    function evaluation = getEvaluation(robot)
        %Calculate if the locus of the robot.
        x = bin2dec(robot.x);
        y = bin2dec(robot.y);
        evaluation = abs(x*sin((y*pi())/4) + y*sin((x*pi())/4));
    end
   end
end