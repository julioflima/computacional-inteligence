classdef SwarmRobot
    %SWARMROBOT 
    %   The body of robot contain all data.
    %   Autor: Julio Lima
    
   properties
    X;
    w;
    pI = [0 0];
    pG = [0 0];
    c1 = 2.05;
    c2 = 2.05;
    r1;
    r2;
    V;
    f;
   end
   methods
    function robot = SwarmRobot()
       robot.X = [rand() rand()];
       robot.w = rand()*0.4;
       robot.r1 = rand();
       robot.r2 = rand();
       robot.V = [rand() rand()];
       robot.f = getEvaluation(robot);
       robot.pI = robot.X;
    end
    function newRobot = move(robot,bestRobot)
        %Verify if the actual position its the best one.
        robot.pG = bestRobot;
        robot.X = robot.updatePosition();
        auxF = getEvaluation(robot);
        if(auxF>robot.f)
            robot.f = auxF;
            robot.pI = getPosition(robot); 
        end
        newRobot = robot;
    end
    function [returnX, returnF] = getXF(robot)
        %Get the evaluation and position of robot.
        returnX = robot.X;
        returnF = robot.f;
    end
    function evaluation = getEvaluation(robot)
        %Calculate the locus of the robot.
        x = robot.X(1);
        y = robot.X(2);
        evaluation = abs(x*sin((y*pi())/4) + y*sin((x*pi())/4));
    end
    function position = getPosition(robot)
        %Get position of robot.
        position = robot.X;
    end
    function position = updatePosition(robot)
        %Calculate position of robot.
        position = robot.X + getVelocity(robot);
    end
    function velocity = getVelocity(robot)
        %Calculate velocity of robot.
        robot.V = (robot.w).*robot.V + (robot.c1*robot.r1).*minus(robot.pI,robot.X) +(robot.c2*robot.r2).*minus(robot.pG,robot.X);
        velocity = robot.V;
    end
   end
end
