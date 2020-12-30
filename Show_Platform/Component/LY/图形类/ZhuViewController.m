//
//  ZhuViewController.m
//  Show_Platform
//
//  Created by liang on 15/6/12.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "ZhuViewController.h"


@interface ZhuViewController ()
{
    CGFloat jiange;
    CGFloat maxValue;
    
}
@end

@implementation ZhuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    jiange = 10;
    maxValue = 10;
    
    [self loadZhuView];
    
    for (int i = 0; i<2; i++) {
        UISlider * ddd = [[UISlider alloc] init];
        ddd.minimumValue = 0;
        ddd.maximumValue = 50;
        ddd.tag = 11400+i;
        [ddd addTarget:self action:@selector(scl:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:ddd];
        
        [ddd setMargin:UIEdgeInsetsMake(350+40*i, 50, X, X)];
        [ddd setSizeView:CGSizeMake(200, 40)];
        
    }
    
}

-(void)loadZhuView{
    _barChart = [[TEABarChart alloc] init];
    //间距
    _barChart.barSpacing = jiange;
    //数据
    _barChart.data = @[@3, @1, @4, @1, @5, @9, @2, @6, @5, @3];
    //柱子背景色
    _barChart.barColors = @[[UIColor orangeColor], [UIColor yellowColor], [UIColor greenColor], [UIColor blueColor]];
    //视图最下边标题
    _barChart.xLabels = @[@"A", @"B", @"C", @"D", @"E", @"F"];
    //是否默认显示最大的数
    [_barChart setAutoMax:NO];
    
    //设置最大值
    [_barChart setMax:maxValue];
    [self.view addSubview:_barChart];
    
    [_barChart setMargin:UIEdgeInsetsMake(10, 10, X, 10)];
    [_barChart setHight:300];

}




-(void)scl:(UISlider *)scl{
    float value = [scl value];
    
    
    switch (scl.tag) {
        case 11400:
            jiange = value;

            [_barChart removeFromSuperview];
            [self loadZhuView];
           _barChart.barSpacing = jiange;
            break;
            
        case 11401:
            maxValue = value;

            [_barChart removeFromSuperview];
            [self loadZhuView];
            _barChart.max = maxValue;
            break;
            
        default:
            break;
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
