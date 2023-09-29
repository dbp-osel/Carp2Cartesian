clear ;
clc ;

input_info.mesh = '01-350um' ;

% Make sure proc files are generated:
% $>> processMesh meshName -p
imesh = loadCarp(input_info) ;
%%
save("01-350.mat");

%% get left and right ventricle crds
tags = [1 2] ;
crds = getTaggedVertices(imesh,tags) ;
crds = scaleIntoUnitCube(crds) ;
%% get the alpha shape based on the coordinates
dispLine() ;
disp("Calculating the pre alphaShape...");
ev=10 ;
iArg.shape=alphaShape(crds.x(1:ev:end), crds.y(1:ev:end),crds.z(1:ev:end),"HoleThreshold",0.4) ;
iArg.shape.alpha = iArg.shape.alpha*3. ;

disp("Done") ;


plot(iArg.shape);

%%
% max currently is 300
iArg.nx = 256 ;
iArg.ny = 256 ;
iArg.nz = 256 ;
iArg.mx = 16 ;
iArg.my = iArg.nz/iArg.mx ;

out_compressed = createAndCompressGrid(iArg) ;
%
out_compressed = createAlphaShape(out_compressed) ;
%
out_compressed.filename = sprintf("%s-%d-%d-%d",input_info.mesh,iArg.nx,iArg.ny,iArg.nz) ;
writeStructureToDisk(out_compressed) ;

 