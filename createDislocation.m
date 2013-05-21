function disl = createDislocation (bvec, lvec, pos, mobileFlag)
%% disl = createDislocation (bvec, lvec, pos, mobileFlag)
%  Creates a dislocation structure called disl with the attributes
%  specified as arguments.
%  bvec:        Burgers vector  [1x3]
%  lvec:        Line vector     [1x3]
%  pos:         Position        [1x3]
%  mobileFlag:  Indicates whether the dislocation is sessile of glissile
%  (0/1)

    %% Populate data
    disl.burgers    = bvec;
    disl.line       = lvec;
    disl.position   = pos;
    disl.mobile     = mobileFlag;
    
    %% Calculate rotation matrix
    x = bvec/norm(bvec);
    z = lvec/norm(lvec);
    y = cross (z, x);
    y = y/norm(y);
    
    disl.rotationMatrix = [ x;
                            y;
                            z ];
end
