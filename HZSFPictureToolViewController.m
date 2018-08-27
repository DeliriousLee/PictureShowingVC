//
//  HZSFPictureToolViewController.m
//  NIM
//
//  Created by DeliriousLee on 2018/3/1.
//  Copyright © 2018年 HzSafer. All rights reserved.
//

#import "HZSFPictureToolViewController.h"
#import "UINavigationController+NTESNavbarShadow.h"
#import "UIImage+HZSFImageCompressTool.h"
#import "UIViewController+HZSFSetTitle.h"
#define MaxScale 4.0
#define MinScale 0.7

@interface HZSFPictureToolViewController()<UIScrollViewDelegate>
//@property(nonatomic,assign) CGFloat totalScale;
@property(nonatomic,strong)UILabel *Naviitem;
@property(nonatomic,strong)UITapGestureRecognizer *clicked;
@end

@implementation HZSFPictureToolViewController
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//}
//使用scrollView本身自带的放大缩小代理
-(void)viewDidLoad{
    [super viewDidLoad];
//    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,56, _showImage.size.width, _showImage.size.height)];

//    [self.view addSubview:_scrollView];
    [self setViewControllerTitle:@"查看图片"];
    CGFloat imageWidth=_showImage.size.width;
    CGFloat imageHeight=_showImage.size.height;
    
    CGFloat imageRatio=imageWidth/imageHeight;
    
//    CGFloat screenWidth=_scrollView.frame.size.width;
//    CGFloat screenHeight=_scrollView.frame.size.height;
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
    
//    _imageView.center=CGPointMake(self.navigationController.navigationBar.center.x, self.view.center.y);//self.view或者scrollview的中心点都不准，用了导航栏的中心点来纠正图片开始往左偏的情况（往左偏，大概是采用缩放的时候使用了setRecMake函数）
//    _imageView.center=CGPointMake(self.navigationController.navigationBar.center.x, [UIScreen mainScreen].bounds.size.height/2);//self.view或者scrollview的中心点都不准，用了导航栏的中心点来纠正图片开始往左偏的情况（往左偏，大概是采用缩放的时候使用了setRecMake函数）
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



//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    _imageView=[[UIImageView alloc]init];
//
//    [_imageView setMultipleTouchEnabled:YES];
//
//    [_imageView setUserInteractionEnabled:YES];
//
//    [_imageView setImage:_showImage];
//
//
//
//
//    self.totalScale=1.0;
//
//    [self addGestureRecognizerToView:_imageView];
//
//    [self.view addSubview:_imageView];
//
//    CGFloat width=_showImage.size.width;
//    CGFloat height=_showImage.size.height;
//
//    while (_imageView.frame.size.height>self.view.frame.size.height||_imageView.frame.size.width>self.view.frame.size.width) {
//
//        [_imageView setFrame:CGRectMake((self.view.frame.size.width-_imageView.frame.size.width)/2, (self.view.frame.size.height-_imageView.frame.size.height)/2, width/2, height/2)];
//        width=width/2;
//        height=height/2;
//    }
////    [_imageView setFrame:CGRectMake((self.view.frame.size.width-_showImage.size.width)/2, (self.view.frame.size.height-_showImage.size.height)/2, _showImage.size.width, _showImage.size.height)];
//}
//// 添加所有的手势
//
//
//-(void) addGestureRecognizerToView:(UIView *)view
//
//{
//
//    // 旋转手势
//
//    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
//
//    [view addGestureRecognizer:rotationGestureRecognizer];
//
//    // 缩放手势
//
//    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
//
//    [view addGestureRecognizer:pinchGestureRecognizer];
//
//    // 移动手势
//
//    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
//
//    [view addGestureRecognizer:panGestureRecognizer];
//
//    }
//
//// 处理旋转手势
//-(void)rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer{
//
//    UIView *view = rotationGestureRecognizer.view;
//
//    if(rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged)
//
//    {
//
//        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
//
//        [rotationGestureRecognizer setRotation:0];
//
//        }
//
//}
//
//
//// 处理拖拉手势
//
//-(void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
//
//{
//
//    UIView *view = panGestureRecognizer.view;
//
//    if(panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged)
//
//        {
//
//            CGPoint translation = [panGestureRecognizer translationInView:view.superview];
//
//            [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
//
//            [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
//
//        }
//
//    }
//
//
//
//
//
//
//
//// 处理缩放手势
//-(void)pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
//
//    CGFloat scale=pinchGestureRecognizer.scale;
//    if(scale >1.0){
//        if(_totalScale>MaxScale){
//            return;
//        }
//    }
//    if(scale <1.0){
//        if(_totalScale<MinScale){
//            return;
//        }
//    }
//    self.imageView.transform=CGAffineTransformScale(self.imageView.transform, scale, scale);
//    self.totalScale *=scale;
//    pinchGestureRecognizer.scale=1.0;
//
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}


@end
