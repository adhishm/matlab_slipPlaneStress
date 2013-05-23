function v1 = projectVector (v, p)
%% v1 = projectVector (v, p)
%  Projects the vector v on to the vector p, and returns the result in v1

    pNorm = norm(p);
    
    if (pNorm == 0)
        v1 = v;
        return;
    end
    
    v1 = (dot(v, p)/(pNorm*pNorm)) * p;
end
