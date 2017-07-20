//
//  ViewController.m
//  灰度处理shi
//
//  Created by 静东 on 17/7/10.
//  Copyright © 2017年 沸腾医疗. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIImageView *image1;
    UIImageView *image2;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (!image1) {
        image1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100,(self.view.frame.size.width-20)/2, 400)];
    }
    image1.contentMode = UIViewContentModeScaleAspectFit;
    image1.image = [UIImage imageNamed:@"temp.jpg"];
    [self.view addSubview:image1];
    
    
    if (!image2) {
        image2 = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-20)/2+20, 100,(self.view.frame.size.width-20)/2, 400)];
    }
    image2.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:image2];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 500, (self.view.frame.size.width-20)/2, 40)];
    [btn setTitle:@"灰度转换" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(handleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
   
}
- (void)handleBtnAction
{
    image2.image = [self covertToGrayImageFromImage:image1.image];
}




- (UIImage *)covertToGrayImageFromImage:(UIImage*)sourceImage
{
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), sourceImage.CGImage);
    CGImageRef contextRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:contextRef];
    CGContextRelease(context);
    CGImageRelease(contextRef);
    
    return grayImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
