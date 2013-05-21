function slipPlane = createSlipPlane (listDislocations, listDislocationSources, normalVector, extremities, position)
%% slipPlane = createSlipPlane (listDislocations, listDislocationSources, normalVector, extremities, position)
%  Creates a slip plane containing a list of dislocations, dislocations
%  sources. It also contains its own normal vector, extremities defining
%  the grain boundaries, as well as its position along the normal vector of
%  the slip system.
%  Arguments:
%  listDislocations:        List of dislocations. [vector containing
%  dislocation structures]
%  listDislocationSources:  List of dislocation sources. [vector containing
%  dislocation source structures]  
%  normalVector:            Vector denoting normal to the slip plane [1x3]
%  extremities:             Position vectors denoting the stremities of the
%  slip plane. [2x3]
%  position:                Position vector indicating the position of the
%  plane along the normal to the slip system. [1x3]

    %% Populate the slip plane structure
    slipPlane.listDislocations = listDislocations;
    slipPlane.listDislocationSources = listDislocationSources;
    slipPlane.normalVector = normalVector;
    slipPlane.extremities = extremities;
    slipPlane.position = position;
    
    %% Calculate the rotation matrix for the slip plane
    x = slipPlane.extremities(2,:) - slipPlane.extremities(1,:);
    x = x/norm(x);
    
    z = slipPlane.normalVector / norm (slipPlane.normalVector);
    
    y = cross (z, x);   y = y / norm(y);
    
    slipPlane.rotationMatrix = [ x;
                                 y;
                                 z ];

end
