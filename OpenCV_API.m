%================================================================
% This class abstracts the API to an external OpenCV library.
% It implements static methods for updating the build information
% at compile time and build time.

classdef OpenCV_API < coder.ExternalDependency
    %#codegen

    methods (Static)

        function bName = getDescriptiveName(~)
            bName = 'OpenCV_API';
        end

        function tf = isSupportedContext(buildContext)
            myTarget = {'mex','rtw'};% 验证代码生成目标为mex或者dll,lib,exe
            if  buildContext.isCodeGenTarget(myTarget)
                tf = true;
            else
                error('OpenCV_API only supported for mex, lib, exe, dll');
            end

            %             hw = buildContext.getHardwareImplementation();

        end

        function updateBuildInfo(buildInfo, buildContext)
            % 输入buildInfo请参考：RTW.BuildInfo
            % 输入buildContext请参考：coder.BuildConfig class
            %
            % Get file extensions for the current platform
            %             [~, linkLibExt, execLibExt, ~] = buildContext.getStdLibInfo();

            % Code to run on Linux platform
            includeFilePath = fullfile("E:\opencv4_4_0\opencv\MinGW64_v8_OpenCV4_4_Contrib_install\include");
            buildInfo.addIncludePaths(includeFilePath);

            % Link files
            libPath = fullfile("E:\opencv4_4_0\opencv\MinGW64_v8_OpenCV4_4_Contrib_install\x64\mingw\lib");
            linkFiles = "libopencv_world440.dll.a";
            linkPath = libPath;
            linkPriority = "";
            linkPrecompiled = true;
            linkLinkOnly = true;
            group = '';
            buildInfo.addLinkObjects(linkFiles, linkPath, ...
                linkPriority, linkPrecompiled, linkLinkOnly, group);

            % include  and source path
%             buildInfo.addIncludePaths("./");
%             buildInfo.addSourcePaths("./");
        end

        %API for library function 'imread'
        function outImg = imread(imagePath)
            arguments
                imagePath (1,1) string
            end

            outImg = coder.nullcopy(zeros(480,640,3,"uint8"));
            if coder.target('MATLAB')
                % running in MATLAB, use built-in addition
                outImg = imread_opencv_mex(imagePath);
            else
                % Add the required include statements to the generated function code
                coder.cinclude('opencvAPI.h');
                % include external C++ functions
                coder.updateBuildInfo('addSourceFiles', "opencvAPI.cpp");

                % 调用OpenCV C++代码包装器
                imgPath = [char(imagePath),0];
                coder.ceval('imreadOpenCV', coder.rref(imgPath),coder.wref(outImg));
            end
        end
    end
end