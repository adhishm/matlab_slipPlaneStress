function dislocationList = readDislocationList (filename)
%% dislocationList = readDislocationList (filename)
%  Reads a dislocation list from a file and creates the list.
%  filename:    Name of the file containing the dislocation list

    %% Read the data
    data = dlmread(filename);
    
    %% Create the dislocation list
    
    % Get number of dislocations
    numDislocations = size(data,1);
    
    % Pre-allocate the structure
    zeroVector = zeros(1,3);
    zeroMatrix = zeros(3,3);
    dislocationList(numDislocations) = struct('burgers', zeroVector, 'line', zeroVector, 'position', zeroVector, 'mobile', 0, 'rotationMatrix', zeroMatrix);
    
    % Populate the dislocation list with data
    for i=1:numDislocations
        bvec = data(i,1:3);
        lvec = data(i,4:6);
        pos  = data(i,7:9);
        mobileFlag = data(i,10);
        dislocationList(i) = createDislocation(bvec, lvec, pos, mobileFlag);
    end
end
