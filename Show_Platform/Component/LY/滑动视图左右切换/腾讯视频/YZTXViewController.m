//
//  YZTXViewController.m
//  YZDisplayViewControllerDemo
//
//  Created by yz on 15/12/5.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "YZTXViewController.h"

#import "SwitchMainViewController.h"

@implementation YZTXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // 添加所有子控制器
    [self setUpAllViewController];
    
    // 标题渐变
    self.isShowTitleGradient = YES;
    
    self.endR = 1;
    self.endG = 130 / 255.0;
    self.endB = 44 / 255.0;
    self.titleScrollViewColor = [UIColor colorWithWhite:0.902 alpha:1.000];

    // 是否显示遮盖
    self.isShowTitleCover = YES;
    self.coverColor = [UIColor colorWithWhite:0.7 alpha:0.4];
    self.coverCornerRadius = 13;
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
