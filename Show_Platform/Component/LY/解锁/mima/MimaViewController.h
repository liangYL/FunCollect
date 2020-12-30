//
//  ViewController.h
//  JieSuo
//
//  Created by 小赖 on 15-10-29.
//  Copyright (c) 2015年 alibaaaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YuanDian.h"

@protocol MimaViewDelegate <NSObject>

-(void)quxiaoClick;


@end

@interface MimaViewController : UIView

@property(nonatomic,assign)id<MimaViewDelegate>delegate;
@end
