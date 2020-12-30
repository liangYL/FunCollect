//
//  LYPickerView.h
//  Platform
//
//  Created by liang on 15/2/10.
//  Copyright (c) 2015年 Sirius. All rights reserved.
//

#import <UIKit/UIKit.h>
#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2

@protocol LYPickerViewDelegate <NSObject>

-(void)outputResult:(NSString *)str;

@end

@interface LYPickerView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>
{
    UIPickerView *picker;
    UIButton *button;
    UIButton *delButton;
    
    NSDictionary *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    
    NSString *selectedProvince;
}

@property(nonatomic,assign)id<LYPickerViewDelegate>delegate;

@end
