#ifndef EYE_CENTER_H
#define EYE_CENTER_H

#include "opencv2/imgproc/imgproc.hpp"

cv::Point2d findEyeCenter(cv::Mat face, cv::Rect eye, std::string debugWindow);

#endif