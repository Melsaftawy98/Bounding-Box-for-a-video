function BW = SegmentTurkeyv4(X)
%segmentImage Segment image using auto-generated code from imageSegmenter app
%  [BW,MASKEDIMAGE] = segmentImage(X) segments image X using auto-generated
%  code from the imageSegmenter app. The final segmentation is returned in
%  BW, and a masked image is returned in MASKEDIMAGE.

% Auto-generated by imageSegmenter app on 29-Jun-2022
%----------------------------------------------------

X = im2gray(X);
% Adjust data to span data range.
X = imadjust(X);

% Threshold image - adaptive threshold
BW = imbinarize(X, 'adaptive', 'Sensitivity', 0.000000, 'ForegroundPolarity', 'bright');

% Erode mask with rectangle
dimensions = [8 9];
se = strel('rectangle', dimensions);
BW = imerode(BW, se);

% Clear borders
BW = imclearborder(BW);

% Flood fill
row = 560;
column = 594;
tolerance = 5.000000e-02;
weightImage = graydiffweight(X, column, row, 'GrayDifferenceCutoff', tolerance);
addedRegion = imsegfmm(weightImage, column, row, 0.01);
BW = BW | addedRegion;

% Erode mask with disk
radius = 9;
decomposition = 0;
se = strel('disk', radius, decomposition);
BW = imerode(BW, se);

% Fill holes
BW = imfill(BW, 'holes');

% Dilate mask with disk
radius = 19;
decomposition = 0;
se = strel('disk', radius, decomposition);
BW = imdilate(BW, se);

% Create masked image.
maskedImage = X;
maskedImage(~BW) = 0;
end

