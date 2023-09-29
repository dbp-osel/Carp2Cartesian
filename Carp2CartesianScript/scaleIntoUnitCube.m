function [ncrds]=scaleIntoUnitCube(ocrds)
% [ncrds]=scaleIntoUnitCube(ocrds)
% scales the coordinates from 0 to 1. subsequently retuns the length of
% each dimension of the domain.
dispLine() ;
disp("Scaling coordinates into a unit cube from 0-1...") ;
minCrds = min(ocrds.xyz) ;
maxCrds = max(ocrds.xyz) ;

geoLength = (maxCrds-minCrds) ;
maxLength = max(geoLength);

xyz = ocrds.xyz-minCrds ;
xyz = xyz/maxLength ;

ncrds.noPoints = ocrds.noPoints ;
ncrds.xyz = xyz ;
ncrds.x   = xyz(:,1) ;
ncrds.y   = xyz(:,2) ;
ncrds.z   = xyz(:,3) ;
ncrds.length = geoLength ;
disp("Done!") ;
end