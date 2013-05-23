function force = forcePeachKoehler (stress, disl, BurgersVector)
%% force = forcePeachKoehler (stress, disl, BurgersVector)
%  This function calculates the force vector representing the Peach-Koehler
%  force on an edge dislocation using the arguments provided.
%  stress:  The stress tensor represented in the global co-ordinate system
%  disl:    The dislocation for which the force is to be calculated
%  BurgersVector: Magnitude of the Burgers vector (in m)

    %% Rotate the stress to the local co-ordinate system
%    stressLocal = (disl.rotationMatrix) * (stress) * (disl.rotationMatrix)';
    
%     %% Calculate the Peach-Koehler force in the local co-ordinate system
%     f_PKLocal = BurgersVector * stressLocal * [0; -1; 0];
%     
%     %% Rotate the force back to the global co-ordinate system
%     force = (disl.rotationMatrix)' * f_PKLocal;

    force = BurgersVector * stress * (cross(disl.burgers, disl.line))';
    
end
