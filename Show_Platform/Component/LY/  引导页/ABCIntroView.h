//
//  IntroView.h
//  ABCIntroView
//
//  Created by Adam Cooper on 2/4/15.
//  Copyright (c) 2015 Adam Cooper. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ABCIntroViewDelegate <NSObject>

-(void)onDoneButtonPressed;

@end

@interface ABCIntroView : UIView
@property(nonatomic,assign)id<ABCIntroViewDelegate> delegate;

@end
