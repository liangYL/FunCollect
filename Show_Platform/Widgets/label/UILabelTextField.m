//
//  UILabelTextField.m
//  Show_Platform
//
//  Created by liang on 15/3/24.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "UILabelTextField.h"

@implementation UILabelTextField
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self creatLabel];
    }
    return self;
}

-(void)creatLabel{
    _leftLabel = [[UILabel alloc] init];
    _leftLabel.textColor = [UIColor colorWithWhite:0.278 alpha:1.000];
    [self addSubview:_leftLabel];
    [_leftLabel setAutoLayoutBlock:^{
        if (!_multiplier) {
            [_leftLabel setWidthIsEqToView:self withMultiplier:0.3];
        }
        [_leftLabel setMargin:UIEdgeInsetsMake(0, 0, 0, X)];
        [_leftLabel release];
        
    }];
    
    _rightTextField = [[UITextField alloc] init];
    _rightTextField.textColor = [UIColor colorWithWhite:0.278 alpha:1.000];
    [self addSubview:_rightTextField];
    [_rightTextField setAutoLayoutBlock:^{
        [_rightTextField setLeftToView:_leftLabel withOffSet:5];
        [_rightTextField setMargin:UIEdgeInsetsMake(0, X, 0, 0)];
        [_rightTextField release];
    }];
     
}

-(void)setLeftText:(NSString *)leftText{
    _leftLabel.text = [NSString stringWithFormat:@"%@:",leftText];
}
-(void)setLeftFont:(CGFloat)leftFont{
    _leftLabel.font = [UIFont systemFontOfSize:leftFont];
}
-(void)setLeftTextColor:(UIColor *)leftTextColor{
    _leftLabel.textColor = leftTextColor;
}
-(void)setLeftTextAlignment:(NSInteger)leftTextAlignment{
    _leftLabel.textAlignment = leftTextAlignment;
}
-(void)setMultiplier:(CGFloat )multiplier{
    _multiplier = multiplier;
    [_leftLabel setWidthIsEqToView:self withMultiplier:_multiplier];
    
}

-(void)setRightText:(NSString *)rightText{
    _rightTextField.text = rightText;
}
-(void)setRightFont:(CGFloat)rightFont{
    _rightTextField.font = [UIFont systemFontOfSize:rightFont];
}
-(void)setRightTextColor:(UIColor *)rightTextColor{
    _rightTextField.textColor = rightTextColor;
}
-(void)setRightTextAlignment:(NSInteger)rightTextAlignment{
    _rightTextField.textAlignment = rightTextAlignment;
}
-(void)setPlaceholder:(NSString *)placeholder{
    _rightTextField.placeholder = placeholder;
}


- (void)dealloc
{
    self.leftLabel=nil;
    self.leftTextColor=nil;
    self.leftText  =nil;
    self.rightTextField=nil;
    self.rightText=nil;
    self.rightTextColor=nil;
    [super dealloc];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
