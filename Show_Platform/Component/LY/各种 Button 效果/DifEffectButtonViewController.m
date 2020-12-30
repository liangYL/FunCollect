//
//  DifEffectButtonViewController.m
//  Show_Platform
//
//  Created by liang on 15/4/16.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "DifEffectButtonViewController.h"
#import "JTBorderDotAnimation.h"
#import "UIButton+NMCategory.h"
#import "WZFlashButton.h"
#import "CustomButton.h"
#import "CUSFlashLabel.h"
#import "TBAnimationButton.h"

#import "FadeStringView.h"
#import "CopyiPhoneFadeView.h"

#import "MCFireworksButton.h"

@interface DifEffectButtonViewController (){
    BOOL _selected;
}

@end

@implementation DifEffectButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.600 alpha:1.000];
//    self.navigationController.navigationBar.translucent = YES;
    
    //转圈
    JTBorderDotAnimation * bor  =[JTBorderDotAnimation new];
    UIButton * btnBor = [UIButton buttonWithType:UIButtonTypeSystem];
    btnBor.frame = CGRectMake(50, 60, 50, 30);
    btnBor.backgroundColor = RandomColor;
    [self.view addSubview:btnBor];
    bor.animatedView = btnBor;
    bor.numberPoints = 6;//(默认个数2)
