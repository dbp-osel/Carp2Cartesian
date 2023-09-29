
% Clear the workspace
clear ;

% Clear the screen
clc ;

% In this script, input arguments are passed through an structure called
% iArg. Various parameters can be set through the iArg fields.

iArg.meshName = "01-350um" ; % Input name of the mesh without the extension
                             % of the file name should be passed as an 
                             % string here.
iArg.outMeshName = "LRV_256x256x256" ; % Output file name without the 
                                       % the file extensions.


iArg.tags = [1 2] ; % Selected tags to create the region that will be 
                    % converted to the Cartesian grid.

iArg.nx = 256 ;     % number of divisions in the x-dirction of the output grid
iArg.ny = iArg.nx ; % number of divisions in the x-dirction of the output grid
iArg.nz = iArg.nx ; % number of divisions in the x-dirction of the output grid

iArg.mx = 16 ;      % Number of z-slices in the horizontal direction of a 
                    % 2D texture that represents the 3D grid.
iArg.my = iArg.nz/iArg.mx ;  % Number of z-slices in the vertical direction 
                    %  of a 2D texture that represents the 3D grid.


iArg.holethreshold = 0.05; % A real number that determines the smallest hole 
% size in the alpha shape. If a hole is smaller than this threshold, 
% it will be suppressed.

iArg.ev = 5 ; % An integer `[n]` to choose every `n`th grid point to create 
% the alpha shape. When the mesh is really refined, downsampling can speed 
% up the process of creating the alpha shape.

iArg.alphaScale = 2. ; % the number to multiply the calculated Alpha of the 
% pre alpha shape to re-adjust the alpha radius of the alpha shape. The
% larger this number is the more smoothing will be applied to the
% boundaries of the alpha shape.

oArg = processMesh(iArg) ; % process the input mesh by importing and
% loading the mesh, filtering the selected tags, preparing the pre-alpha
% shape, creating the converted mesh, compressing the converted mesh, and
% saving the converted mesh to the disk.



 