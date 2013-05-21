%% This script initializes the simulation parameters, material properties
%  and input data, then goes on to carry out the simulation.

%% Initialize the simulation
initializeSimulation;

%% Load data from files
slipPlane = readSlipPlane (slipPlaneDataFile);

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
    dislocationList = slipPlane.listDislocations;
    numDislocations = size(dislocationList, 1);
    
    dislocationPositions  = zeros(numDislocations, 3);
    dislocationForces     = zeros(numDislocations, 3);
    
    %% Initialize stresses for dislocations
    dislocationStress = zeros(numDislocations, 3, 3);
    dislocationInteractionStress = zeros(numDislocations, 3, 3);
    dislocationTotalStress = zeros(numDislocations, 3, 3);
    
    %% Initialize  and calculate dislocation positions, stresses and forces
    for i=1:numDislocations
        dislocationPositions(i,:) = dislocationList(i).position;
        dislocationStress(i,:,:) = appliedStress;
        for j=1:numDislocations
            if (i~=j)
                dislocationInteractionStress(i,:,:) = dislocationInteractionStress(i,:,:) + ...
                    dislocationStressField(dislocationList(j), dislocationPositions(i,:), BurgersVector, mu, nu);
            end
        end
        dislocationTotalStress(i,:,:) = dislocationStress(i,:,:) + dislocationInteractionStress(i,:,:);
        dislocationForces(i,:) = forcePeachKoehler(dislocationTotalStress(i,:,:),dislocationList(i),BurgersVector);
    end
    
    %% Calculate velocities
    dislocationVelocities = dislocationForces / dragCoefficient;
    
end
