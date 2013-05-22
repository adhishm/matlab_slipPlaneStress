function globalTimeIncrement = timeIncrement(slipPlane, velocities, limitingDistance, limitingTimeStep)
%% globalTimeIncrement = timeIncrement(slipPlane, velocities,limitingDistance, limitingTimeStep)
%  This function calculates the time increment necessary for the
%  dislocations to move without overtaking each other or approaching each
%  other closer than the distance given by limiting distance.
%  Arguments:
%  slipPlane:       The slip plane on which the time increments are to be
%  calculated.
%  velocities:      The dislocation velocities calculated
%  limitingDistance:    The minimum permitted distance between two
%  entities.
%  limitingTimeStep:    The minimumpermitted time step.

    %% Extract the dislocation list and extremities
    dislocationList = slipPlane.listDislocations;
    extremities     = slipPlane.extremities;
    numDislocations = size(dislocationList, 1);
    
    %% Allocate the time increment vector
    timeIncrements = zeros(numDislocations,1);
    
    % For the first dislocation
    p0 = extremities(1,:);
    v0 = zeros(1,3);
    p1 = dislocationList(1).position;
    v1 = velocities(1,:);
    p2 = dislocationList(2).position;
    v2 = velocities(2,:);
    timeIncrements(1) = dislocationTimeIncrement(p0, v0, p1, v1, p2, v2, limitingDistance);
    
    % For all intermediate dislocations
    for i=2:(numDislocations-1)
        p0 = dislocationList(i-1).position;
        v0 = velocities(i-1);
        p1 = dislocationList(i).position;
        v1 = velocities(i);
        p2 = dislocationList(i+1).position;
        v2 = velocities(i+1);
        timeIncrements(i) = dislocationTimeIncrement(p0, v0, p1, v1, p2, v2, limitingDistance);
    end
    
    % For the last dislocation
    p0 = dislocationList(numDislocations-1).position;
    v0 = velocities(numDislocations-1,:);
    p1 = dislocationList(numDislocations).position;
    v1 = velocities(numDislocations,:);
    p2 = extremities(2,:);
    v2 = zeros(1,3);
    timeIncrements(numDislocations) = dislocationTimeIncrement(p0, v0, p1, v1, p2, v2, limitingDistance);
    
    globalTimeIncrement = min(timeIncrements);
    if (globalTimeIncrement < limitingTimeStep)
        globalTimeIncrement = limitingTimeStep;
    end

end
