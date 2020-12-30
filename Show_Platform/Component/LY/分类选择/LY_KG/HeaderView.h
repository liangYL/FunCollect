//
//  HeaderView.h
//  tableView的Cell展开和关闭
//
//  Created by qianfeng on 15/11/5.
//  Copyright (c) 2015年 李明星. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapBlock)(void);

@interface HeaderView : UIView

@property(nonatomic,copy)TapBlock block;

@property(nonatomic,retain)UILabel *aLabel;

-(void)updateWith:(NSString *)title WithStatus:(BOOL)status;

-(void)updateCenterWith:(NSString *)title;

@end
