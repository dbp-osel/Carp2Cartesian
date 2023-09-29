function [output_info] =loadCarp(input_info)
% loadCarp (input_info)
% input_info.mesh : string representing the mesh-name
% 
% ouput_info
%       .crds
%           .noPoints  : no of points/vertices
%           .xyz       : x,y,z coordinate of vertices
%           .x         : x-coordinate of vertices
%           .y         : y-coordinate of vertices
%           .z         : z-coordinate of vertices
%       .elems
%           .noElems   : number of tetrahedral elements
%           .cnn      : connectivity matrix [noElems x 4]
%           .tag       : array of element tags to distinguish between
%                        elements


meshName = input_info.mesh ;
dispLine() ;
disp(sprintf("Starting to import the mesh %s",meshName)) ;

disp(sprintf("Reading the point file %s.pts",meshName)) ;
pointFileName = sprintf("%s.pts",meshName) ;
% OPEN THE FILE -----------------------------------------------------------
fid=fopen(pointFileName,'r') ;

% READ NUMBER OF POINTS ---------------------------------------------------
noPoints = fscanf(fid,"%d",1) ;

% READ 3 COORDINATE PER POINT ---------------------------------------------
ocrd =fscanf(fid,"%f",3*noPoints);

% CLOSE THE FILE ----------------------------------------------------------
fclose(fid) ;

disp("Done!") ;

% RESHAPE THE IMPORTED COORDINATES ----------------------------------------
crds = reshape(ocrd,3,noPoints)' ;

% EXTRACT X,Y,Z COORDINATES -----------------------------------------------
crd.noPoints = noPoints ;
crd.xyz = crds ;
crd.x = crds(:,1) ;
crd.y = crds(:,2) ;
crd.z = crds(:,3) ;

% exporting the coordinate info
output_info.crds = crd ;

% READING ELEMENTS ========================================================
elemFileName = sprintf("%s.elem",meshName) ;

disp(sprintf("Reading elem file %s",elemFileName));

fid = fopen(elemFileName,'r') ;
noElems = fscanf(fid,"%d") ;
fclose(fid) ;
disp("Done!") ;


elemFileName = sprintf("%s.elem.proc",meshName) ;
disp(sprintf("Reading proc file file %s",elemFileName));

fid = fopen(elemFileName,'r') ;
elemsRaw = fscanf(fid,"%d",noElems*5) ;
fclose(fid) ;

disp("Done!") ;

disp("Processing elements...")
elemsProc = reshape(elemsRaw,5,noElems)' ;

% exporting the elems info
output_info.elems.noElems = noElems ;
output_info.elems.cnn = elemsProc(:,1:4)+1 ;
output_info.elems.tag = elemsProc(:,5) ;
disp("Done!");
end