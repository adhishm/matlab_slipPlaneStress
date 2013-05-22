%% This script initializes the simulation parameters, material properties
%  and input data, then goes on to carry out the simulation.

%% Initialize the simulation
initializeSimulation;

%% Load data from files
slipPlane = readSlipPlane (slipPlaneDataFile, dislocationListFile, dislocationSourceListFile);

%% Initiate the figure
figureHandle = figure;

%% Iteration counters
totalTime = 0.0;
totalIterations = 0;
continueSimulation = true;

%% Estimate number of iterations
if (stoppingCriterion == 0)
    % Number of steps
    numIterations = limitingSteps;
else
    % Time
    numIterations = 1 + (limitingTime/limitingTimeStep);
end

%% Initialize statistics
% Time, positions, stresses (dislocations), f_PK, stress distribution (slip
% plane)
stats = cell (numIterations, 5);

%% Iterate
while (continueSimulation)
    
    %% Pre-allocate dislocationPosition vectors
    % Sort dislocations on the slip plane
    slipPlane.listDislocations = sortDislocations(slipPlane);
    dislocationList = slipPlane.listDislocations;
    numDislocations = size(dislocationList, 2);    
    dislocationPositions  = zeros(numDislocations, 3);
    dislocationForces     = zeros(numDislocations, 3);
    
    %% Initialize stresses for dislocations
    dislocationStress = cell(numDislocations, 1);
    dislocationInteractionStress = cell(numDislocations, 1);
    dislocationTotalStress = cell(numDislocations, 1);    
    for i=1:numDislocations
        dislocationStress{i} = zeros(3,3);
        dislocationInteractionStress{i} = zeros(3,3);
        dislocationTotalStress{i} = zeros(3,3);
    end
    
    %% Initialize  and calculate dislocation positions, stresses and forces
    for i=1:numDislocations
        dislocationPositions(i,:) = dislocationList(i).position;
        dislocationStress{i} = appliedStress;
        for j=1:numDislocations
            if (i~=j)
                dislocationInteractionStress{i} = dislocationInteractionStress{i} + ...
                    dislocationStressField(dislocationList(j), dislocationPositions(i,:), BurgersVector, mu, nu);
            end
        end
        dislocationTotalStress{i} = dislocationStress{i} + dislocationInteractionStress{i};
        dislocationForces(i,:) = forcePeachKoehler(dislocationTotalStress{i},dislocationList(i),BurgersVector);
    end
    
    %% Calculate velocities
    dislocationVelocities = dislocationForces / dragCoefficient;
    % Sessile dislocations will have zero velocity
    for i=1:numDislocations
        dislocationVelocities(i,:) = dislocationList(i).mobile * dislocationVelocities(i,:);
    end
    
    %% Time increment
    [globalTimeIncrement, timeIncrements] = timeIncrement(slipPlane, dislocationVelocities, limitingDistance, limitingTimeStep);
    totalTime = totalTime + globalTimeIncrement;
    totalIterations = totalIterations + 1;
    
    %% Pin dislocations whose time increments are less than the
    %  globalTimeIncrement. This is done because these dislocations are
    %  beginning to approach another object closer than the allowed
    %  limitingDistance.
    for i=1:numDislocations
        if (timeIncrements(i) < globalTimeIncrement)
            dislocationList(i).mobile = false;
        end
    end
    
    %% Update dislocation positions
    for i=1:numDislocations
        dislocationPositions(i,:) = dislocationPositions(i,:) + (dislocationList(i).mobile * dislocationVelocities(i,:) * globalTimeIncrement);
        dislocationList(i).position = dislocationPositions(i,:);
    end
    
    %% Update the slipPlane structure
    slipPlane.listDislocations = dislocationList;
    
    %% Draw the situation
    
    
    %% Update statistics
    % Time, positions, stresses (dislocations), f_PK, stress distribution
    % (slip plane)
    stats{totalIterations, 1} = totalTime;
    stats{totalIterations, 2} = dislocationPositions;
    stats{totalIterations, 3} = dislocationInteractionStress;
    stats{totalIterations, 4} = dislocationForces;
    stats{totalIterations, 5} = slipPlaneStressDistribution(slipPlane, appliedStress, BurgersVector, mu, nu, slipPlaneStressResolution);
    
    %% Stopping criterion
    if (stoppingCriterion == 0)
        % Number of steps
        continueSimulation = (totalIterations <= limitingSteps);
    else
        % Total time
        continueSimulation = (totalTime <= limitingTime);
    end    
    
end
