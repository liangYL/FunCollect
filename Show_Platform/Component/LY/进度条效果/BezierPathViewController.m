//
//  BezierPathViewController.m
//  Show_Platform
//
//  Created by liang on 15/7/16.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "BezierPathViewController.h"
#import "XHAmazingLoadingView.h"
@interface BezierPathViewController ()
@property(nonatomic,retain)XHAmazingLoadingView *amazingLoadingView;
@property(nonatomic,retain)CAReplicatorLayer* r;
@property(nonatomic,retain)CAReplicatorLayer* rr;
@end

@implementation BezierPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //只能用 arc(mrc 会蹦)
    
    _amazingLoadingView = [[XHAmazingLoadingView alloc] init];
    _amazingLoadingView.loadingTintColor = [UIColor redColor];
    _amazingLoadingView.backgroundTintColor = [UIColor whiteColor];
    _amazingLoadingView.frame = self.view.bounds;
    [self.view addSubview:_amazingLoadingView];
    _amazingLoadingView.type = XHAmazingLoadingAnimationTypeMusic;
    
    [_amazingLoadingView startAnimating];
    
    
    
//    //可控制开/停
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [amazingLoadingView stopAnimating];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [amazingLoadingView startAnimating];
//        });
//    });

    UIButton * aBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    aBtn.backgroundColor = [UIColor whiteColor];
    [aBtn setTitle:@"音乐跳" forState:UIControlStateNormal];
    [aBtn addTarget:self action:@selector(a) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aBtn];
    [aBtn setMargin:UIEdgeInsetsMake(50, X, X, 20)];
    [aBtn setSizeView:CGSizeMake(70, 40)];
    
    UIButton * bBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    bBtn.backgroundColor = [UIColor whiteColor];
    [bBtn setTitle:@"五角星" forState:UIControlStateNormal];
    [bBtn addTarget:self action:@selector(b) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bBtn];
    [bBtn setMargin:UIEdgeInsetsMake(100, X, X, 20)];
    [bBtn setSizeView:CGSizeMake(70, 40)];
    
    UIButton * cBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cBtn.backgroundColor = [UIColor whiteColor];
    [cBtn setTitle:@"skype" forState:UIControlStateNormal];
    [cBtn addTarget:self action:@selector(c) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cBtn];
    [cBtn setMargin:UIEdgeInsetsMake(150, X, X, 20)];
    [cBtn setSizeView:CGSizeMake(70, 40)];
    
    UIButton * dBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    dBtn.backgroundColor = [UIColor whiteColor];
    [dBtn setTitle:@"转圈" forState:UIControlStateNormal];
    [dBtn addTarget:self action:@selector(D) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dBtn];
    [dBtn setMargin:UIEdgeInsetsMake(50, 20, X, X)];
    [dBtn setSizeView:CGSizeMake(70, 40)];
    
    UIButton * eBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    eBtn.backgroundColor = [UIColor whiteColor];
    [eBtn setTitle:@"路径" forState:UIControlStateNormal];
    [eBtn addTarget:self action:@selector(Ee) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eBtn];
    [eBtn setMargin:UIEdgeInsetsMake(100, 20, X, X)];
    [eBtn setSizeView:CGSizeMake(70, 40)];

}



-(void)a{
    [_r removeFromSuperlayer];
    [_rr removeFromSuperlayer];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_amazingLoadingView stopAnimating];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _amazingLoadingView.loadingTintColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
            _amazingLoadingView.type = XHAmazingLoadingAnimationTypeMusic;
            [_amazingLoadingView startAnimating];
        });
    });
}
-(void)b{
    [_r removeFromSuperlayer];
    [_rr removeFromSuperlayer];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_amazingLoadingView stopAnimating];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _amazingLoadingView.loadingTintColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
            _amazingLoadingView.type = XHAmazingLoadingAnimationTypeStar;
            [_amazingLoadingView startAnimating];
        });
    });
}
-(void)c{
    
        [_r removeFromSuperlayer];
        [_rr removeFromSuperlayer];

    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_amazingLoadingView stopAnimating];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _amazingLoadingView.loadingTintColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
                _amazingLoadingView.type = XHAmazingLoadingAnimationTypeSkype;
                [_amazingLoadingView startAnimating];
            });
        });
}



