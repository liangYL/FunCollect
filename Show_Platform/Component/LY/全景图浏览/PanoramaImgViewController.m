//
//  PanoramaImgViewController.m
//  Show_Platform
//
//  Created by liang on 15/6/7.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "PanoramaImgViewController.h"
#import "PanoramaView.h"
#import "FXBlurView.h"
@interface PanoramaImgViewController ()

@end

@implementation PanoramaImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PanoramaView *motionView = [[PanoramaView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50)];
    [motionView setImage:[UIImage imageNamed:@"51d783515fd8984303.jpg"]];
    [self.view addSubview:motionView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, self.view.frame.size.height - 50, 210, 20)];
    [titleLabel setText:@"Panorama View...Photo Tilt"];
    [titleLabel setShadowOffset:CGSizeMake(0, 1.0f)];
    [titleLabel setShadowColor:[[UIColor blackColor] colorWithAlphaComponent:0.2f]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [motionView addSubview:titleLabel];
    
    //添加模糊效果
    FXBlurView *fb = [[FXBlurView alloc] init];
    fb.frame = CGRectMake(100, 100, 150, 150);
    [self.view addSubview:fb];
    fb.center = CGPointMake(self.view.center.x, self.view.center.y-50);
    
    fb.blurRadius = 0.5;
    

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
