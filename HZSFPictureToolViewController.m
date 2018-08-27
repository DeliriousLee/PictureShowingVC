//
//  HZSFPictureToolViewController.m
//  NIM
//
//  Created by DeliriousLee on 2018/3/1.
//  Copyright © 2018年 HzSafer. All rights reserved.
//

#import "HZSFPictureToolViewController.h"

#define MaxScale 4.0
#define MinScale 0.7

@interface HZSFPictureToolViewController()<UIScrollViewDelegate>

@end

@implementation HZSFPictureToolViewController

//使用scrollView本身自带的放大缩小代理
-(void)viewDidLoad{
    [super viewDidLoad];

    [self setViewControllerTitle:@"查看图片"];
    CGFloat imageWidth=_showImage.size.width;
    CGFloat imageHeight=_showImage.size.height;
    
    CGFloat imageRatio=imageWidth/imageHeight;
    

    CGFloat screenWidth=_scrollView.bounds.size.width;
    CGFloat screenHeight=_scrollView.bounds.size.height;
   
    CGFloat screenRadio=screenWidth/screenHeight;
    
    
    
    if(imageWidth>screenWidth||imageHeight>screenHeight){
        if(imageRatio>screenRadio){
            //如果目标图片比显示区域“肥”，以屏幕的宽优先显示
            _showImage=[UIImage ResizeImageWithImage:_showImage andSize:CGSizeMake(screenWidth, screenWidth/imageRatio) Scale:YES];
        }else{
            //如果目标图片比显示区域“瘦”，以屏幕的长优先显示

           _showImage=[UIImage ResizeImageWithImage:_showImage andSize:CGSizeMake(screenHeight*imageRatio, screenHeight) Scale:YES];
        }
    }
    
    _imageView=[[UIImageView alloc]initWithImage:_showImage];

    [_scrollView addSubview:_imageView];

    _scrollView.contentSize=_showImage.size;
    
    _imageView.center=CGPointMake(self.navigationController.navigationBar.center.x, self.view.bounds.size.height/2);//self.view或者scrollview的中心点都不准，用了导航栏的中心点来纠正图片开始往左偏的情况（往左偏，大概是采用缩放的时候使用了setRecMake函数）
    
    _scrollView.delegate= self;
    
    _scrollView.maximumZoomScale=MaxScale;
    
    _scrollView.minimumZoomScale=MinScale;

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
#pragma mark - init
-(instancetype)initWithShowImage:(UIImage*)image{
    self=[super init];
    self.showImage=image;
    return self;
}
#pragma mark - ScrollView Delegate
-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX=(scrollView.bounds.size.width>scrollView.contentSize.width)?(scrollView.bounds.size.width-scrollView.contentSize.width)*0.5:0.0;
    CGFloat offsetY=(scrollView.bounds.size.height>scrollView.contentSize.height)?(scrollView.bounds.size.height-scrollView.contentSize.height)*0.5:0.0;
    _imageView.center=CGPointMake(scrollView.contentSize.width*0.5+offsetX, scrollView.contentSize.height*0.5+offsetY);
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}
#pragma mark - ViewConfig
-(BOOL)prefersStatusBarHidden{
    return YES;
}


@end
