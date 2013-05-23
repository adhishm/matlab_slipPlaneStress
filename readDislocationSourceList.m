function dislocationSourceList = readDislocationSourceList (filename)
%% dislocationSourceList = readDislocationSourceList (filename)
%  Reads a dislocation list from a file and creates the list.
%  filename:    Name of the file containing the dislocation list

    %% Read the data
    data = dlmread(filename);
    
    %% Create the dislocation list
    
    % Get number of dislocations
    numDislocationSources = size(data,1);
    
    % Pre-allocate the structure
    zeroVector = zeros(1,3);
    zeroMatrix = zeros(3,3);
    dislocationSourceList(numDislocationSources) = struct('burgers', zeroVector, 'line', zeroVector, 'position', zeroVector, 'tauc', 0, 'timeSince', 0, 'rotationMatrix', zeroMatrix);
    
    % Populate the dislocation list with data
    for i=1:numDislocationSources
        bvec = data(i,1:3);
        lvec = data(i,4:6);
        pos  = data(i,7:9);
        tauc = data(i,10);
        dislocationSourceList(i) = createDislocationSource(bvec, lvec, pos, tauc);
    end
end
