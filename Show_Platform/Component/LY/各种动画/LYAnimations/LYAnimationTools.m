//
//  LYAnimationTools.m
//  LYLogin
//
//  Created by liang on 15/3/10.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "LYAnimationTools.h"

@implementation LYAnimationTools

#pragma mark-CATransition 动画
+ (void)cATransitionAnimation:(UIView *)toView type:(NSString *)type subType:(NSString *)subType duration:(NSTimeInterval)duration animation:(void(^)(void))animation
{
    CATransition * transition = [CATransition animation];
    transition.type = type;
    transition.duration = duration;
    transition.subtype = subType;
    [toView.layer addAnimation:transition forKey:nil];
    animation();
}

#pragma mark-旋转角度 动画

+ (void)cTransformAnimation:(UIView *)toView duration:(NSTimeInterval)duration Angle:(CGFloat)angle{
    //用Transform可以实现旋转
    [UIView animateWithDuration:duration animations:^{
        //2D仿射变换
        toView.transform = CGAffineTransformRotate(toView.transform, angle);
    }];
}

#pragma mark-下雪动画 动画

- (void)cIsSnowsAnimation:(UIView *)toView duration:(NSTimeInterval)duration imageName:(NSString *)imageName;
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if(toView != nil)
    {
        [dict setObject:toView forKey:@"toView"];
    }
    if(imageName)
    {
        [dict setObject:imageName forKey:@"imageName"];
    }
    [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(onTimer:) userInfo:dict repeats:YES];
    [dict release];
}
- (void)onTimer:(NSTimer *)timer;
{
    int a = ((UIView *)[[timer userInfo] objectForKey:@"toView"]).frame.size.width;
    int b = ((UIView *)[[timer userInfo] objectForKey:@"toView"]).frame.size.height;
    UIImage * aImage = [UIImage imageNamed:[[timer userInfo] objectForKey:@"imageName"]];
    UIImageView * flakeView = [[UIImageView alloc] initWithImage:aImage];
    int startX = arc4random() % a;
    int endX = arc4random() % a;
    //图片放大倍数
    double scale = 1 / arc4random() % 100 + 1.0;
    double speed = 1 / arc4random() % 100 + 1.0;
    flakeView.frame = CGRectMake(startX, -30.0, 25.0 * scale, 25.0 * scale);
    [[[timer userInfo] objectForKey:@"toView"] addSubview:flakeView];
    [UIView beginAnimations:nil context:flakeView];
    [UIView setAnimationDuration:15 * speed];
    flakeView.frame = CGRectMake(endX, b, 25.0 * scale, 25.0 * scale);
    [UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

- (void)onAnimationComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    UIImageView *flakeView = context;
    [flakeView  removeFromSuperview];
    [flakeView  release];
    
}

#pragma mark-视图抖动 动画

+ (void)cABasicAnimation:(UIView *)toView duration:(NSTimeInterval)duration repeatCount:(NSInteger)repCount{

    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shake.fromValue = [NSNumber numberWithFloat:-M_PI/32];
    shake.toValue = [NSNumber numberWithFloat:+M_PI/32];
    shake.duration = duration;
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = repCount;
    [toView.layer addAnimation:shake forKey:@"shakeAnimation"];
//    toView.alpha = 1.0;
//    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{
//        toView.alpha = 1.0; //透明度变0则消失
//    } completion:nil];

}


+ (void)cSomePraiseAnimation:(UIView *)toView duration:(NSTimeInterval)duration{
    [UIView animateWithDuration:duration animations:^{
        toView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration animations:^{
            toView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:duration animations:^{
                toView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];
}

// 心跳动画
+ (void)cHeartbeatView:(UIView *)view duration:(CGFloat)fDuration
{
    [[self class] heartbeatView:view duration:fDuration maxSize:1.4f durationPerBeat:0.5f];
}
+ (void)heartbeatView:(UIView *)view duration:(CGFloat)fDuration maxSize:(CGFloat)fMaxSize durationPerBeat:(CGFloat)fDurationPerBeat
{
    if (view && (fDurationPerBeat > 0.1f))
    {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        
        CATransform3D scale1 = CATransform3DMakeScale(0.8, 0.8, 1);
        CATransform3D scale2 = CATransform3DMakeScale(fMaxSize, fMaxSize, 1);
        CATransform3D scale3 = CATransform3DMakeScale(fMaxSize - 0.3f, fMaxSize - 0.3f, 1);
        CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
        
        NSArray *frameValues = [NSArray arrayWithObjects:
                                [NSValue valueWithCATransform3D:scale1],
                                [NSValue valueWithCATransform3D:scale2],
                                [NSValue valueWithCATransform3D:scale3],
                                [NSValue valueWithCATransform3D:scale4],
                                nil];
        
        [animation setValues:frameValues];
        
        NSArray *frameTimes = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:0.05],
                               [NSNumber numberWithFloat:0.2],
                               [NSNumber numberWithFloat:0.6],
                               [NSNumber numberWithFloat:1.0],
                               nil];
        [animation setKeyTimes:frameTimes];
        
        animation.fillMode = kCAFillModeForwards;
        animation.duration = fDurationPerBeat;
        animation.repeatCount = fDuration/fDurationPerBeat;
        
        [view.layer addAnimation:animation forKey:@"heartbeatView"];
    }else{}
}

+ (void)cPopupAnimation:(UIView *)outView duration:(CFTimeInterval)duration
{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    
    NSMutableArray * values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    
    [outView.layer addAnimation:animation forKey:nil];
}


+ (void)cTheCountDownAnimation:(NSInteger)seconds startBlack:(void(^)(NSInteger timeout))startBlk finishBlack:(void(^)(void))finishBlk{
    __block NSInteger timeout = seconds; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_release(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                finishBlk();
            });
        }else{
//            NSInteger minutes = timeout / 60;
//            NSInteger seconds = timeout % 60;
//            NSString *strTime = [NSString stringWithFormat:@"%d分%.2d秒后重新获取验证码",minutes, seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                startBlk(timeout);
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}










@end
