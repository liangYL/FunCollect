//
//  LMMainViewController.m
//  LMComBoxView
//
//  Created by tkinghr on 14-8-15.
//  Copyright (c) 2014年 YL. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "LMMainViewController.h"
#import "LYContainsLMComboxScrollView.h"
#import "LYPickerView.h"

@interface LMMainViewController ()<LYContainsLMComboxScrollViewDelegate>



@end

@implementation LMMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    LYContainsLMComboxScrollView * a = [[LYContainsLMComboxScrollView alloc] init];
    [self.view addSubview:a];
    a.comboxDelegate = self;
    [a setMargin:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    LYPickerView * pick = [[LYPickerView alloc] init];
    pick.frame = CGRectMake(40, 220, 240, 210);
    [self.view addSubview:pick];
    
    //[pick setMargin:UIEdgeInsetsMake(200, 20, 30, 20)];
    
}

-(void)containsListClick:(NSString *)address{
    NSLog(@"---%@",address);
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
