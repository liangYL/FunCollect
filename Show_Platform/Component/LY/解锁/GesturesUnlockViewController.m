//
//  GesturesUnlockViewController.m
//  
//
//  Created by liang on 15/12/10.
//
//

#import "GesturesUnlockViewController.h"
#import "CLLockVC.h"

@interface GesturesUnlockViewController ()

@end

@implementation GesturesUnlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton * abtn = [UIButton buttonWithType:UIButtonTypeSystem];
    abtn.frame = CGRectMake((self.view.lyWidth-100)/2, 100, 100, 40);
    [abtn setTitle:@"设置密码" forState:UIControlStateNormal];
    abtn.backgroundColor = [UIColor redColor];
    [abtn addTarget:self action:@selector(abtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:abtn];
    
    
    UIButton * bbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    bbtn.frame = CGRectMake((self.view.lyWidth-100)/2, abtn.lyBottom+20, 100, 40);
    [bbtn setTitle:@"验证密码" forState:UIControlStateNormal];
    bbtn.backgroundColor = [UIColor redColor];
    [bbtn addTarget:self action:@selector(bbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bbtn];
    
    
    UIButton * cbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cbtn.frame = CGRectMake((self.view.lyWidth-100)/2, bbtn.lyBottom+20, 100, 40);
    [cbtn setTitle:@"修改密码" forState:UIControlStateNormal];
    cbtn.backgroundColor = [UIColor redColor];
    [cbtn addTarget:self action:@selector(cbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cbtn];
    
    UIButton * dbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    dbtn.frame = CGRectMake((self.view.lyWidth-100)/2, cbtn.lyBottom+20, 100, 40);
    [dbtn setTitle:@"我的 demo" forState:UIControlStateNormal];
    dbtn.backgroundColor = [UIColor redColor];
    [dbtn addTarget:self action:@selector(dbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dbtn];
    
}

-(void)abtnClick{
    BOOL hasPwd = [CLLockVC hasPwd];
    hasPwd = NO;
    if(hasPwd){
        
        NSLog(@"已经设置过密码了，你可以验证或者修改密码");
        SHOWALERT(@"已经设置过密码了，你可以验证或者修改密码");

    }else{
        
        [CLLockVC showSettingLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            
            NSLog(@"密码设置成功");
            SHOWALERT(@"密码设置成功");
            [lockVC dismiss:1.0f];
        }];
    }

}

-(void)bbtnClick{
    BOOL hasPwd = [CLLockVC hasPwd];
    
    if(!hasPwd){
        
        NSLog(@"你还没有设置密码，请先设置密码");
        SHOWALERT(@"你还没有设置密码，请先设置密码");
    }else {
        
        [CLLockVC showVerifyLockVCInVC:self forgetPwdBlock:^{
            NSLog(@"忘记密码");
            SHOWALERT(@"忘记密码");

        } successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            NSLog(@"密码正确");
            SHOWALERT(@"密码正确");

            [lockVC dismiss:1.0f];
        }];
    }

}

-(void)cbtnClick{
    BOOL hasPwd = [CLLockVC hasPwd];
    
    if(!hasPwd){
        
        NSLog(@"你还没有设置密码，请先设置密码");
        SHOWALERT(@"你还没有设置密码，请先设置密码");
    }else {
        
        [CLLockVC showModifyLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            
            [lockVC dismiss:.5f];
        }];
    }

}


-(void)dbtnClick{
    
    [self.navigationController pushViewController:[[NSClassFromString(@"WodeViewController") alloc] init] animated:YES];
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
