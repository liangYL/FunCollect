//
//  QipaoViewController.m
//  Show_Platform
//
//  Created by liang on 15/7/15.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "QipaoViewController.h"
#import "HYBubbleButton.h"

@interface QipaoViewController ()

@end

@implementation QipaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HYBubbleButton * qipaoBtn = [HYBubbleButton buttonWithType:UIButtonTypeCustom];
    qipaoBtn.frame = CGRectMake(160, 400, 40, 40);
    qipaoBtn.backgroundColor = [UIColor clearColor];
    [qipaoBtn setImage:[UIImage imageNamed:@"gift_button2.png"] forState:UIControlStateNormal];
    [qipaoBtn addTarget:self action:@selector(qipao:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qipaoBtn];
    
    qipaoBtn.maxLeft = 150;
    qipaoBtn.maxRight = 100;
    qipaoBtn.maxHeight = 300;
    qipaoBtn.duration = 8;
    qipaoBtn.images = @[@"Oval.png",@"Star1.png",@"bg-addbutton.png",];
    
}

-(void)qipao:(UIButton *)sender{
    [(HYBubbleButton *)sender generateBubbleInRandom];
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
