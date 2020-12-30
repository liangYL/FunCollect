//
//  Some3DEffectViewController.m
//  Show_Platform
//
//  Created by liang on 15/8/22.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "Some3DEffectViewController.h"

#import "UIImage+effect3D.h"

@interface Some3DEffectViewController ()<UITextFieldDelegate>
{
    UIImageView *_imgView;
}
@end

@implementation Some3DEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.800 green:0.400 blue:0.000 alpha:1.000];
    
    UITextField *tef = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, self.view.frame.size.width-100, 40)];
    tef.borderStyle = UITextBorderStyleRoundedRect;
    tef.keyboardType = UIKeyboardTypeDefault;
    tef.placeholder = @"请输入";
    tef.delegate = self;
    [self.view addSubview:tef];
    
    
    
    //3D 效果
    UIImage *my3dImage = [UIImage create3DImageWithText:@"梁银龙" Font:[UIFont systemFontOfSize:100] ForegroundColor:[UIColor colorWithRed:(200/255.f) green:(200/255.f) blue:(200/255.f) alpha:1.0] ShadowColor:[UIColor blackColor] outlineColor:[UIColor colorWithRed:(225/255.f) green:(225/255.f) blue:(225/255.f) alpha:1.0] depth:8];
    _imgView = [[UIImageView alloc] initWithImage:my3dImage];
    _imgView.frame = CGRectMake(50, self.view.frame.size.height/2-100, self.view.frame.size.width-100, self.view.frame.size.height/3);
    [self.view addSubview: _imgView];

   
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
     UIImage *my3dImage = [UIImage create3DImageWithText:textField.text Font:[UIFont systemFontOfSize:100] ForegroundColor:[UIColor colorWithRed:(200/255.f) green:(200/255.f) blue:(200/255.f) alpha:1.0] ShadowColor:[UIColor blackColor] outlineColor:[UIColor colorWithRed:(225/255.f) green:(225/255.f) blue:(225/255.f) alpha:1.0] depth:8];
    _imgView.image = my3dImage;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
