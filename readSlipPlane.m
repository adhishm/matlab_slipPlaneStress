function slipPlane = readSlipPlane(filename)
%% slipPlane = readSlipPlane(filename)
%  Reads the data from the input file whose name is provided in filename.

    %% Initialize variables
    extremities = zeros(2,3);
    normalVector = zeros(1,3);
    position = zeros(1,3);

    %% Read data from the file
    fp = fopen(filename, 'r');
    fscanf(fp, 'Dislocation list file: %s\n', dislocationListFile);
    fscanf(fp, 'Dislocation source list file: %s\n', dislocationSourceListFile);
    fscanf(fp, 'Extremities: %f %f %f %f %f %f\n', ...
        [ extremities(1,1), extremities(1,2), extremities(1,3), ...
          extremities(2,1), extremities(2,2), extremities(2,3) ] );
    fscanf(fp, 'Normal vector: %f %f %f\n', ...
         [ normalVector(1), normalVector(2), normalVector(3) ] );
    fscanf(fp, 'Position: %f %f %f', ...
         [ position(1), position(2), position(3) ] );
    fclose(fp);
    
    %% Populate data into the slip plane
    slipPlane = createSlipPlane(readDislocationList(dislocationListFile), ...
                                readDislocationSourceList(dislocationSourceListFile), ...
                                normalVector, extremities, position);
    
end
