function drawSimulation (figureHandle, slipPlane, totalTime)
%% drawSimulation (figureHandle, slipPlane, totalTime)
%  Draws the simulation state.

    %% Extract plot data
    extremities = slipPlane.extremities;
    dislocationList = slipPlane.listDislocations;
    numDislocations = size(dislocationList, 2);
    dislocationPositions = zeros(numDislocations, 3);
    for i=1:numDislocations
        dislocationPositions(i,:) = dislocationList(i).position;
    end
    
    %% Initialize the figure
    figure(figureHandle);
    
    %% Draw the slip plane
    plot3(extremities(:,1),extremities(:,2),extremities(:,3),'-r');
    
    hold on
    
    %% Draw dislocations
    plot3(dislocationPositions(:,1), dislocationPositions(:,2), dislocationPositions(:,3), 'xk');
    
    %% Place time marker
    timeString = ['Total time = ' num2str(totalTime)];
    text(extremities(2,1), extremities(2,2), 0, timeString);
    
    hold off
    axis normal
    
end
