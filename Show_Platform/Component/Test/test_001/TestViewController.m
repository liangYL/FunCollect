//
//  TestViewController.m
//  Show_Platform
//
//  Created by liang on 15/3/23.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "TestViewController.h"
#import "UILabelLabel.h"
#import "UILabelTextField.h"
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel * aLabel = [[UILabel alloc] init];
    aLabel.backgroundColor = [UIColor whiteColor];
    aLabel.text = @"这是演示实例";
    aLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:aLabel];
    [aLabel setAutoLayoutBlock:^{
        [aLabel setMargin:UIEdgeInsetsMake(0, 0, 0, 0)];
        [aLabel release];
    }];
    
 /*
  
    UILabelLabel * la = [[UILabelLabel alloc] init];
    la.frame = CGRectMake(100, 100, 150, 30);
    [self.view addSubview:la];
    la.leftText = @"姓名";
//    la.multiplier = 0.4;
    la.rightText = @"张三";
    
    UILabelTextField * lt = [[UILabelTextField alloc] init];
    lt.frame = CGRectMake(100, 150, 150, 30);
    [self.view addSubview:lt];
    lt.leftText = @"电话";
    lt.placeholder = @"11位电话号码";

  */
    
    
    
    
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
