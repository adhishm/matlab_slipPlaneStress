function dislSource = createDislocationSource (bvec, lvec, pos, tauc)
%% disl = createDislocationSource (bvec, lvec, pos, tauc)
%  Creates a dislocation structure called disl with the attributes
%  specified as arguments.
%  bvec:    Burgers vector  [1x3]
%  lvec:    Line vector     [1x3]
%  pos:     Position        [1x3]
%  tauc:    Critical stress value for nucleating a dipole

    %% Populate data
    dislSource.burgers   = bvec;
    dislSource.line      = lvec;
    dislSource.position  = pos;
    dislSource.tauc      = tauc;
    dislSource.timeSince = 0;   % Number of iterations that the source has been experiencing shear stresses greater than tauc
    
    %% Calculate rotation matrix
    x = bvec/norm(bvec);
    z = lvec/norm(lvec);
    y = cross (z, x);
    y = y/norm(y);
    
    dislSource.rotationMatrix = [ x;
                            y;
                            z ];
end
