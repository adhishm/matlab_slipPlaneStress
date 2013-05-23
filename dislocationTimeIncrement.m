function dt = dislocationTimeIncrement(p0, v0, p1, v1, p2, v2, L)
%% dt = dislocationTimeIncrement(p0, v0, p1, v1, p2, v2, L)
%  Calculates the ideal time increment for a dislocation depending on the
%  movement of its neighbours.
%  Arguments:
%  p0:  Position of previous neighbour.
%  v0:  Velocity of previous neighbour.
%  p1:  Position of the dislocation.
%  v1:  Velocity of the dislocation.
%  p2:  Position of next neighbour.
%  v2:  Velocity of next neighbour.
%  L:   Limiting distance of approach.

    %% Time increment for 01
    t01 = dislocationPairTimeIncrement(p0, v0, p1, v1, L);
    
    %% Time increment for 02
    t21 = dislocationPairTimeIncrement(p2, v2, p1, v1, L);

    dt = min(t01, t21);

end
