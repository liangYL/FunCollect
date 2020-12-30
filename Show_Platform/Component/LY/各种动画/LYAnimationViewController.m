//
//  LYAnimationViewController.m
//  Show_Platform
//
//  Created by liang on 15/4/11.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "LYAnimationViewController.h"
#import "LYAnimationTools.h"

#import "MMFloatingNotification.h"

#import "LSPaoMaView.h"

#import "KYCuteView.h"

@interface LYAnimationViewController ()

@end

@implementation LYAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    //下雪
    [[[[LYAnimationTools alloc] init] autorelease] cIsSnowsAnimation:self.view duration:0.6 imageName:@"starRating_foregroundStar@2x.png"];
    
    //跑马灯效果(有待完善)
    NSString *text = @"这是一系列动画的组合,有我自己收集的,也有第三方的,总之,我碰到的动画都在这里面了,请尽情欣赏";
    LSPaoMaView* paomav = [[LSPaoMaView alloc] initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width-20, 40) title:text];
    [self.view addSubview:paomav];
    [paomav start];

    
    //从左到右的广告动画
    MMFloatingNotification * floatingNotification=[[MMFloatingNotification alloc] initWithTitle:@"欢迎来到动画世界"];
    floatingNotification.backgroundColor = [UIColor clearColor];
    [floatingNotification render];
    floatingNotification.image=[[UIImage alloc] init];
    //floatingNotification.delegate = self;
    [self.view addSubview:floatingNotification];
    
     [floatingNotification startAnimationCycleFromFrame:CGRectMake(0,60,100,40) throughKeyFrame:CGRectMake(100,60,100,40 ) toDestinationFrame:CGRectMake(320,60,100,40) atSpeed:4];
     floatingNotification=nil;
    
    
    //抖动
    UILabel * al = [[UILabel alloc] initForAutoLayout];
    [self.view addSubview:al];
    al.backgroundColor = [UIColor redColor];
    [al setMargin:UIEdgeInsetsMake(120, 60, X, X)];
    [al setSizeView:CGSizeMake(60, 60)];
    [LYAnimationTools cABasicAnimation:al duration:0.1 repeatCount:10];
    
    //小到大动画
    UILabel *zanView = [[UILabel alloc] init];
    zanView.backgroundColor = [UIColor redColor];
    [self.view addSubview:zanView];
    [zanView setMargin:UIEdgeInsetsMake(220, 60, X, X)];
    [zanView setSizeView:CGSizeMake(60, 60)];
    [LYAnimationTools cPopupAnimation:zanView duration:2];

    //倒计时
    UILabel *zanView1 = [[UILabel alloc] init];
    zanView1.backgroundColor = [UIColor redColor];
    zanView1.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:zanView1];
    [zanView1 setMargin:UIEdgeInsetsMake(120, X, X, 60)];
    [zanView1 setSizeView:CGSizeMake(60, 60)];
    [LYAnimationTools cTheCountDownAnimation:10 startBlack:^(NSInteger timeout){
        zanView1.text = [NSString stringWithFormat:@"剩余%ld秒",(long)timeout];
    } finishBlack:^ {
        zanView1.text = @"完成";
    }];
    
    //心跳
    UILabel *zanView2 = [[UILabel alloc] init];
    zanView2.backgroundColor = [UIColor redColor];
    [self.view addSubview:zanView2];
    [zanView2 setMargin:UIEdgeInsetsMake(220, X, X, 60)];
    [zanView2 setSizeView:CGSizeMake(60, 60)];
    [LYAnimationTools cHeartbeatView:zanView2 duration:3];
    
    //拖拽动画
    KYCuteView *cuteView = [[KYCuteView alloc]initWithPoint:CGPointMake(self.view.center.x-17, self.view.center.y) superView:self.view];
    cuteView.viscosity  = 20;
    cuteView.bubbleWidth = 35;
    cuteView.bubbleColor = [UIColor colorWithRed:0 green:0.722 blue:1 alpha:1];
    [cuteView setUp];
    [cuteView addGesture];
    //注意：设置 'bubbleLabel.text' 一定要放在 '-setUp' 方法之后
    //Tips:When you set the 'bubbleLabel.text',you must set it after '-setUp'
    cuteView.bubbleLabel.text = @"^_^";
    
    cuteView.bubbleLabel.textColor = [UIColor blackColor];
    
    //canvas 框架的动画组
    UIButton * aBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    aBtn.frame = CGRectMake(10, 350, self.view.frame.size.width-20, 40);
    aBtn.backgroundColor = [UIColor whiteColor];
    [aBtn setTitle:@"点击进入下一场" forState:UIControlStateNormal];
    [aBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aBtn];
    
    //点击生成动画
    UIButton * qipaoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    qipaoBtn.frame = CGRectMake(10, 410, self.view.frame.size.width-20, 40);
    qipaoBtn.backgroundColor = [UIColor whiteColor];
    [qipaoBtn setTitle:@"点击进入气泡动画" forState:UIControlStateNormal];
    [qipaoBtn addTarget:self action:@selector(qipao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qipaoBtn];
    
}
-(void)push{
    [self.navigationController pushViewController:[[NSClassFromString(@"CanvasAnimationsTableViewController") alloc] init] animated:YES];
}
-(void)qipao{
    [self.navigationController pushViewController:[[NSClassFromString(@"QipaoViewController") alloc] init] animated:YES];
}


- (void)dealloc
{
    [super dealloc];
}


-(void)viewDidDisappear:(BOOL)animated{
    [self.view removeFromSuperview];
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
