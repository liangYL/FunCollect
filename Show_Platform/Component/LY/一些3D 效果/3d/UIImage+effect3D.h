//
//  UIImage+effect3D.h
//  Show_Platform
//
//  Created by liang on 15/8/22.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (effect3D)
+ (UIImage *)create3DImageWithText:(NSString *)_text Font:(UIFont*)_font ForegroundColor:(UIColor*)_foregroundColor ShadowColor:(UIColor*)_shadowColor outlineColor:(UIColor*)_outlineColor depth:(int)_depth;
@end
