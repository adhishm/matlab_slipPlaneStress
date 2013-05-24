function slipPlane = readSlipPlane(filename)
%% slipPlane = readSlipPlane(filename)
%  Reads the data from the input file whose name is provided in filename.
%
%  The data is returned in the vector of structure called slipPlane. Each
%  member of this vector contains a list of dislocations and a list of
%  dislocation sources.
%
%  The input file contains the number of slip planes in the first row
%  followed by zeros to fill in the space (total 12 columns).
%
%  The next row contains details of the first slip plane, beginning with
%  the number 1 in the first column to indicate that this is a slip plane.
%  The following columns contain:
%  - 3 numbers for the position of extremity 1
%  - 3 numbers for the position of extremity 2
%  - 3 numbers for the normal vector (since this is a cubic system, these
%  indices represent the indices of the plane)
%  - 1 number indicating the number of dislocations on this plane
%  - 1 number indicating the number of dislocation sources
%
%  Following this row, there appear the number of rows equal to the number
%  of dislocations. Each dislocation row contains the following columns:
%  - The digit 2 indicating that this is a dislocation
%  - 3 numbers for the position
%  - 3 numbers for the Burgers vector
%  - 3 numbers for the line vector
%  - 1 number (0/1) to indicate a seesile or glissile dislocation
%  respectively
%  - 0 to fill in the remaining column (there must be 12 columns in each
%  row)
%
%  After the dislocations, now the dislocation sources have to be
%  specified. This is done in the following rows, of which there is a
%  number equal to the number of dislocations sources cited for the current
%  slip plane. The columns contain the following information:
%  - The digit 3 indicating that this is a dislocation source
%  - 3 numbers for the position
%  - 3 numbers for the Burgers vector
%  - 3 numbers for the line vector
%  - 1 number for the critical shear stress for the emission of a dipole
%  - 0 to fill in the remaining column
%
%  After this the data for the next slip plane begins, and so on for the
%  number of slip planes indicated in the beginning of the file.
%

    %% Read in all data from the input file
    fileData = dlmread(filename);
    
    %% Set the counter for the position in the file
    counter = 1;

    %% Get the number of slip planes
    nSlipPlanes = fileData(counter, 1); counter = counter + 1;
    
    %% Allocate structure for slip planes
    zeroVector = zeros(1,3);
    zeroMatrix = zeros(3,3);
    slipPlane(nSlipPlanes) = struct('listDislocations', createDislocation(zeroVector, zeroVector, zeroVector, 0), ...
                                    'listDislocationSources', createDislocationSource(zeroVector, zeroVector, zeroVector, 0), ...
                                    'normalVector', zeroVector, ...
                                    'extremities', [zeroVector;
                                                    zeroVector ], ...
                                    'position', zeroVector, ...
                                    'rotationMatrix', zeroMatrix );
	%% Start iterating for the slip planes
    for countSlipPlanes=1:nSlipPlanes
        entityType = fileData(counter, 1);
        if (entityType ~= 1)
            % This is not a slip plane. Must quit reading now.
            return
        end
        
        % Get other information
        slipPlane(countSlipPlanes).extremities(1,:) = [ fileData(counter, 2:4);
                                                        fileData(counter, 5:7) ];
        slipPlane(countSlipPlanes).normalVector = fileData(counter, 8:10);
        nDislocations = fileData(counter, 11);
        nSources = fileData(counter, 12);
        
        counter = counter + 1;
        
        %% Iterate for the dislocations
        % Pre-allocate space
        listDislocations(nDislocations) = struct('burgers', zeroVector, ...
                                                 'line', zeroVector, ...
                                                 'position', zeroVector, ...
                                                 'mobile', 0, ...
                                                 'rotationMatrix', zeroMatrix);
        for countDislocations=1:nDislocations
            entityType = fileData(counter, 1);
            if (entityType ~= 2)
                % This is not a dislocation. Must quit now.
                return
            end
            
            % Get other information
            listDislocations(countDislocations).burgers = fileData(counter, 2:4);
            
            
        end
        
        slipPlane(countSlipPlanes).listDislocations = listDislocations;
        
    end
    
    
end
