function [crds]=getTaggedVertices(imesh,tags)
% [crds]=getTaggedVertices(imsh,tags):
% get the crds of vertices that match the tags listed.
% 
% imsh: is the output of mesh conversion script
% tags: is a vector of tags that we want to use to get the vertices that
% have that tag
%
% crds
%   .noPoints   : number of vertices matching the tags
%   .xyz        : xyz-coordinate of vertices of the vertices matching the
%                 tags
%   .x          : x-coordinates
%   .y          : y-coordinates
%   .z          : z-coordinates

dispLine();
disp("Getting tagged vertices") ;
taggedIndices = zeros(imesh.crds.noPoints,1) ;
tagged = (imesh.elems.tag == tags(1)) ;
for i=2:size(tags,2)
    tagged = tagged | (imesh.elems.tag == tags(i)) ;
end
taggedIndices(imesh.elems.cnn(tagged,:)) = 1;
taggedIndices = (taggedIndices==1) ;

% export the information required
crds.noPoints = sum(taggedIndices) ;
crds.xyz = imesh.crds.xyz(taggedIndices,:) ;
crds.x = imesh.crds.x(taggedIndices) ;
crds.y = imesh.crds.y(taggedIndices) ;
crds.z = imesh.crds.z(taggedIndices) ;
disp("Done!") ;
end