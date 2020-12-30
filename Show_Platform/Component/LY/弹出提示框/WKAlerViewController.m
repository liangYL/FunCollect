//
//  WKAlerViewController.m
//  Show_Platform
//
//  Created by liang on 15/4/24.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "WKAlerViewController.h"
#import "WKAlertView.h"
#import "MozTopAlertView.h"

@interface WKAlerViewController ()
{
    UIWindow *_sheetWindow ;//window必须为全局变量或成员变量
    
}
@end

@implementation WKAlerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * btnA = [UIButton buttonWithType:UIButtonTypeSystem];
    UIButton * btnB = [UIButton buttonWithType:UIButtonTypeSystem];
    UIButton * btnC = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:btnA];
    [self.view addSubview:btnB];
    [self.view addSubview:btnC];
    [btnA setBackgroundColor:[UIColor redColor]];
    [btnB setBackgroundColor:[UIColor redColor]];
    [btnC setBackgroundColor:[UIColor redColor]];
    [btnA setTitle:@"成功" forState:UIControlStateNormal];
    [btnB setTitle:@"失败" forState:UIControlStateNormal];
    [btnC setTitle:@"警告" forState:UIControlStateNormal];
    
    [@[btnA,btnB,btnC] autoSetViewsDimension:ALDimensionHeight toSize:30];
    [@[btnA,btnB,btnC] autoSetViewsDimension:ALDimensionWidth toSize:100];
    [@[btnA,btnB,btnC] autoDistributeViewsAlongAxis:ALAxisBaseline withFixedSpacing:10 insetSpacing:YES alignment:NSLayoutFormatAlignAllTop];
    [btnA autoPinToTopLayoutGuideOfViewController:self withInset:25];
    
    [btnA addTarget:self action:@selector(A:) forControlEvents:UIControlEventTouchUpInside];
    [btnB addTarget:self action:@selector(B:) forControlEvents:UIControlEventTouchUpInside];
    [btnC addTarget:self action:@selector(C:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton * btnAA = [UIButton buttonWithType:UIButtonTypeSystem];
    UIButton * btnAB = [UIButton buttonWithType:UIButtonTypeSystem];
    UIButton * btnAC = [UIButton buttonWithType:UIButtonTypeSystem];
    UIButton * btnAD = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:btnAA];
    [self.view addSubview:btnAB];
    [self.view addSubview:btnAC];
    [self.view addSubview:btnAD];
    [btnAA setBackgroundColor:[UIColor redColor]];
    [btnAB setBackgroundColor:[UIColor redColor]];
    [btnAC setBackgroundColor:[UIColor redColor]];
    [btnAD setBackgroundColor:[UIColor redColor]];
    [btnAA setTitle:@"信息" forState:UIControlStateNormal];
    [btnAB setTitle:@"成功" forState:UIControlStateNormal];
    [btnAC setTitle:@"失败" forState:UIControlStateNormal];
    [btnAD setTitle:@"警告" forState:UIControlStateNormal];

    [@[btnAA,btnAB,btnAC,btnAD] autoSetViewsDimension:ALDimensionHeight toSize:30];
    [@[btnAA,btnAB,btnAC,btnAD] autoSetViewsDimension:ALDimensionWidth toSize:100];
    [@[btnAA,btnAB,btnAC,btnAD] autoDistributeViewsAlongAxis:ALAxisBaseline withFixedSpacing:10 insetSpacing:YES alignment:NSLayoutFormatAlignAllTop];
    [btnAA autoPinToTopLayoutGuideOfViewController:self withInset:75];
    
    [btnAA addTarget:self action:@selector(AA) forControlEvents:UIControlEventTouchUpInside];
    [btnAB addTarget:self action:@selector(AB) forControlEvents:UIControlEventTouchUpInside];
    [btnAC addTarget:self action:@selector(AC) forControlEvents:UIControlEventTouchUpInside];
    [btnAD addTarget:self action:@selector(AD) forControlEvents:UIControlEventTouchUpInside];

    
    
    
    
}

-(void)A:(UIButton *)btn{
        //为成员变量Window赋值则立即显示Window
        _sheetWindow = [WKAlertView showAlertViewWithStyle:WKAlertViewStyleSuccess title:@"温馨提示" detail:@"登陆成功" canleButtonTitle:nil okButtonTitle:@"确定" callBlock:^(MyWindowClick buttonIndex) {
            //Window隐藏，并置为nil，释放内存 不能少
            _sheetWindow.hidden = YES;
            _sheetWindow = nil;
        }];
}

-(void)B:(UIButton *)btn{
    //为成员变量Window赋值则立即显示Window
    _sheetWindow = [WKAlertView showAlertViewWithStyle:WKAlertViewStyleFail title:@"温馨提示" detail:@"登陆失败" canleButtonTitle:@"取消" okButtonTitle:@"确定" callBlock:^(MyWindowClick buttonIndex) {
        //Window隐藏，并置为nil，释放内存 不能少
        _sheetWindow.hidden = YES;
        _sheetWindow = nil;
    }];
}
-(void)C:(UIButton *)btn{
    //为成员变量Window赋值则立即显示Window
    _sheetWindow = [WKAlertView showAlertViewWithStyle:WKAlertViewStyleWaring title:@"警告" detail:@"您正在进行非安全操作！！" canleButtonTitle:@"取消" okButtonTitle:@"确定" callBlock:^(MyWindowClick buttonIndex) {
        //Window隐藏，并置为nil，释放内存 不能少
        _sheetWindow.hidden = YES;
        _sheetWindow = nil;
    }];
}

-(void)AA{
    [MozTopAlertView showWithType:MozAlertTypeInfo text:@"信息..." parentView:self.view];

}
-(void)AB{
    MozTopAlertView *alertView = [MozTopAlertView showWithType:MozAlertTypeSuccess text:@"成功" parentView:self.view];
    alertView.dismissBlock = ^(){
        NSLog(@"dismissBlock");
    };
}
-(void)AC{
    [MozTopAlertView showWithType:MozAlertTypeError text:@"Error" doText:@" " doBlock:^{
        
    } parentView:self.view];
}
-(void)AD{
    [MozTopAlertView showWithType:MozAlertTypeWarning text:@"警告" doText:@"取消" doBlock:^{
        
    } parentView:self.view];
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
