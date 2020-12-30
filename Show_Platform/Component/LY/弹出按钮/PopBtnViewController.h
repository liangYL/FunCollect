//
//  PopBtnViewController.h
//  Show_Platform
//
//  Created by liang on 15/3/27.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VLDContextSheetItem.h"
#import "VLDContextSheet.h"
@interface PopBtnViewController : UIViewController<VLDContextSheetDelegate>
@property (retain, nonatomic) VLDContextSheet *contextSheet;

@end
