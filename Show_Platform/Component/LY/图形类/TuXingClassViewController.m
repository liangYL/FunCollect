//
//  TuXingClassViewController.m
//  Show_Platform
//
//  Created by liang on 15/6/12.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "TuXingClassViewController.h"

@interface TuXingClassViewController ()

@end

@implementation TuXingClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *aBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [aBtn setTitle:@"饼状图" forState:UIControlStateNormal];
    [aBtn addTarget:self action:@selector( bing) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aBtn];
    [aBtn setMargin:UIEdgeInsetsMake(100, 100, X, 100)];
    [aBtn setHight:40];
    
    
    UIButton * bBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [bBtn setTitle:@"柱状图" forState:UIControlStateNormal];
    [bBtn addTarget:self action:@selector( zhu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bBtn];
    
    [bBtn setMargin:UIEdgeInsetsMake(160, 100, X, 100)];
    [bBtn setHight:40];
    
    UIButton * cBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cBtn setTitle:@"k线图" forState:UIControlStateNormal];
    [cBtn addTarget:self action:@selector(kTu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cBtn];
    
    [cBtn setMargin:UIEdgeInsetsMake(220, 100, X, 100)];
    [cBtn setHight:40];
    
    
    UIButton * dBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [dBtn setTitle:@"UUChartView系列" forState:UIControlStateNormal];
    [dBtn addTarget:self action:@selector(UUChartView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dBtn];
    
    [dBtn setMargin:UIEdgeInsetsMake(280, 80, X, 80)];
    [dBtn setHight:40];
    
    UIButton * eBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [eBtn setTitle:@"环状图(雷达图)" forState:UIControlStateNormal];
    [eBtn addTarget:self action:@selector(huanView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eBtn];
    
    [eBtn setMargin:UIEdgeInsetsMake(340, 80, X, 80)];
    [eBtn setHight:40];
    
    
    
}

-(void)bing{
    [self.navigationController pushViewController:[[NSClassFromString(@"BingViewController") alloc] init] animated:YES];
}

-(void)zhu{
     [self.navigationController pushViewController:[[NSClassFromString(@"ZhuViewController") alloc] init] animated:YES];
}

-(void)kTu{
    [self.navigationController pushViewController:[[NSClassFromString(@"FMViewController") alloc] init] animated:YES];
}

-(void)UUChartView{
    [self.navigationController pushViewController:[[NSClassFromString(@"UURootViewController") alloc] init] animated:YES];
}

-(void)huanView{
      [self.navigationController pushViewController:[[NSClassFromString(@"HuanViewController") alloc] init] animated:YES];
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
