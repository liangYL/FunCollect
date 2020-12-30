//
//  ViewController.m
//  JieSuo
//
//  Created by 小赖 on 15-10-29.
//  Copyright (c) 2015年 alibaaaa. All rights reserved.
//

#import "MimaViewController.h"
#import "YuanDian.h"
@interface MimaViewController ()
{
    UIButton * btn;
    UIButton * clear;
    UILabel * lab;
    UILabel * lab1;
    NSString*  mimaFull;
    YuanDian * fourView;
    NSArray * mutabArray;
    NSMutableArray * mutabArray1;
    NSString*  trueMiMa;
    NSString*  trueMiMa2;
    NSTimer * timer;
    int number;
    int a;
    int b;
    int c;
    int d;
    int f;
    int cishu;
    int shijian;
    
}

@property(nonatomic,copy)NSString* trueMiMa1;

@property(nonatomic,retain)UIButton * btnLing;

@end

@implementation MimaViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}


- (void)setupView
{
    CGFloat selfWidth = [[UIScreen mainScreen] bounds].size.width;
    
    
    //  改变背景颜色
    self.backgroundColor = [UIColor blackColor];
    

  
    //创建两个可变数组 一个用来放 随机生成正确密码；一个用来放输入的密码
    mutabArray = @[@"2",@"5",@"2",@"6"];

    mutabArray1 = [[NSMutableArray alloc]initWithCapacity:0];


    
    
    
    // 将数组转换成字符串
    self.trueMiMa1= [NSString stringWithFormat:@"%@",mutabArray];
    
    
    //  四个圆圈 的创建
    fourView = [[YuanDian alloc]initWithFrame:CGRectMake(0 , 0, 10 , 10)];
    [self addSubview:fourView];
    
    
    // 创建的Label
    lab = [[UILabel  alloc]initWithFrame:CGRectMake((selfWidth-200)/2, 40, 200, 40)];
    lab.text = @"Touch ID 或输入密码";
    lab.backgroundColor = [UIColor clearColor];
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:20.0];
    [self  addSubview:lab];
    
    
    // 创建的密码输入次数显示框
    lab1 = [[UILabel  alloc]initWithFrame:CGRectMake((selfWidth-120)/2, 75, 120, 20)];
    lab1.backgroundColor = [UIColor clearColor];
    lab1.textColor = [UIColor whiteColor];
    lab1.font = [UIFont systemFontOfSize:10.0];
    lab1.textAlignment = NSTextAlignmentCenter;
    [self  addSubview:lab1];
    
    
    //  创建的数字 0 Button
    self.btnLing = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnLing.frame=CGRectMake((selfWidth-60)/2, 380, 60, 60);
    _btnLing.layer.cornerRadius = 30;
    _btnLing.backgroundColor = [UIColor clearColor];
    [_btnLing setTitle:@"0" forState:UIControlStateNormal];
    _btnLing.titleLabel.font = [UIFont systemFontOfSize:25.0];
    _btnLing.layer.borderWidth = 2.0;
    _btnLing.layer.borderColor = [[UIColor colorWithRed:190.0/255.0 green:160.0/255.0 blue:140.0/255.0 alpha:1.0]CGColor];
    [_btnLing addTarget:self action:@selector(dianji:) forControlEvents:UIControlEventTouchUpInside];
    [_btnLing setBackgroundImage:[UIImage imageNamed:@"雪花圆点"] forState:UIControlStateHighlighted];

    [self  addSubview:_btnLing];
    _btnLing.tag = 0+120;
    
    //创建 一个删除按钮
    clear = [[UIButton alloc]initWithFrame:CGRectMake(selfWidth-80, 430, 40, 30)];
    clear.backgroundColor = [UIColor clearColor];
    [clear setTitle:@"取消" forState:UIControlStateNormal];
    [clear setTitleColor:[UIColor colorWithRed:190.0/255.0 green:160.0/255.0 blue:140.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [clear setTitleColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    [clear addTarget:self action:@selector(shanchu:) forControlEvents:UIControlEventTouchUpInside];
    [self  addSubview:clear];
    
    //  for循环建立九宫格
    for (int i = 0; i < 3; i ++)
    {
        for (int j = 0; j <3;j++ )
        {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake((selfWidth-220)/2+60*i+20*i, 140+ 60*j+20*j, 60, 60);
            [btn setBackgroundImage:[UIImage imageNamed:@"雪花圆点"] forState:UIControlStateHighlighted];
            [btn setTitle:[NSString stringWithFormat:@"%d",3*j+i+1] forState:UIControlStateNormal];
            btn.tag = 3*j+i+1+120;
            [btn addTarget:self action:@selector(dianji:) forControlEvents:UIControlEventTouchUpInside];
            [self  addSubview:btn];
            btn.layer.cornerRadius = 30;
            btn.backgroundColor = [UIColor clearColor];
            btn.titleLabel.font = [UIFont systemFontOfSize:25.0];
            btn.layer.borderWidth = 2.0;
            btn.layer.borderColor = [[UIColor colorWithRed:190.0/255.0 green:160.0/255.0 blue:140.0/255.0 alpha:1.0]CGColor];
        }
        
    }
    
    //  cishu 是 输错的cs
    cishu = 3;
    //  时间是 输错三次后等待的时间
    shijian = 30;

}


// 点击删除按钮时 清空输入的内容
-(void)shanchu:(UIButton *)sent
{
    if([sent.titleLabel.text isEqualToString:@"取消"]){
        [self.delegate quxiaoClick];
    }
    
    fourView.wenbenxianshi.text = @"";
    fourView.wenbenxianshi1.text = @"";
    fourView.wenbenxianshi2.text = @"";
    fourView.wenbenxianshi3.text = @"";
    [mutabArray1 removeAllObjects];
    
    [clear setTitle:@"取消" forState:UIControlStateNormal];
}



#pragma mark  点击按钮事件
-(void)dianji:(UIButton*)dianjizhi
{
    
    
    
  
    [clear setTitle:@"删除" forState: UIControlStateNormal];
    
    number = dianjizhi.tag-120;
    
    mimaFull = [NSString stringWithFormat:@"%d",number];
    //  将每一次点击的数字 都存入到数组中
    [mutabArray1 addObject:mimaFull];
    // 将数组转换成 字符串  以便两个字符串 进行对比
    trueMiMa2= [NSString stringWithFormat:@"%@",mutabArray1];
    
    // 判断结构 可产生与圆圈后的圆点
    if ([fourView.wenbenxianshi.text  isEqual: @""])
    {
        fourView.wenbenxianshi.text =@"sdadsf";
    }
    else if ([fourView.wenbenxianshi1.text  isEqual: @""])
    {
        fourView.wenbenxianshi.text =@"sdadsf";
        fourView.wenbenxianshi1.text =@"sfdsfd";
    }
    
    else if ([fourView.wenbenxianshi2.text  isEqual: @""])
    {
        fourView.wenbenxianshi.text =@"sdadsf";
        fourView.wenbenxianshi1.text =@"sfdsfd";
        fourView.wenbenxianshi2.text =@"sfdsfd";
    }
    
    else if ([fourView.wenbenxianshi3.text  isEqual: @""] )
    {
        fourView.wenbenxianshi.text =@"sdadsf";
        fourView.wenbenxianshi1.text =@"sfdsfd";
        fourView.wenbenxianshi2.text =@"sfdsfd";
        fourView.wenbenxianshi3.text =@"sfdsfd";
    }
    
    
    
    //  判断结构  判断两个字符串是否相等
    if ([trueMiMa2 isEqualToString:_trueMiMa1]
        && mutabArray1.count == 4)
    {
        NSLog(@"正确");
        fourView.wenbenxianshi.text = @"";
        fourView.wenbenxianshi1.text = @"";
        fourView.wenbenxianshi2.text = @"";
        fourView.wenbenxianshi3.text = @"";
        [mutabArray1 removeAllObjects];
        [clear setTitle:@"删除" forState: UIControlStateNormal];

        lab1.text= @"";
        cishu = 3;
        
        [self exitApplication];
        
    }
    else if(![trueMiMa2 isEqualToString:_trueMiMa1] && mutabArray1.count == 4)
    {
        
        [mutabArray1 removeAllObjects];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.1];
        [UIView setAnimationRepeatCount:1];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(huangdong)];
        fourView.frame = CGRectMake(-10, 0, 10, 10);
        [clear setTitle:@"取消" forState:UIControlStateNormal];
        [UIView commitAnimations];
        
        cishu = cishu - 1;
        NSString * xianshi = [NSString stringWithFormat:@"剩余次数：%d次",cishu];
        lab1.text = xianshi;
        
        if (cishu == 0)
        {
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(jianshijian) userInfo:nil repeats:YES];
            self.userInteractionEnabled = NO;

        }
    }
}


