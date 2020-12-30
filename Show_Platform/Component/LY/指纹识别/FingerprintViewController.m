//
//  ViewController.m
//  yyy
//
//  Created by liang on 15/5/20.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "FingerprintViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>


@interface FingerprintViewController ()

@end

@implementation FingerprintViewController

//在iPhone 5上运行结果为：Optional(Error Domain=com.apple.LocalAuthentication Code=-6 "Biometry is not available on this device." UserInfo=0x15ec5a00 {NSLocalizedDescription=Biometry is not available on this device.})
//在模拟器上的运行结果为：Optional(Error Domain=com.apple.LocalAuthentication Code=-1000 "Simulator is not supported." UserInfo=0x7ffe604b0790 {NSLocalizedDescription=Simulator is not supported.})

//当允许使用Touch ID后，可以接着调用evaluatePolicy方法执行指定的认证策略，方法签名为：func evaluatePolicy(policy: LAPolicy, localizedReason: String!, reply: ((Bool, NSError!) -> Void)!)


//1. 连续三次指纹识别错误的运行结果：{Error Domain=com.apple.LocalAuthentication Code=-1 "Aplication retry limit exceeded." UserInfo=0x1740797c0 {NSLocalizedDescription=Aplication retry limit exceeded.}
//2. Touch ID功能被锁定，下一次需要输入系统密码时的运行结果：Error Domain=com.apple.LocalAuthentication Code=-1 "Biometry is locked out." UserInfo=0x17407dc00 {NSLocalizedDescription=Biometry is locked out.}
//3. 用户在Touch ID对话框中点击了取消按钮：Error Domain=com.apple.LocalAuthentication Code=-2 "Canceled by user." UserInfo=0x17006c780 {NSLocalizedDescription=Canceled by user.}
//4. 在Touch ID对话框显示过程中，背系统取消，例如按下电源键：Error Domain=com.apple.LocalAuthentication Code=-4 "UI canceled by system." UserInfo=0x170065900 {NSLocalizedDescription=UI canceled by system.}
//5. 用户在Touch ID对话框中点击输入密码按钮：Error Domain=com.apple.LocalAuthentication Code=-3 "Fallback authentication mechanism selected." UserInfo=0x17407e040 {NSLocalizedDescription=Fallback authentication mechanism selected.}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"指纹验证" forState: UIControlStateNormal];
    [btn addTarget:self action:@selector(oc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn setMargin:UIEdgeInsetsMake(100, 100, X, 100)];
    [btn setHight:50];
    
    
    
}

-(void)oc{
    //设备8.0以上才支持指纹识别
    if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
        NSLog(@"不支持");
        UIAlertView * aaaa = [[UIAlertView alloc] initWithTitle:@"设备不支持" message: nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [aaaa show];
        return;
    }
    
    LAContext *ctx = [[LAContext alloc] init];
    ctx.localizedFallbackTitle = @"开始验证";
    //ctx.maxBiometryFailures = [NSNumber numberWithInt:5];//输入最大错误数
    
    // 判断设备是否支持指纹识别
    if ([ctx canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:NULL]) {
        NSLog(@"支持");
        // 输入指纹，异步
        // 提示：指纹识别只是判断当前用户是否是手机的主人！程序原本的逻辑不会受到任何的干扰！
        [ctx evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请验证指纹以登录" reply:^(BOOL success, NSError *error) {
            NSLog(@"%d %@", success, error);
            
            if (success) {
                // 登录成功
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"回到主线程刷新UI");
                    UIImage * img                   = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",arc4random()%40]];
                    self.view.layer.contents        = (id)img.CGImage;
                    self.view.layer.backgroundColor = [UIColor clearColor].CGColor;
                    
                    [self showAlert:@"验证成功"];
                });
            }else{
                NSLog(@"错误");
            }
        }];
        
        NSLog(@"come here");
    } else {
        UIAlertView * aaaa = [[UIAlertView alloc] initWithTitle:@"设备不支持" message: nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [aaaa show];
        NSLog(@"不支持");
    }

}




-(void)swift{
    //步骤1：检查Touch ID是否可用
    /*
    let authenticationContext = LAContext()
    var error: NSError?
    
    let isTouchIdAvailable = authenticationContext.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics,
                                                                     error: &error)
    
    if isTouchIdAvailable
    {
        NSLog("恭喜，Touch ID可以使用！")
        //步骤2：获取指纹验证结果
        
        authenticationContext.evaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "需要验证您的指纹来确认您的身份信息", reply: {
            (success, error) -> Void in
            if success
            {
                NSLog("恭喜，您通过了Touch ID指纹验证！")
            }
            else
            {
                NSLog("抱歉，您未能通过Touch ID指纹验证！\n\(error)")
            }
        })
    }
    else
    {
        NSLog("抱歉，Touch ID不可以使用！\n\(error)")
    }
     
     */
}
#pragma mark UIAlertViewDelegate --弹出框代理方法
//弹出提示框设置
- (void)showAlert:(NSString *) _message{//时间
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [promptAlert show];
    [promptAlert release];
}
- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
