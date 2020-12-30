//
//  Yao1YaoViewController.m
//  Show_Platform
//
//  Created by liang on 15/4/14.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "Yao1YaoViewController.h"
#import "LZAudioTool.h"
#import <AVFoundation/AVFoundation.h>

@interface Yao1YaoViewController ()
@property(nonatomic,retain)UIImageView * imgView;
@property(nonatomic,retain)UILabel * label;

@end

@implementation Yao1YaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _label = [[UILabel alloc]init];
    _label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_label];
    _label.text = @"摇一摇";
    _label.textAlignment = NSTextAlignmentCenter;
    [_label setMargin:UIEdgeInsetsMake(0, 0, 20, 0)];
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _imgView.image = [UIImage imageNamed:@"navigationbar_shake@2x"];
    [self.view addSubview:_imgView];
    _imgView.center = self.view.center;
    
}


//成为第一响应者
- (BOOL)canBecomeFirstResponder{
    return YES;
}

//开始摇动
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)even
{
    NSLog(@"开始摇动手机");
    
    //[LZAudioTool playMusic:@"dance.mp3"];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"winner.mp3" withExtension:nil];
    
    AVAudioPlayer * player = [[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil] autorelease];
    [player play];
    _imgView.image = [UIImage imageNamed:@"navigationbar_shake_highlighted@2x"];

    //手机震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
//结束摇动
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"stop");
    // 不是摇一摇运动事件
    if (motion != UIEventSubtypeMotionShake) {
        return;
    }

    //    UIAlertView *yaoyiyao = [[UIAlertView alloc]initWithTitle:@"提示" message:@"摇动结束" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    //    [yaoyiyao show];
    
    //self.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    UIImage * img                   = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",arc4random()%40]];
    self.view.layer.contents        = (id)img.CGImage;
    self.view.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    _imgView.hidden = YES;
    _label.hidden = YES;
}

/** 摇一摇取消（被中断，比如突然来电） */
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motionCancelled");
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
