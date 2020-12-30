//
//  XTLoopScrollView.h
//  XTLoopScroll
//
//  Created by TuTu on 15/10/30.
//  Copyright © 2015年 teason. All rights reserved.
//

#define APPFRAME                        [UIScreen mainScreen].bounds


#import <UIKit/UIKit.h>

@protocol XTLoopScrollViewDelegate <NSObject>

-(void)imageViewClickIndex:(NSInteger)index;

@end



@interface XTLoopScrollView : UIView

@property(nonatomic,assign)id<XTLoopScrollViewDelegate>delegate;
@property (nonatomic,retain) UIColor *color_pageControl ;
@property (nonatomic,retain) UIColor *color_currentPageControl ;

- (instancetype)initWithFrame:(CGRect)frame
                 andImageList:(NSArray *)imglist
                      canLoop:(BOOL)canLoop
                     duration:(NSInteger)duration ;

- (void)setup ;

@end