// 输错三次后 计时器所 进行的方法
-(void)jianshijian
{
    
    shijian--;
    NSString * timeShengYu = [NSString stringWithFormat:@"剩余时间为：%d秒",shijian];
    lab1.text = timeShengYu;
    //  计时器为0时， 计时器失效 重新设置参数
    if ( shijian == 0)
    {
        [timer invalidate];
        lab1.text =@"";
        shijian = 30;
        self.userInteractionEnabled = YES;
        cishu = 3;
    }
    
}


#pragma mark 位移动画
-(void)huangdong
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationRepeatCount:1];
    fourView.frame = CGRectMake(10, 0, 10, 10);
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(huangdong1)];
    [UIView commitAnimations];
    
}

-(void)huangdong1
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationRepeatCount:1];
    fourView.frame = CGRectMake(-10, 0, 10, 10);
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(huangdong2)];
    [UIView commitAnimations];
    
}
-(void)huangdong2
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationRepeatCount:1];
    fourView.frame = CGRectMake(0, 0, 10, 10);
    [UIView commitAnimations];
    fourView.wenbenxianshi.text = @"";
    fourView.wenbenxianshi1.text = @"";
    fourView.wenbenxianshi2.text = @"";
    fourView.wenbenxianshi3.text = @"";
    

}


//-------------------------------- 退出程序 -----------------------------------------//

-(void)exitApplication{
    
    
    [UIView animateWithDuration:1 animations:^{
        //self.view.window.frame =CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
    
    
}

- (void)exitApplicationq {
    
    
    [UIView beginAnimations:@"exitApplication" context:nil];
    
    [UIView setAnimationDuration:0.5];
    
    [UIView setAnimationDelegate:self];
    
    // [UIView setAnimationTransition:UIViewAnimationCurveEaseIn forView:self.view.window cache:NO];
    
    //[UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.window cache:NO];
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    
    self.window.bounds = CGRectMake(self.frame.size.width/2, self.frame.size.height/2, 0, 0);
    
    //self.window.bounds = CGRectMake(0, 0, 0, 0);
    
    [UIView commitAnimations];
    
}


- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if ([animationID compare:@"exitApplication"] == 0) {
        
        exit(0);
        
    }
    
}



@end
