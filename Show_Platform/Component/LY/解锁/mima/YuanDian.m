//
//  YuanDian.m
//  JieSuo
//
//  Created by 小赖 on 15-10-29.
//  Copyright (c) 2015年 alibaaaa. All rights reserved.
//

#import "YuanDian.h"

@implementation YuanDian
@synthesize wenbenxianshi,wenbenxianshi1,wenbenxianshi2,wenbenxianshi3;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGFloat selfWidth = [[UIScreen mainScreen] bounds].size.width;

        UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake((selfWidth-90-48)/2, 100, 12, 12)];
        btn1.layer.cornerRadius = 12/2;
        btn1.backgroundColor = [UIColor clearColor];
        btn1.layer.borderWidth = 2.0;
        btn1.layer.borderColor = [[UIColor colorWithRed:190.0/255.0 green:160.0/255.0 blue:140.0/255.0 alpha:1.0]CGColor];
        [self addSubview:btn1];
        
        UIButton * btn2 = [[UIButton alloc]initWithFrame:CGRectMake(btn1.lyRight+30, 100, 12, 12)];
        btn2.layer.cornerRadius = 12/2;
        btn2.backgroundColor = [UIColor clearColor];
        btn2.layer.borderWidth = 2.0;
        btn2.layer.borderColor = [[UIColor colorWithRed:190.0/255.0 green:160.0/255.0 blue:140.0/255.0 alpha:1.0]CGColor];
        [self addSubview:btn2];
        
        UIButton * btn3 = [[UIButton alloc]initWithFrame:CGRectMake(btn2.lyRight+30, 100, 12, 12)];
        btn3.layer.cornerRadius = 12/2;
        btn3.backgroundColor = [UIColor clearColor];
        btn3.layer.borderWidth = 2.0;
        btn3.layer.borderColor = [[UIColor colorWithRed:190.0/255.0 green:160.0/255.0 blue:140.0/255.0 alpha:1.0]CGColor];
        [self addSubview:btn3];
        
        UIButton * btn4 = [[UIButton alloc]initWithFrame:CGRectMake(btn3.lyRight+30, 100, 12, 12)];
        btn4.layer.cornerRadius = 12/2;
        btn4.backgroundColor = [UIColor clearColor];
        btn4.layer.borderWidth = 2.0;
        btn4.layer.borderColor = [[UIColor colorWithRed:190.0/255.0 green:160.0/255.0 blue:140.0/255.0 alpha:1.0]CGColor];
        [self addSubview:btn4];
        
        
        //  对 圆圈后的输入框进行设置 以产生圆点
        wenbenxianshi = [[UITextField alloc]initWithFrame:CGRectMake((selfWidth-90-48)/2+0.4, 100.6, 12, 12)];
        wenbenxianshi.backgroundColor = [UIColor clearColor];
        wenbenxianshi.textColor = [UIColor whiteColor];
        wenbenxianshi.secureTextEntry = YES;
        wenbenxianshi.userInteractionEnabled = NO;
        [self addSubview:wenbenxianshi];
        
        wenbenxianshi1 = [[UITextField alloc]initWithFrame:CGRectMake(wenbenxianshi.lyRight+30, 100.6, 12, 12)];
        wenbenxianshi1.backgroundColor = [UIColor clearColor];
        wenbenxianshi1.textColor = [UIColor whiteColor];
        wenbenxianshi1.secureTextEntry = YES;
        wenbenxianshi1.userInteractionEnabled = NO;
        [self addSubview:wenbenxianshi1];
        
        wenbenxianshi2 = [[UITextField alloc]initWithFrame:CGRectMake(wenbenxianshi1.lyRight+30, 100.6, 12, 12)];
        wenbenxianshi2.backgroundColor = [UIColor clearColor];
        wenbenxianshi2.textColor = [UIColor whiteColor];
        wenbenxianshi2.secureTextEntry = YES;
        wenbenxianshi2.userInteractionEnabled = NO;
        [self addSubview:wenbenxianshi2];
        
        wenbenxianshi3 = [[UITextField alloc]initWithFrame:CGRectMake(wenbenxianshi2.lyRight+30, 100.6, 12, 12)];
        wenbenxianshi3.backgroundColor = [UIColor clearColor];
        wenbenxianshi3.textColor = [UIColor whiteColor];
        wenbenxianshi3.secureTextEntry = YES;
        wenbenxianshi3.userInteractionEnabled = NO;
        [self addSubview:wenbenxianshi3];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
