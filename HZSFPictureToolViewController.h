//
//  HZSFPictureToolViewController.h
//  Created by DeliriousLee on 2018/3/1.
//  Copyright © 2018年 HzSafer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZSFPictureToolViewController : UIViewController
@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UIImage *showImage;
@property (strong,nonatomic)IBOutlet  UIScrollView *scrollView;
-(instancetype)initWithShowImage:(UIImage*)image;
@end
