% Clear the workspace and command window
clc
clear

%% Include necessary paths
% Add paths to the required functions and modules
addpath InitFunction
addpath ServiceFunction
addpath Control
addpath Command
addpath PostProcess
addpath StepFunction
addpath Movie_function

%% Load command information from IRIS planning
% Set the path to the IRIS build folder and result path and the desired OutputSimulationPath
IRIS_build_folder = '\\wsl.localhost\Ubuntu\home\davidalpert11\Projects\IRIS-UU\build';
Result_path = 'Results\test\';
file_to_write = 'testIRIS';
OutputSimulationPath = 'OutputSimulation';

OutputIRISFolderName = [IRIS_build_folder,'\',Result_path];

% Initialize command
Command = InitCommand(file_to_write,OutputIRISFolderName);

%% Run the simulation
% Execute the main simulation function with the provided command
mainUAVsimulation(Command,OutputSimulationPath);

%% Check Points of Interest (POI) and Collision
% Load the simulation results from the specified path
load([OutputSimulationPath,'\UAVSimulationResults']);

% Define the result path for simulation vertices
Result_path_simulation_vertex_relative_to_build = [Result_path,'SimulationPath_',file_to_write];
Result_path_simulation_vertex = [IRIS_build_folder,'\',Result_path_simulation_vertex_relative_to_build];

% Write the simulation results to a file
fileName = fopen(Result_path_simulation_vertex,'w');
fprintf(fileName, '%f %f %f %f %f\n', PoseUpdateTheta');
fclose(fileName);

% Call the PowerShell script to check POI and collision
seed = num2str(2);
CommandToPowershell = ['powershell cd ',IRIS_build_folder,'; wsl '];
system([CommandToPowershell,'./app/checkPOIandCollision_simulator ',strrep(Result_path_simulation_vertex_relative_to_build, '\', '/'),' ',seed]);

%% Create a video
% Define paths and filenames for video creation
obj_path = '\\wsl.localhost\Ubuntu\home\davidalpert11\Projects\IRIS-UU\data\bridge\bridge.obj';
output_record_path_simulation = 'OutputSimulation';
output_iris ='\\wsl.localhost\Ubuntu\home\davidalpert11\Projects\IRIS-UU\build\Results\test';
nameOfVideoFile = 'Movies\test_video';

% Call the Movie function to create the video
Movie(nameOfVideoFile,obj_path,output_record_path_simulation,output_iris);