function slipPlane = readSlipPlane(filename, dislocationListFile, dislocationSourceListFile)
%% slipPlane = readSlipPlane(filename, dislocationListFile, dislocationSourceListFile)
%  Reads the data from the input file whose name is provided in filename.

    %% Initialize variables
    extremities = zeros(2,3);

    %% Read data from the file
    data = dlmread(filename);
    extremities(1,:) = data(1,:);
    extremities(2,:) = data(2,:);
    normalVector = data(3,:);
    position = data(4,:);
    
    clear data;
    
    
    %% Populate data into the slip plane
    slipPlane = createSlipPlane(readDislocationList(dislocationListFile), ...
                                readDislocationSourceList(dislocationSourceListFile), ...
                                normalVector, extremities, position);
    
end
