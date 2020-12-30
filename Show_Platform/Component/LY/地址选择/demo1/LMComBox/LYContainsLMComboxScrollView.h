//
//  LMContainsLMComboxScrollView.h
//  YouLan
//
//  Created by tkinghr on 14-8-14.
//  Copyright (c) 2014年 YL. All rights reserved.
//  包含LMComboxView类型的子视图的UIScollView

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>
#import "LMComBoxView.h"

@protocol LYContainsLMComboxScrollViewDelegate <NSObject>

-(void)containsListClick:(NSString *)address;

@end


@interface LYContainsLMComboxScrollView : UIScrollView<LMComBoxViewDelegate>
{
    //NSMutableDictionary *addressDict;   //地址选择字典
    //NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    
    NSString *selectedProvince;
    NSString *selectedCity;
    NSString *selectedArea;
}

@property(nonatomic,retain)NSMutableDictionary *addressDict;
@property(nonatomic,retain)NSDictionary *areaDic;
@property(nonatomic,assign)id<LYContainsLMComboxScrollViewDelegate>comboxDelegate;

-(void)closeAllTheComBoxView;

@end
