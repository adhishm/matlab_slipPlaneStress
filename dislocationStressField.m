function stress = dislocationStressField (d0, pos, BurgersVector, mu, nu)
%% stress = dislocationStressField (d0, pos, BurgersVector, mu, nu)
%  Returns the stress tensor (in the global co-ordinate system)
%  representing the stress field due to this edge dislocation at the
%  position given by the argument pos.
%  d0:              The dislocation whose stress field is to be calculated
%  pos:             Position at which the stress field is to be calculated
%  BurgersVector:   Magnitude of the Burgerx vector (m)
%  mu:              Shear modulus of the material (Pa)
%  nu:              Poisson's ratio (dimensionless)

    %% Calculate the vector joining the two dislocations
    r = pos - d0.position;
    
    %% Check for sanity (zero norm of vector r)
    if ( norm(r) == 0 )
        % At zero distance the stress value gives a singularity
        % Instead a zero stress matrix is returned
        stress = zeros(3,3);
        return
    end
    
    %% Calculate the stress in the local co-ordinate system
    % Convert the vector r to the local system
    rLocal = d0.rotationMatrix * r;
    
    % Separate the components of the vector
    x = rLocal(0); y = rLocal(1);
    
    % Calculate the constant pre-factor and other terms used repeatedly in
    % the stress tensor
    D = (mu * BurgersVector)/(2.0 * pi * (1.0 - nu));
    p = ( (x*x) + (y*y) )^2;
    q = (x*x) - (y*y);
    
    % Calculate the stress
    stressLocal = (D/p) * [ (-1.0*y*((3*x*x)+(y*y)))    (x*q)   0.0;
                            (x*q)                       (y*q)   0.0;
                            0.0                         0.0     (-nu*y*((2*x*x)+(y*y))) ];
    
    %% Rotate the stress to the global co-ordinate system
    stress = (d0.rotationMatrix)' * stressLocal * (d0.rotationMatrix);

end
