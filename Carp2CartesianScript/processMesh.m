function [outArg] = processMesh(iArg)
%processMesh Summary of this function goes here
%   Detailed explanation goes here
%tags = [1 2 3 4] ;

disp(sprintf("Loading %s" ,iArg.meshName)) ;
iArg.imesh=load(sprintf("%s.mat",iArg.meshName)).raw ;
disp("Done!")

crds = getTaggedVertices(iArg.imesh,iArg.tags) ;
crds = scaleIntoUnitCube(crds) ;
% get the alpha shape based on the coordinates
dispLine() ;
disp("Calculating the pre alphaShape...");
ev=iArg.ev ;
iArg.shape=alphaShape(crds.x(1:ev:end), crds.y(1:ev:end),crds.z(1:ev:end),"HoleThreshold",iArg.holethreshold) ;
iArg.shape.Alpha = iArg.shape.Alpha*iArg.alphaScale ;

disp("Done") ;

out_compressed = createAndCompressGrid(iArg) ;
%
out_compressed = createAlphaShape(out_compressed) ;
%
out_compressed.filename = iArg.outMeshName ;
writeStructureToDisk(out_compressed) ;

outArg = iArg
end