//
//  LoadingEffectViewController.m
//  Show_Platform
//
//  Created by liang on 15/6/11.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "LoadingEffectViewController.h"
#import "DGActivityIndicatorView.h"
@interface LoadingEffectViewController ()

@end

@implementation LoadingEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    /*
       本 demo 地址(个数可能持续增加):
        https://github.com/ninjaprox/NVActivityIndicatorView (swift)
        https://github.com/ninjaprox/DGActivityIndicatorView  (oc)
    */
    
    
    
    NSArray *activityTypes = @[@(DGActivityIndicatorAnimationTypeNineDots), @(DGActivityIndicatorAnimationTypeTriplePulse),
                               @(DGActivityIndicatorAnimationTypeFiveDots),
                               @(DGActivityIndicatorAnimationTypeRotatingSquares),
                               @(DGActivityIndicatorAnimationTypeDoubleBounce),
                               @(DGActivityIndicatorAnimationTypeTwoDots),
                               @(DGActivityIndicatorAnimationTypeThreeDots),
                               @(DGActivityIndicatorAnimationTypeBallPulse),
                               @(DGActivityIndicatorAnimationTypeBallClipRotate),
                               @(DGActivityIndicatorAnimationTypeBallClipRotatePulse),
                               @(DGActivityIndicatorAnimationTypeBallClipRotateMultiple),
                               @(DGActivityIndicatorAnimationTypeBallRotate),
                               @(DGActivityIndicatorAnimationTypeBallZigZag),
                               @(DGActivityIndicatorAnimationTypeBallZigZagDeflect),
                               @(DGActivityIndicatorAnimationTypeBallTrianglePath),
                               @(DGActivityIndicatorAnimationTypeBallScale),
                               @(DGActivityIndicatorAnimationTypeLineScale),
                               @(DGActivityIndicatorAnimationTypeLineScaleParty),
                               @(DGActivityIndicatorAnimationTypeBallScaleMultiple),
                               @(DGActivityIndicatorAnimationTypeBallPulseSync),
                               @(DGActivityIndicatorAnimationTypeBallBeat),
                               @(DGActivityIndicatorAnimationTypeLineScalePulseOut),
                               @(DGActivityIndicatorAnimationTypeLineScalePulseOutRapid),
                               @(DGActivityIndicatorAnimationTypeBallScaleRipple),
                               @(DGActivityIndicatorAnimationTypeBallScaleRippleMultiple),
                               @(DGActivityIndicatorAnimationTypeTriangleSkewSpin),
                               @(DGActivityIndicatorAnimationTypeBallGridBeat),
                               @(DGActivityIndicatorAnimationTypeBallGridPulse),
                               @(DGActivityIndicatorAnimationTypeRotatingSandglass),
                               @(DGActivityIndicatorAnimationTypeRotatingTrigons),
                               @(DGActivityIndicatorAnimationTypeTripleRings),
                               @(DGActivityIndicatorAnimationTypeCookieTerminator)];
    
    for (int i = 0; i < activityTypes.count; i++) {
        DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:(DGActivityIndicatorAnimationType)[activityTypes[i] integerValue] tintColor:[UIColor yellowColor]];
        CGFloat width = self.view.bounds.size.width / 6.0f;
        CGFloat height = (self.view.bounds.size.height-64.f) / 6.0f;
        
        activityIndicatorView.frame = CGRectMake(width * (i % 6), height * (int)(i / 6), width, height);
        [self.view addSubview:activityIndicatorView];
        //开始
        [activityIndicatorView startAnimating];
        //结束
        //[activityIndicatorView stopAnimating];
    }

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
