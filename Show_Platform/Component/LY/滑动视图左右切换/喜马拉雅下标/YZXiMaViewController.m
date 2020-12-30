//
//  YZXiMaViewController.m
//  YZDisplayViewControllerDemo
//
//  Created by yz on 15/12/5.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "YZXiMaViewController.h"

#import "SwitchMainViewController.h"


@implementation YZXiMaViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // 添加所有子控制器
    [self setUpAllViewController];
    
    self.titleFont = [UIFont systemFontOfSize:16];
    
    // 是否显示标签
    self.isShowUnderLine = YES;
    
    // 标题填充模式
    self.underLineColor = [UIColor redColor];
    self.titleScrollViewColor = [UIColor colorWithWhite:0.902 alpha:1.000];

    // 设置全屏显示
    // 如果有导航控制器或者tabBarController,需要设置tableView额外滚动区域,详情请看FullChildViewController
    self.isfullScreen = YES;
    
#warning 此例子和其他三个有少许区别
    /*FullChildViewController.m 的实现
    // 如果有导航控制器，顶部需要添加额外滚动区域
    // 添加额外滚动区域   导航条高度 + 标题高度
    if (self.navigationController) {
        // 导航条上面高度
        CGFloat navBarH = 64;
        // 查看自己标题滚动视图设置的高度，我这里设置为44
        CGFloat titleScrollViewH = 44;
        self.tableView.contentInset = UIEdgeInsetsMake(navBarH + titleScrollViewH, 0, 0, 0);
    }
    // 如果有tabBarController，底部需要添加额外滚动区域
    //self.tableView.contentInset = UIEdgeInsetsMake(64 + 44, 0, 49, 0);
     */
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
