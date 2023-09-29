function [oArg] =createAndCompressGrid(iArg)


nx = iArg.nx ;
ny = iArg.ny ;
mx = iArg.mx ;
my = iArg.my ;
nz = mx*my ;

iShape = iArg.shape ;

dispLine() ;
disp("Generating the grid...")

% gerating grid 
x = zeros(nx*mx,ny*my) ;
y = zeros(nx*mx,ny*my) ;
z = zeros(nx*mx,ny*my) ;

% discretization size 
ds = [1 1 1]./[nx,ny,nz] ; 
for I=1:(nx*mx)
    for J=1:(ny*my)
        i=mod(I-1,nx) ;
        si=mx-(floor((I-1)/nx)) ;
        j=ny-mod(J-1,ny) ;
        sj=(my-1)-floor((J-1)/ny);
        %i=nx-i;
        %j=ny-j ;
        k=nz-(mx*sj+si);

        x(I,J) = i*ds(1) ;
        y(I,J) = j*ds(2) ;
        z(I,J) = k*ds(3) ;
    end
end
disp("Done") ;
%
disp("Finding the in-tissue vertices...")
flatMatrix = inShape(iShape,x,y,z);

disp("Done!");



disp('Compressing the data structure...') ;

width = iArg.mx*iArg.nx ;
height= iArg.my*iArg.ny ;
noDomainVertices = sum(sum(flatMatrix)) ;

compressedSize = ceil(sqrt(noDomainVertices )) ;

fullTexelIndex          = zeros(compressedSize*compressedSize*4,1) ;
compressedTexelIndex    = zeros(width*height*4,1) ;

% coordinates of domain points
xi = zeros( noDomainVertices, 1) ;
xj = zeros( noDomainVertices, 1) ;
xk = zeros( noDomainVertices, 1) ;

num = 0 ;
for j=1:height
    for i=1:width
        indx = (i-1)+(j-1)*width ;
        
        % notice how the j index in the original flat matrix need to be
        % flipped. This is due to the fact that images are filled from the
        % top to the buttom and if the data matrix need to be filled from
        % buttom to the top this should be carefully applied.
        if ( flatMatrix(i,height+1-j) )
            jj = floor(num/compressedSize) ;
            ii = mod(num,compressedSize) ;
            
            nindx = ii + jj*compressedSize ;
            
            compressedTexelIndex(indx*4+1)=ii ;
            compressedTexelIndex(indx*4+2)=jj ;
            compressedTexelIndex(indx*4+3)=1 ;
            compressedTexelIndex(indx*4+4)=1 ;
            
            fullTexelIndex(nindx*4 + 1) = i-1 ;
            fullTexelIndex(nindx*4 + 2) = j-1 ;
            fullTexelIndex(nindx*4 + 3) = 1 ;
            fullTexelIndex(nindx*4 + 4) = 1 ;
            num = num+1 ;
            
            % coordinate of the compressed point
            xi(num) = mod(i-1, iArg.nx) ;
            si = floor((i-1)/iArg.nx) ;
            xj(num) = mod(j-1, iArg.ny) ;
            sj = (iArg.my-1)-floor((j-1)/iArg.ny);
            xk(num) = si + iArg.mx*sj ;
        end
    end
end

disp('Done!');

%--------------------------------------------------------------------------
P = [ xi xj xk ] ;


%--------------------------------------------------------------------------
oArg                        = iArg ;

oArg.P                      = P ;
%oArg.alphaShape             = shp ;
oArg.full_width             = width ;
oArg.full_height            = height ;
oArg.flatMatrix             = flatMatrix ;
oArg.noDomainVertices       = noDomainVertices ;

oArg.comp_width             = compressedSize ;
oArg.comp_height            = compressedSize ;

oArg.noAboveThreshold       = noDomainVertices ;
oArg.compressedSize         = compressedSize ;

oArg.compressedTexelIndex   = compressedTexelIndex ;
oArg.fullTexelIndex         = fullTexelIndex ;

end