function stressDistribution = slipPlaneStressDistribution (slipPlane, appliedStress, BurgersVector, mu, nu, resolution)
%% stressDistribution = slipPlaneStressDistribution (slipPlane, appliedStress, BurgersVector, mu, nu, resolution)
%  Returns the stress distribution on the slip plane in a cell called
%  stressDistribution. This cell contains three columns. The first column
%  contains the point at which the stress is being calculated. The second
%  and third columns contain the stress expressed in the slip plane's local
%  and global co-ordinate systems respectively.
%  Arguments:
%  slipPlane:       The slip plane on which the stress distribution is to
%  be calculated.
%  appliedStress:   The externally applied stress (expressed in the global
%  co-ordinate system)
%  BurgersVector:   Magnitude of the Burgers vector (m)
%  mu:              Shear modulus (Pa)
%  nu:              Poisson's ratio (dimensionless)
%  resolution:      Number of points on the slip plane. 

    %% Create the unit segment which will determine the points at which the
    %  stress will be calculated
    unitSegment = (slipPlane.extremities(2,:) - slipPlane.extremities(1,:))/resolution;
    
    %% Initialize the cell and other variables
    stressDistribution = cell(resolution+1, 3);
    nDislocations = length(slipPlane.listDislocations);
    
    %% Calculate the stress distributions
    for i=0:resolution
        pos = slipPlane.extremities(1,:) + (i*unitSegment);
        stressGlobal = appliedStress;
        for j=1:nDislocations
            stressGlobal = stressGlobal + dislocationStressField(slipPlane.listDislocations(j), pos, BurgersVector, mu, nu);
        end
        
        stressLocal = (slipPlane.rotationMatrix) * stressGlobal * (slipPlane.rotationMatrix)';
        
        stressDistribution{i,1} = pos;
        stressDistribution{i,2} = stressLocal;
        stressDistribution{i,3} = stressGlobal;
    end
end
