%% Initialize data for the simulation
%  This script file initializes certain variables for the simulation and
%  reads input data such as material properties and dislocation positions.

%% Material properties
mu = 1.0e+09;               % Shear modulus, Pa
nu = 0.33;                  % Poisson's ratio, dimensionless
BurgersVector = 5.0e-09;    % Burgers vector, m
dragCoefficient = 1.0e09;   % Drag coefficient, kg/s
dipoleEmissionStress = 1.0e10;  % Critical shear stress for dipole emission, Pa

%% Input data
slipPlaneDataFile = 'slipPlane.txt';

%% Simulation parameters
% Minumum time step, s
limitingTimeStep = 1.0e-12;

% The minimum distance that one dislocation can approach another
limitingApproachDistance = 2.0*BurgersVector;

% Resolution for calculating slip plane stress distribution
% Number of points at which it will be calculated
slipPlaneStressResolution = 100;

% Number of turns to experience a stress greater than tau_critical till a
% dislocation source emits a dipole
turnsTillDipoleEmission = 10;

% stopping criterion
stoppingCriterion = 0;  % 0: number of steps; 1: time
limitingSteps = 1000;   % Limiting number of iterations
limitingTime = 1.0;     % Limiting time, s

%% Load
appliedStress = 1.0e+09 * [  1  0  0;
                             0  0  0;
                             0  0 -1 ]; % Applied stress, Pa
