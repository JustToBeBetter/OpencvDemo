//
//  ViewController.m
//  OpencvDemo
//
//  Created by DBOX on 16/8/29.
//  Copyright © 2016年 DBOX. All rights reserved.
//

#import "ViewController.h"
#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/types_c.h>
#import <opencv2/imgcodecs/ios.h>

@interface ViewController ()
{
    cv::Mat cvImage;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect rect = [UIScreen mainScreen].bounds;
    self.imageView.frame = rect;
    
    UIImage *image = [UIImage imageNamed:@"test"];
    // Convert UIImage * to cv::Mat
    UIImageToMat(image, cvImage);
    if (!cvImage.empty()) {
        //灰度处理
        cv::Mat gray;
        // Convert the image to grayscale;
        cv::cvtColor(cvImage, gray, CV_RGBA2GRAY);
        // Apply Gaussian filter to remove small edges
        cv::GaussianBlur(gray, gray, cv::Size(5,5), 1.2,1.2);
        // Calculate edges with Canny
        cv::Mat edges;
        cv::Canny(gray, edges, 0, 60);
        // Fill image with white color
        cvImage.setTo(cv::Scalar::all(255));
        // Change color on edges
        cvImage.setTo(cv::Scalar(0,128,255,255),edges);
        // Convert cv::Mat to UIImage* and show the resulting image
        self.imageView.image = MatToUIImage(cvImage);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