//    bor.duration = 2.5;//越大速度越慢(默认5)
//    bor.repeatCount = 3;//默认无限循环
    bor.pointSize = 4;//默认宽4
    bor.pointColor = RandomColor;
    [bor start];
    //[bor stop]停止

    //点击内部发散效果
    WZFlashButton *innerFlashButton = [[WZFlashButton alloc] initWithFrame:CGRectZero];
    innerFlashButton.backgroundColor = RandomColor;
    innerFlashButton.flashColor = RandomColor;
    innerFlashButton.textLabel.text = @"click me !!";
    innerFlashButton.clickBlock = ^(void) {
        NSLog(@"Click Done");
    };
    [self.view addSubview:innerFlashButton];
    [innerFlashButton setMargin:UIEdgeInsetsMake(150, 50, X, 50)];
    [innerFlashButton setHight:50];
    
    //点击水波效果
    WZFlashButton *outerRoundFlashButton = [[WZFlashButton alloc] init];
    outerRoundFlashButton.buttonType = WZFlashButtonTypeOuter;
    outerRoundFlashButton.layer.cornerRadius = 25;
    outerRoundFlashButton.flashWidth = 2.5;//圈圈宽(默认2.5)
    outerRoundFlashButton.flashColor = RandomColor;
    outerRoundFlashButton.backgroundColor = RandomColor;
    [self.view addSubview:outerRoundFlashButton];
    [outerRoundFlashButton setMargin:UIEdgeInsetsMake(50, X, X, 50)];
    [outerRoundFlashButton setSizeView:CGSizeMake(50, 50)];
    
    //粒子效果(各参数内部控制)
    CustomButton *liziBtn = [[CustomButton alloc] init];
    [self.view addSubview:liziBtn];
    [liziBtn setMargin:UIEdgeInsetsMake(X, 50, 200, X)];
    [liziBtn setSizeView:CGSizeMake(60, 30)];
    
    //闪光字一(苹果解锁提示条)
    CUSFlashLabel *label1 = [[CUSFlashLabel alloc]init];
    label1.frame = CGRectMake(320-110, 480-200-5, 60, 30);
    [label1 setText:@" liang y l"];
    label1.backgroundColor = [UIColor blackColor];
    [label1 setFont:[UIFont systemFontOfSize:14]];
    [label1 setTextColor:[UIColor redColor]];
    [label1 setSpotlightColor:[UIColor yellowColor]];
    [label1 startAnimating];
    [self.view addSubview:label1];
    
    //左到右
    FadeStringView *fadeStringView = [[FadeStringView alloc] initWithFrame:CGRectMake(50, 10, 60, 30)];
    fadeStringView.text = @"从左到右";
    fadeStringView.foreColor = [UIColor whiteColor];
    fadeStringView.backColor = [UIColor redColor];
    fadeStringView.font = [UIFont systemFontOfSize:14];
    fadeStringView.alignment = NSTextAlignmentCenter;
    //fadeStringView.center = self.view.center;
    [self.view addSubview:fadeStringView];
    
    [fadeStringView fadeRightWithDuration:2];
    
    //闪光字二(苹果解锁提示条)
    CopyiPhoneFadeView *iphoneFade = [[CopyiPhoneFadeView alloc] initWithFrame:CGRectMake(self.view.lyWidth-110,10, 60, 30)];
    iphoneFade.text = @"滑动解锁";
    iphoneFade.foreColor = [UIColor whiteColor];
    iphoneFade.backColor = [UIColor redColor];
    iphoneFade.font = [UIFont systemFontOfSize:14];
    iphoneFade.alignment = NSTextAlignmentCenter;
    //iphoneFade.center = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height/2.0+50);
    [self.view addSubview:iphoneFade];
    
    [iphoneFade iPhoneFadeWithDuration:2];
    
    
    
    
    
    //吸附效果
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.backgroundColor = [UIColor redColor];
    btn1.layer.cornerRadius = 8;
    [btn1 setTitle:@"拖动" forState: UIControlStateNormal];
    [btn1.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn1 setDragEnable:YES];
    [btn1 setAdsorbEnable:YES];
    [self.view addSubview:btn1];
    [btn1 setMargin:UIEdgeInsetsMake(90, 20, X, X)];
    [btn1 setSizeView:CGSizeMake(40, 40)];
    
    //点击变换图形
    for (int i = 0; i<4; i++) {
        TBAnimationButton *btn = [TBAnimationButton buttonWithType:UIButtonTypeSystem];
        btn.currentState = i;
        [btn addTarget:self action:@selector(TBClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(40+60*i, 480-50-5, 60, 40);
        btn.tag = 260+i;
        [self.view addSubview:btn];
    }
    
    //点赞动画
    MCFireworksButton * fire = [MCFireworksButton buttonWithType:UIButtonTypeSystem];
    fire.frame =CGRectMake(140, 50, 50, 50);
    fire.particleImage = [UIImage imageNamed:@"Sparkle.png"];
    [fire setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
    fire.particleScale = 0.05;
    fire.particleScaleRange = 0.02;
    [fire addTarget:self action:@selector(handleButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fire];
    
    
    
}




-(void)buttonTapped{
    NSLog(@"点击");
}

-(void)TBClick:(TBAnimationButton *)sender{
    if (sender.tag == 260) {
        if (sender.currentState == TBAnimationButtonStateMenu) {
            [sender animationTransformToState:TBAnimationButtonStateArrow];
        } else if (sender.currentState == TBAnimationButtonStateArrow) {
            [sender animationTransformToState:TBAnimationButtonStateMenu];
        }
    } else if (sender.tag == 261) {
        if (sender.currentState == TBAnimationButtonStateArrow) {
            [sender animationTransformToState:TBAnimationButtonStateMinus];
        } else if (sender.currentState == TBAnimationButtonStateMinus) {
            [sender animationTransformToState:TBAnimationButtonStateArrow];
        }
    } else if (sender.tag == 262) {
        if (sender.currentState == TBAnimationButtonStateCross) {
            [sender animationTransformToState:TBAnimationButtonStatePlus];
        } else if (sender.currentState == TBAnimationButtonStatePlus) {
            [sender animationTransformToState:TBAnimationButtonStateCross];
        }
    } else if (sender.tag == 263) {
        if (sender.currentState == TBAnimationButtonStatePlus) {
            [sender animationTransformToState:TBAnimationButtonStateMinus];
        } else if (sender.currentState == TBAnimationButtonStateMinus) {
            [sender animationTransformToState:TBAnimationButtonStatePlus];
        }
    }
}

- (void)handleButtonPress:(id)sender {
    _selected = !_selected;
    if (_selected) {
        [sender popOutsideWithDuration:0.5];
        [sender setImage:[UIImage imageNamed:@"Like-Blue"] forState:UIControlStateNormal];
        [sender animate];
    }
    else {
        [sender popInsideWithDuration:0.4];
        [sender setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
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
