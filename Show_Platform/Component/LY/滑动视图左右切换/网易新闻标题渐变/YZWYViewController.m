//
//  YZWYViewController.m
//  YZDisplayViewControllerDemo
//
//  Created by yz on 15/12/5.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "YZWYViewController.h"

#import "SwitchMainViewController.h"


@implementation YZWYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // 添加所有子控制器
    [self setUpAllViewController];
    
    // 标题渐变
    self.isShowTitleGradient = YES;
    
    // 标题RGB渐变模式
    self.titleColorGradientStyle = YZTitleColorGradientStyleRGB;
    
    //未选中标题字体颜色
    self.startR = 0.5;self.startG = 0.5;self.startB = 0.5;
    //选中标题字体颜色
    self.endR = 1;
    //背景色
    self.titleScrollViewColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    
    
    // 字体缩放
    self.isShowTitleScale = YES;
    
    self.titleScale = 1.3;
}

// 添加所有子控制器
- (void)setUpAllViewController
{
    
    NSArray * array = @[@"中行",@"建行",@"交行",@"广发",@"光大",@"农村信用社",@"华夏"];
    for (int i = 0; i<array.count; i++) {
        // 段子
        SwitchMainViewController *wordVc = [[SwitchMainViewController alloc] init];
        wordVc.title = [array objectAtIndex:i];
        [self addChildViewController:wordVc];
        
    }
    
}


@end
