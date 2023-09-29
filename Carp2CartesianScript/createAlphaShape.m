function [oArg] = createAlphaShape(out_compressed)

dispLine() ;
disp 'Generating alphaShape' ;
shp = alphaShape(out_compressed.P,1,'HoleThreshold',.2);
disp 'Done!' ;

disp 'Generating boundary facets...' ;
[tri,xyz] = shp.boundaryFacets() ;
disp 'Done' ;

%trisurf(tri,xyz(:,1),xyz(:,2),xyz(:,3),...
%    'FaceColor','cyan','FaceAlpha',0.3) ;

mx = out_compressed.mx ;
my = out_compressed.my ;
nx = out_compressed.nx ;
ny = out_compressed.ny ;
noTriangles = size(tri, 1) ;
noNodes     = noTriangles*3 ; % three nodes per triangle
noIndices   = noTriangles*6 ; % two index per node
indices     = zeros( noIndices,1 ) ;
for tNo =1:noTriangles 
    for nNo=1:3
        indx = tri(tNo,nNo) ;
        i = xyz(indx,1) ;
        j = xyz(indx,2) ;
        k = xyz(indx,3) ;
        si = mod(k, mx) ;
        sj = floor( k/mx) ;
        I = nx*si+i ;
        J = (my-1-sj)*ny + j ;
        
        indexNo = (tNo-1)*6 + (nNo-1)*2 ;
        indices(indexNo+1) = I ;
        indices(indexNo+2) = J ;
   
    end
end

if(isfield(out_compressed,"alphaCoef"))
%if (exists("out_compressed.alphaCoef"))
    disp("Scaling Shape's alpha")
    shp.Alpha = out_compressed.alphaCoef*shp.Alpha ;
    disp("Done");
end
oArg = out_compressed ;

oArg.alphaShape = shp ;

oArg.boundaryFacets.triangles  = tri ;
oArg.boundaryFacets.xyz        = xyz ;
oArg.boundaryFacets.indices    = indices ;
oArg.boundaryFacets.noTriangles= noTriangles ;
oArg.boundaryFacets.noNodes    = noNodes ;
end
