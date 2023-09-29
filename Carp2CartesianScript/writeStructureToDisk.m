function [strct] = writeStructureToDisk(output_info)
strct.nx                    = output_info.nx ;
strct.ny                    = output_info.ny ;
strct.mx                    = output_info.mx ;
strct.my                    = output_info.my ;
%strct.threshold             = output_info.threshold ;
strct.full_width            = output_info.full_width ;
strct.full_height           = output_info.full_height ;
strct.comp_width            = output_info.comp_width ;
strct.comp_height           = output_info.comp_height ;
strct.fullTexelIndex        = output_info.fullTexelIndex ;
strct.compressedTexelIndex  = output_info.compressedTexelIndex ;

bf = output_info.boundaryFacets ;
strct.boundaryFacets.noTriangles = bf.noTriangles ;
strct.boundaryFacets.noNodes     = bf.noNodes ;
strct.boundaryFacets.indices     = bf.indices ;

disp( sprintf('Creating the %s.json file...', output_info.filename)) ;
strct_json = jsonencode(strct);

fid = fopen(sprintf("%s.json",output_info.filename),'w') ;
fprintf(fid, strct_json);
fclose(fid);
disp('Done!') ;

disp( sprintf('Creating the %s.png file...', output_info.filename)) ;
imwrite(output_info.flatMatrix',sprintf("%s.png",output_info.filename));

disp('Done!') ;
end
