//
//  MoreShowEffectViewController.h
//  Show_Platform
//
//  Created by liang on 15/4/17.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
@interface MoreShowEffectViewController : UIViewController<iCarouselDataSource,iCarouselDelegate,UIActionSheetDelegate>

@property (nonatomic, retain)  iCarousel *carousel;
@property (nonatomic, retain)  UINavigationItem *navItem;

@property (nonatomic,assign) BOOL wrap;

- (void)switchCarouselType;
- (void)toggleWrap;

@end
