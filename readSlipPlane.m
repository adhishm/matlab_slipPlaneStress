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
