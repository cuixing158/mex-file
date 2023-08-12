function outImg = imread_opencv(imagePath)%#codegen
% Brief: Write a function imreadOpencv that calls the external library function.
% Details:
%    Read a uint8 image of size 480*640
%
% Syntax:
%     outImg = imread_opencv(imagePath)
%
% Inputs:
%    imagePath - [1,1] size,[string] type,image path
%
% Outputs:
%    outImg - [480,640] size,[uint8] type,Description
%
% codegen command:
%    imagePath = "./test_480x640_uint8.jpg";
%    input1 = coder.typeof(imagePath);
%    input1.StringLength=inf;
%
%    codegen -config:mex imread_opencv -args {input1}  -lang:c++ -report
%
% Usage Example:
%    imagePath = "./test_480x640_uint8.jpg";
%    result = imread_opencv(imagePath);
%
%
% Example:
%    None
%
% See also: None


arguments
    imagePath (1,1) string
end
outImg = OpenCV_API.imread(imagePath);
end