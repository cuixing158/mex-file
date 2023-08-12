#include "opencvAPI.h"

// 对应OpenCV的cv::Mat转MATLAB uint8类型或logical图像
void convertCVToMatrix(cv::Mat &srcImg, int rows, int cols, int channels, unsigned char dst[]) {
    CV_Assert(srcImg.type() == CV_8UC1 || srcImg.type() == CV_8UC3);
    size_t elems = rows * cols;
    if (channels == 3) {
        cv::Mat channels[3];
        cv::split(srcImg.t(), channels);

        memcpy(dst, channels[2].data, elems * sizeof(unsigned char));              //copy channel[2] to the red channel
        memcpy(dst + elems, channels[1].data, elems * sizeof(unsigned char));      // green
        memcpy(dst + 2 * elems, channels[0].data, elems * sizeof(unsigned char));  // blue
    } else {
        srcImg = srcImg.t();
        memcpy(dst, srcImg.data, elems * sizeof(unsigned char));
    }
}


void imreadOpenCV(const char *imagePath, unsigned char outImg[]) {
    std::string imgPath(imagePath);
    cv::Mat srcImg = cv::imread(imgPath, cv::IMREAD_COLOR);
    if (srcImg.empty()) {
        std::runtime_error("read image is empty!");
    }

    convertCVToMatrix(srcImg, srcImg.rows, srcImg.cols, srcImg.channels(), outImg);
}
