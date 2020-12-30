//
//  LYAnimationTools.h
//  LYLogin
//
//  Created by liang on 15/3/10.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYAnimationTools : NSObject
//CATransition 翻转页面 动画
+ (void)cATransitionAnimation:(UIView *)toView type:(NSString *)type subType:(NSString *)subType duration:(NSTimeInterval)duration animation:(void(^)(void))animation;

//transform旋转角度
+ (void)cTransformAnimation:(UIView *)toView duration:(NSTimeInterval)duration Angle:(CGFloat)angle;

//下雪动画
//* duration越小,显示雪花个数越多
- (void)cIsSnowsAnimation:(UIView *)toView duration:(NSTimeInterval)duration imageName:(NSString *)imageName;

//视图抖动
+ (void)cABasicAnimation:(UIView *)toView duration:(NSTimeInterval)duration repeatCount:(NSInteger)repCount;

//点赞动画
+ (void)cSomePraiseAnimation:(UIView *)toView duration:(NSTimeInterval)duration;

//心跳动画
+ (void)cHeartbeatView:(UIView *)view duration:(CGFloat)fDuration;

//弹出视图
+ (void)cPopupAnimation:(UIView *)outView duration:(CFTimeInterval)duration;

//倒计时
+ (void)cTheCountDownAnimation:(NSInteger)seconds startBlack:(void(^)(NSInteger timeout))startBlk finishBlack:(void(^)(void))finishBlk;

@end
