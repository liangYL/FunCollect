//
//  ProgressViewController.m
//  Show_Platform
//
//  Created by liang on 15/3/26.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "ProgressViewController.h"
#import "SDProgressView.h"
#import "THProgressView.h"
#import "JQCollectionView.h"
#import "LeafProgressView.h"

@interface ProgressViewController ()
@property(nonatomic,retain)SDPieProgressView *pieView1;
@property(nonatomic,retain)SDLoopProgressView *pieView2;
@property(nonatomic,retain)SDBallProgressView *pieView3;
@property(nonatomic,retain)SDPieLoopProgressView *pieView4;
@property(nonatomic,retain)SDTransparentPieProgressView *pieView5;
@property(nonatomic,retain)SDRotationLoopProgressView *pieView6;

@property(nonatomic,retain)NSTimer *timer;

@property(nonatomic,retain)THProgressView *thProgressView;
@property (nonatomic, retain) LeafProgressView *leafprogress;
@property (nonatomic, assign) CGFloat rate;
@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.812 alpha:1.000];

    //进度条THProgressView
    _thProgressView = [[THProgressView alloc] initWithFrame:CGRectMake(70, 30, self.view.frame.size.width-140, 30)];
    _thProgressView.borderTintColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    _thProgressView.progressTintColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    _thProgressView.progressBackgroundColor = [UIColor yellowColor];
    [self.view addSubview:_thProgressView];
    
    _leafprogress = [[LeafProgressView alloc]initWithFrame:CGRectMake(_thProgressView.lyLeft, _thProgressView.lyBottom, self.view.frame.size.width-140, 35)];
    [self.view addSubview:_leafprogress];
    [_leafprogress startLoading];

    //六种进度条
    _pieView1 = [SDPieProgressView progressView];
    _pieView1.frame = CGRectMake(70, 110, 60, 60);
    [self.view addSubview:_pieView1];
    _pieView2 = [SDLoopProgressView progressView];
    _pieView2.frame = CGRectMake(self.view.frame.size.width-70-60, 110, 60, 60);
    [self.view addSubview:_pieView2];
    _pieView3 = [SDBallProgressView progressView];
    _pieView3.frame = CGRectMake(70, 205, 60, 60);
    [self.view addSubview:_pieView3];
    _pieView4 = [SDPieLoopProgressView progressView];
    _pieView4.frame = CGRectMake(self.view.frame.size.width-70-60, 205, 60, 60);
    [self.view addSubview:_pieView4];
    _pieView5 = [SDTransparentPieProgressView progressView];
    _pieView5.frame = CGRectMake(70, 300, 60, 60);
    [self.view addSubview:_pieView5];
    _pieView6 = [SDRotationLoopProgressView progressView];
    _pieView6.frame = CGRectMake(self.view.frame.size.width-70-60, 300, 60, 60);
    [self.view addSubview:_pieView6];


    
    // 模拟下载进度
   _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(progressSimulation) userInfo:self repeats:YES];
    
    
    UIButton * aBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    aBtn.frame = CGRectMake(10, 400, self.view.frame.size.width-20, 40);
    aBtn.backgroundColor = [UIColor colorWithWhite:0.812 alpha:1.000];
    [aBtn setTitle:@"点击进入下一场1" forState:UIControlStateNormal];
    [aBtn addTarget:self action:@selector(push1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aBtn];
    
//    UIButton * bBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    bBtn.frame = CGRectMake(10, 440, self.view.frame.size.width-20, 40);
//    bBtn.backgroundColor = [UIColor colorWithWhite:0.812 alpha:1.000];
//    [bBtn setTitle:@"点击进入下一场2" forState:UIControlStateNormal];
//    [bBtn addTarget:self action:@selector(push2) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:bBtn];
    
    
    
     [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(aa) userInfo:nil repeats:YES];
}
-(void)aa
{
    _rate += 0.1;
    
    [_leafprogress setProgress:_rate];
    if (_rate >= 0.999) {
        //_rate = 0 ;
        [_leafprogress stopLoading];
    }
}

- (void)progressSimulation
{
    static CGFloat progress = 0;
    
    if (progress < 1.0) {
        progress += 0.01;
        
        // 循环
        if (progress >= 1.0){
            progress = 0;
        }
        
        _pieView1.progress = progress;
        _pieView2.progress = progress;
        _pieView3.progress = progress;
        _pieView4.progress = progress;
        _pieView5.progress = progress;
        _pieView6.progress = progress;
        
        _thProgressView.progress = progress;
        //[_leafprogress setProgress:progress];

    }
}
-(void)viewDidDisappear:(BOOL)animated{
    [_timer setFireDate:[NSDate distantFuture]];
}
-(void)viewWillAppear:(BOOL)animated{
    [_timer setFireDate:[NSDate date]];
}


-(void)push1{
    
    [self.navigationController pushViewController:[[NSClassFromString(@"BezierPathViewController") alloc] init] animated:YES];

}

-(void)push2{
    
    [self.navigationController pushViewController:[[NSClassFromString(@"JQCollectionView") alloc] init] animated:YES];
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
