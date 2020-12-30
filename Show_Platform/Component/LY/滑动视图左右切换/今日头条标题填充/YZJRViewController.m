//
//  YZJRViewController.m
//  YZDisplayViewControllerDemo
//
//  Created by yz on 15/12/5.
//  Copyright © 2015年 yz. All rights reserved.
//
//git 地址  https://github.com/iThinkerYZ/YZDisplayViewController
#import "YZJRViewController.h"

#import "SwitchMainViewController.h"

@implementation YZJRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 模仿网络延迟，0.2秒后，才知道有多少标题
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        // 移除之前所有子控制器
        [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
        
        // 把对应标题保存到控制器中，并且成为子控制器，才能刷新
        // 添加所有新的子控制器
        [self setUpAllViewController];
        
        // 注意：必须先确定子控制器
        [self refreshDisplay];
        
    });
    
    // 标题渐变
    self.isShowTitleGradient = YES;
    self.titleScrollViewColor = [UIColor colorWithWhite:0.902 alpha:1.000];

    // 标题填充模式
    self.titleColorGradientStyle = YZTitleColorGradientStyleFill;
}

// 添加所有子控制器
- (void)setUpAllViewController
{
    
    
    NSArray * array = @[@"中行",@"建行",@"交行",@"广发",@"光大",@"农村信用社",@"华夏"];
    for (int i = 0; i<array.count; i++) {
        // 段子
        SwitchMainViewController *wordVc = [[SwitchMainViewController alloc] init];
        wordVc.title = [array objectAtIndex:i];
        wordVc.view.frame =CGRectMake(0, 64, self.view.lyWidth, self.view.lyHeight-64);
        [self addChildViewController:wordVc];
    }
    
   
    
}

@end
