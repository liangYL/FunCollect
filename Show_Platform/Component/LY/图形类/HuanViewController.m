//
//  ViewController.m
//  SXFiveScoreShow
//
//  Created by dongshangxian on 15/5/26.
//  Copyright (c) 2015年 Sankuai. All rights reserved.
//

#import "HuanViewController.h"
#import "SXAnimateVIew.h"


@interface HuanViewController ()

@end

@implementation HuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
//------------三个角
    //背景图
    UIImageView * img = [[UIImageView alloc] init];
    img.backgroundColor = [UIColor clearColor];
    img.image = [UIImage imageNamed:@"fb_three"];
    [self.view addSubview:img];
    [img setMargin:UIEdgeInsetsMake(80, (self.view.lyWidth-150)/2, X, X)];
    [img setSizeView:CGSizeMake(150, 150)];
    
    //填充图
    SXAnimateVIew * aView = [[SXAnimateVIew alloc] init];
    aView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:aView];
    [aView setMargin:UIEdgeInsetsMake(80, (self.view.lyWidth-150)/2, X, X)];
    [aView setSizeView:CGSizeMake(150, 150)];
    
    aView.subScore1 = 3;
    aView.subScore2 = 3.5;
    aView.subScore3 = 2;
    aView.showType = 1;
    aView.showColor = [UIColor colorWithRed:1.000 green:0.400 blue:0.200 alpha:1.000];
    aView.showWidtn = 1;
    
    //没填充的图
    SXAnimateVIew * bView = [[SXAnimateVIew alloc] init];
    bView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bView];
    [bView setMargin:UIEdgeInsetsMake(80, (self.view.lyWidth-150)/2, X, X)];
    [bView setSizeView:CGSizeMake(150, 150)];
    
    bView.subScore1 = 5;
    bView.subScore2 = 4.5;
    bView.subScore3 = 3;
    bView.showType = 2;
    bView.showColor = [UIColor colorWithRed:0.000 green:0.800 blue:1.000 alpha:1.000];
    bView.showWidtn = 1;
    
//------------五个角
    
    //背景图
    UIImageView * img5 = [[UIImageView alloc] init];
    img5.backgroundColor = [UIColor clearColor];
    img5.image = [UIImage imageNamed:@"fb_five"];
    [self.view addSubview:img5];
    [img5 setMargin:UIEdgeInsetsMake(250, (self.view.lyWidth-150)/2, X, X)];
    [img5 setSizeView:CGSizeMake(150, 150)];
    
    //填充图
    SXAnimateVIew * aView5 = [[SXAnimateVIew alloc] init];
    aView5.backgroundColor = [UIColor clearColor];
    [self.view addSubview:aView5];
    [aView5 setMargin:UIEdgeInsetsMake(250, (self.view.lyWidth-150)/2, X, X)];
    [aView5 setSizeView:CGSizeMake(150, 150)];
    
    aView5.subScore1 = 3;
    aView5.subScore2 = 3.5;
    aView5.subScore3 = 2;
    aView5.subScore4 = 1.8;
    aView5.subScore5 = 3;
    aView5.showType = 1;
    aView5.showColor = [UIColor colorWithRed:1.000 green:0.400 blue:0.200 alpha:1.000];
    aView5.showWidtn = 1;
    
    //没填充的图
    SXAnimateVIew * bView5 = [[SXAnimateVIew alloc] init];
    bView5.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bView5];
    [bView5 setMargin:UIEdgeInsetsMake(250, (self.view.lyWidth-150)/2, X, X)];
    [bView5 setSizeView:CGSizeMake(150, 150)];
    
    bView5.subScore1 = 5;
    bView5.subScore2 = 4.5;
    bView5.subScore3 = 3;
    bView5.subScore4 = 4.5;
    bView5.subScore5 = 4;
    bView5.showType = 2;
    bView5.showColor = [UIColor colorWithRed:0.000 green:0.800 blue:1.000 alpha:1.000];
    bView5.showWidtn = 1;

    
    
    
    
    
    
    
    
}

@end
