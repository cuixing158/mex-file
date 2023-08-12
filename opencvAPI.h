
#ifndef _OPENCVAPI_ALLPLATFORM_
#define _OPENCVAPI_ALLPLATFORM_

// base
#include <iostream>
#include <string>
#include <fstream>
#include <vector>

// OpenCV
#include <opencv2/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/imgproc.hpp>


// "marshalling"
void convertCVToMatrix(cv::Mat &srcImg, int rows, int cols, int channels, unsigned char dst[]);

void imreadOpenCV(const char *imagePath, unsigned char outImg[]);

#endif