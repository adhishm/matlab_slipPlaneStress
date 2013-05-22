function plotSlipPlaneStress(stresses, i, j)
%% plotSlipPlaneStress(stresses, i, j)
%  Plots the stresses at different points along a slip plane

    %% Extract data
    numPositions = size(stresses, 1);    
    x = zeros(numPositions, 2);
    
    for k=1:numPositions
        x(k,1) = norm(stresses{k,1});
        x(k,2) = stresses{k,2}(i, j);
    end
    
    figure
    plot(x(:,1), x(:,2), '.b');
end
    