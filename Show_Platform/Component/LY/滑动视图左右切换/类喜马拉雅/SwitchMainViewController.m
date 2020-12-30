//
//  SwitchMainViewController.m
//  Show_Platform
//
//  Created by liang on 15/4/28.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "SwitchMainViewController.h"

@interface SwitchMainViewController ()
@property(nonatomic,retain)UIImageView *img;
@end

@implementation SwitchMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RandomColor;

   
    
    
    _img = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 320-100, self.view.frame.size.height-200)];
    _img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",arc4random()%50]];
    [self.view addSubview:_img];
    
    
    
}
-(void)viewDidCurrentView:(NSString *)str{
    
    NSLog(@"%@",str);
    NSString * ss = [NSString stringWithFormat:@"%d.jpg",arc4random()%50];
    _img.image = [UIImage imageNamed:ss];
    
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
