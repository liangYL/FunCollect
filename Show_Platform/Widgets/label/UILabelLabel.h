//
//  LabelLabel.h
//  Show_Platform
//
//  Created by liang on 15/3/24.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabelLabel : UIView
@property(nonatomic,retain)UILabel *leftLabel;
@property(nonatomic,copy)NSString *leftText;
@property(nonatomic,assign)CGFloat leftFont;
@property(nonatomic,retain)UIColor *leftTextColor;
@property(nonatomic,assign)NSInteger leftTextAlignment;

@property(nonatomic,retain)UILabel *rightLabel;
@property(nonatomic,copy)NSString *rightText;
@property(nonatomic,assign)CGFloat rightFont;
@property(nonatomic,retain)UIColor *rightTextColor;
@property(nonatomic,assign)NSInteger rightTextAlignment;

//leftLabel的宽是主视图的倍数(0.0 ~ 1.0,默认0.3)
@property(nonatomic,assign)CGFloat multiplier;


@end
