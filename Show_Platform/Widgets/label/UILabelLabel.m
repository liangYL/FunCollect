//
//  LabelLabel.m
//  Show_Platform
//
//  Created by liang on 15/3/24.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "UILabelLabel.h"

@implementation UILabelLabel
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
    _leftLabel.backgroundColor = [UIColor whiteColor];
    _leftLabel.textColor = [UIColor colorWithWhite:0.278 alpha:1.000];
    [self addSubview:_leftLabel];
    [_leftLabel setAutoLayoutBlock:^{
        if (!_multiplier) {
            [_leftLabel setWidthIsEqToView:self withMultiplier:0.3];
        }
        [_leftLabel setMargin:UIEdgeInsetsMake(0, 0, 0, X)];
        [_leftLabel release];
        
    }];
    
    _rightLabel = [[UILabel alloc] init];
    _rightLabel.backgroundColor = [UIColor whiteColor];
    _rightLabel.textColor = [UIColor colorWithWhite:0.278 alpha:1.000];
    [self addSubview:_rightLabel];
    [_rightLabel setAutoLayoutBlock:^{
        [_rightLabel setLeftToView:_leftLabel withOffSet:5];
        [_rightLabel setMargin:UIEdgeInsetsMake(0, X, 0, 0)];
        [_rightLabel release];
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
    _rightLabel.text = rightText;
}
-(void)setRightFont:(CGFloat)rightFont{
    _rightLabel.font = [UIFont systemFontOfSize:rightFont];
}
-(void)setRightTextColor:(UIColor *)rightTextColor{
    _rightLabel.textColor = rightTextColor;
}
-(void)setRightTextAlignment:(NSInteger)rightTextAlignment{
    _rightLabel.textAlignment = rightTextAlignment;
}



- (void)dealloc
{
    self.leftLabel=nil;
    self.leftTextColor=nil;
    self.leftText  =nil;
    self.rightLabel=nil;
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
