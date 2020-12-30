//
//  ShapeWordView.h
//  Yingshe
//
//  Created by liang on 15/4/1.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBezierPath+TextPaths.h"

@interface ShapeWordView : UIView

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIFont   *font;
@property (nonatomic, strong) UIColor  *lineColor;
@property (nonatomic, assign) CGFloat   lineWidth;


/**
 *  创建view
 */
- (void)buildView;

/**
 *  百分比
 *
 *  @param percent 百分比
 */
- (void)percent:(CGFloat)percent animated:(BOOL)animated;



@end
