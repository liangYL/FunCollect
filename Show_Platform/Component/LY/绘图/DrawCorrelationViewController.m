//
//  DrawCorrelationViewController.m
//  Show_Platform
//
//  Created by liang on 15/8/22.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "DrawCorrelationViewController.h"
#import "CustomView.h"
@interface DrawCorrelationViewController ()

@end

@implementation DrawCorrelationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //http://blog.csdn.net/rhljiayou/article/details/9919713
    // IOS用CGContextRef画各种图形(文字、圆、直线、弧线、矩形、扇形、椭圆、三角形、圆角矩形、贝塞尔曲线、图片)
    self.view.backgroundColor = [UIColor blackColor];
    
    CustomView * cu = [[CustomView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:cu];
    
    
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
