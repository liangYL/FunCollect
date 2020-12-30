//
//  WodeViewController.m
//  
//
//  Created by liang on 16/1/1.
//
//

#import "WodeViewController.h"
#import "LYLockView.h"
@interface WodeViewController ()

@end

@implementation WodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    
    LYLockView * lyk = [[LYLockView alloc] initWithFrame:CGRectMake(10, 100, self.view.lyWidth-20, self.view.lyWidth-20)];
    lyk.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lyk];
    
    
    
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