-(void)D{
    //源自:http://www.ios-animations-by-emails.com/posts/2015-march#tutorial
    
    [_amazingLoadingView stopAnimating];
    [_rr removeFromSuperlayer];
    
    //添加背景
    _r = [[CAReplicatorLayer alloc] init];
    _r.bounds = CGRectMake( 0.0, 0.0, 200.0, 200.0);
    _r.cornerRadius = 10.0;
    _r.backgroundColor = [UIColor colorWithWhite:0.502 alpha:1.000].CGColor;
    _r.position = self.view.center;
    [self.view.layer addSublayer:_r];
    
    //添加内部小方块
    CALayer* dot = [[CALayer alloc] init];
    dot.bounds = CGRectMake( 0.0, 0.0, 14.0, 14.0);
    dot.position = CGPointMake(100.0, 40.0);
    dot.backgroundColor =[UIColor colorWithWhite:0.600 alpha:1.000].CGColor;
    dot.borderColor = [UIColor whiteColor].CGColor;
    dot.borderWidth = 1.0;
    dot.cornerRadius = 2.0;
    [_r addSublayer:dot];
    
    //小方块个数
    int nrDots = 15;
    //创建小方块
    _r.instanceCount = nrDots;
    CGFloat angle = (2*M_PI) / nrDots;
    //旋转角度(angle 旋转角度, x,y,z 值分别代表根据那个轴旋转,本利代表 z 轴旋转)
    _r.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0); //旋转
    
    
    //时间
    CFTimeInterval duration = 1.5;
    
    CABasicAnimation* shrink = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //从0-1缩小放大
    shrink.fromValue = @1.0;
    shrink.toValue = @0.1;
    shrink.duration = duration;
    //无限循环
    shrink.repeatCount = CGFLOAT_MAX;
    [dot addAnimation:shrink forKey:nil];
    
    //副本小方块的延迟时间
    _r.instanceDelay = duration/nrDots;
    
    //缩成最小就可以转啦
    dot.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);//缩放

    //swif
    /*
     animation2()
     func animation2() {
     let r = CAReplicatorLayer()
     r.bounds = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0)
     r.cornerRadius = 10.0
     r.backgroundColor = UIColor(white: 0.0, alpha: 0.75).CGColor
     r.position = view.center
     
     view.layer.addSublayer(r)

     let dot = CALayer()
     dot.bounds = CGRect(x: 0.0, y: 0.0, width: 14.0, height: 14.0)
     dot.position = CGPoint(x: 100.0, y: 40.0)
     dot.backgroundColor = UIColor(white: 0.8, alpha: 1.0).CGColor
     dot.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
     dot.borderWidth = 1.0
     dot.cornerRadius = 2.0
     
     r.addSublayer(dot)

     let nrDots: Int = 15
     
     r.instanceCount = nrDots
     let angle = CGFloat(2*M_PI) / CGFloat(nrDots)
     r.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
     
     let duration: CFTimeInterval = 1.5
     
     let shrink = CABasicAnimation(keyPath: "transform.scale")
     shrink.fromValue = 1.0
     shrink.toValue = 0.1
     shrink.duration = duration
     shrink.repeatCount = Float.infinity
     
     dot.addAnimation(shrink, forKey: nil)
     
     r.instanceDelay = duration/Double(nrDots)
     dot.transform = CATransform3DMakeScale(0.01, 0.01, 0.01)

     }
     */
}

-(void)Ee{
    [_amazingLoadingView stopAnimating];
    [_r removeFromSuperlayer];
    [_rr removeFromSuperlayer];
    
    _rr = [[CAReplicatorLayer alloc] init];
    _rr.bounds = CGRectMake( -100.0, -250.0, 200.0, 200.0);
    _rr.backgroundColor = [UIColor clearColor].CGColor;
    //_rr.position = self.view.center;
    
    [self.view.layer addSublayer:_rr];
    
    CALayer* dot = [[CALayer alloc] init];
    dot.bounds =CGRectMake(0, 0, 10, 10);
    dot.backgroundColor =[UIColor colorWithWhite:0.800 alpha:1.000].CGColor;
    dot.borderColor = [UIColor whiteColor].CGColor;
    dot.borderWidth = 1.0;
    dot.cornerRadius = 5.0;
    dot.shouldRasterize = true;
    dot.rasterizationScale = [UIScreen mainScreen].scale;
    
    [_rr addSublayer:dot];
    
    CAKeyframeAnimation* move =[CAKeyframeAnimation animationWithKeyPath:@"position"];
    move.path = [self rw];
    move.repeatCount = CGFLOAT_MAX;
    move.duration = 4.0;
    [dot addAnimation:move forKey:nil];
    
    
    _rr.instanceCount = 20;
    _rr.instanceDelay = 0.1;
    _rr.instanceColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1].CGColor;
    
    //小点越来越黑
    _rr.instanceGreenOffset = -0.03;

}
-(CGPathRef)rw{
    //// Bezier Drawing
    
    UIBezierPath *bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint:CGPointMake(31.5, 71.5)];
    [bezierPath addLineToPoint:CGPointMake(31.5, 23.5)];
    [bezierPath addCurveToPoint:CGPointMake(58.5, 38.5)
                  controlPoint1: CGPointMake(31.5, 23.5)
                  controlPoint2: CGPointMake(62.46, 18.69)];
    [bezierPath addCurveToPoint:CGPointMake(53.5, 45.5)
                  controlPoint1: CGPointMake(57.5, 43.5)
                  controlPoint2: CGPointMake(53.5, 45.5)];
    [bezierPath addLineToPoint:CGPointMake(43.5, 48.5)];
    [bezierPath addLineToPoint:CGPointMake(53.5, 66.5)];
    [bezierPath addLineToPoint:CGPointMake(62.5, 51.5)];
    [bezierPath addLineToPoint:CGPointMake(70.5, 66.5)];
    [bezierPath addLineToPoint:CGPointMake(86.5, 23.5)];
    [bezierPath addLineToPoint:CGPointMake(86.5, 78.5)];
    [bezierPath addLineToPoint:CGPointMake(31.5, 78.5)];
    [bezierPath addLineToPoint:CGPointMake(31.5, 71.5)];
    [bezierPath closePath];
    
    CGAffineTransform t = CGAffineTransformMakeScale(3.0, 3.0);
    return CGPathCreateCopyByTransformingPath(bezierPath.CGPath, &t);
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
