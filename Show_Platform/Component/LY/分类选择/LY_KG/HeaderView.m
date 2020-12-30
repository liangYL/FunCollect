//
//  HeaderView.m
//  tableView的Cell展开和关闭
//
//  Created by qianfeng on 15/11/5.
//  Copyright (c) 2015年 李明星. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()

@property(nonatomic)UILabel *titleLable;

@property(nonatomic)UIImageView *iv;

@end


@implementation HeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customView];
    }
    return self;
}
-(void)customView
{
    self.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, self.frame.size.height)];
    _iv = [[UIImageView alloc] initWithFrame:CGRectMake(320-50, 10, 20, 20)];
    [_iv setImage:[UIImage imageNamed:@"111"]];
    [self addSubview:_iv];
    [self addSubview:_titleLable];
    
    _aLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 100, 25)];
    _aLabel.backgroundColor = [UIColor redColor];
    _aLabel.textAlignment = NSTextAlignmentCenter;
    _aLabel.font = [UIFont systemFontOfSize:14.0];
    [self addSubview:_aLabel];

    //添加点击的手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
}

-(void)onTap:(UITapGestureRecognizer *)tap
{
    if (self.block) {
        self.block();
    }
}

-(void)updateWith:(NSString *)title WithStatus:(BOOL)status
{
    _titleLable.text = title;
    
    [UIView beginAnimations:nil context:nil];
    _iv.transform = CGAffineTransformMakeRotation(status?M_PI:0);
    [UIView commitAnimations];
//    
//    if (status) {
//        [_iv setImage:[UIImage imageNamed:@"unfold"]];
//    }else{
//        [_iv setImage:[UIImage imageNamed:@"fold"]];
//    }
}
-(void)updateCenterWith:(NSString *)title{
    _aLabel.text  =title;
}

@end
