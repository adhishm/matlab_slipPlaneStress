function sortedDislocationList = sortDislocations (slipPlane)
%% sortedDislocationList = sortDislocations (slipPlane)
%  This function sorts the dislocations on the slip plane given by the
%  argument slipPlane so that their order of appearance in the dislocation 
%  list matches their order of appearance on the slip plane going from
%  extremity 1 to extremity 2.
%  Arguments:
%  slipPlane:   The slip plane on which the dislocations are to be sorted

    %% Extract the dislocation list and extremities
    dislocationList = slipPlane.listDislocations;
    extremities = slipPlane.extremities;
    
    % Number of dislocations
    numDislocations = size(dislocationList,1);
    
    %% Calculate the distances from the extremities
    distances = zeros(numDislocations);
    for i=1:numDislocations
        p = dislocationList(i).position - extremities(1,:);
        distances(i) = norm(p);
    end
    
    %% Sort the distances in ascending order
    [~, index] = sort(distances, 'ascend');
    
    %% Sort the dislocations in the same order
    sortedDislocationList = dislocationList;    % Pre-allocate
    for i=1:numDislocations
        sortedDislocationList(i) = dislocationList(index(i));
    end
    
end
