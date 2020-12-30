//
//  UILabelTextField.h
//  Show_Platform
//
//  Created by liang on 15/3/24.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabelTextField : UIView
@property(nonatomic,retain)UILabel *leftLabel;
@property(nonatomic,copy)NSString *leftText;
@property(nonatomic,assign)CGFloat leftFont;
@property(nonatomic,retain)UIColor *leftTextColor;
@property(nonatomic,assign)NSInteger leftTextAlignment;

@property(nonatomic,retain)UITextField *rightTextField;
@property(nonatomic,copy)NSString *rightText;
@property(nonatomic,copy)NSString *placeholder;
@property(nonatomic,assign)CGFloat rightFont;
@property(nonatomic,retain)UIColor *rightTextColor;
@property(nonatomic,assign)NSInteger rightTextAlignment;


@property(nonatomic,assign)CGFloat multiplier;
@end
