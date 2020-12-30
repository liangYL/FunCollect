//
//  XYZPhoto.h
//  demo6_PhotoRiver
//
//  Created by BOBO on 15/3/23.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZDrawView.h"

typedef NS_ENUM(NSInteger, XYZPhotoState) {
    XYZPhotoStateNormal,
    XYZPhotoStateBig,
    XYZPhotoStateDraw,
    XYZPhotoStateTogether
};

@interface XYZPhoto : UIView
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) XYZDrawView *drawView;
@property (nonatomic,assign) CGFloat speed;
@property (nonatomic,assign) CGRect oldFrame;
@property (nonatomic,assign) CGFloat oldSpeed;
@property (nonatomic,assign) CGFloat oldAlpha;
@property (nonatomic,assign) NSInteger state;

- (void)updateImage:(UIImage *)image;
- (void)setImageAlphaAndSpeedAndSize:(CGFloat)alpha;
@end
