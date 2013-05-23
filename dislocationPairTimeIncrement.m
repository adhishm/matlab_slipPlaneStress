function t01 = dislocationPairTimeIncrement(p0, v0, p1, v1, L)
%% t01 = dislocationPairTimeIncrement(p0, v0, p1, v1, L)
%  Returns the ideal time increment for a pair of objects such that they do
%  not collide, and approach to a distance of not less than L.
%  p0:  Position of the first object.
%  v0:  Velocity of the first object.
%  p1:  Position of the second object.
%  v1:  Velocity of the second object.
%  L:   Limiting distance of approach.

    %% Find out if the velocities are parallel or anti-parallel
    cosine_v01 = dot(v0, v1)/( norm(v0) * norm(v1) );
    if (cosine_v01 <= 0)
        % The points are moving away from each other. So any large time
        % increment will do.
        t01 = 1000;
    else
        % The points are moving toward each other.
        
        %Find out which one is larger
        if (norm(v0) > norm(v1))
            % The other point is moving away faster. So any large time
            % increment will do.
            t01 = 1000;
        else
            % The points are approaching each other.
            t01 = ( norm(p0-p1) - L )/( norm(v0-v1) );
        end
    end
end
