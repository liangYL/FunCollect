//
//  RootViewController.m
//  WaterFallTest
//
//  Created by 侯文富 on 14-2-15.
//  Copyright (c) 2014年 侯文富. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYWaterfallLayout;
@protocol LYWaterfallLayoutDelegate <UICollectionViewDelegate>
//每个cell高度指定代理
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(LYWaterfallLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface LYWaterfallLayout : UICollectionViewLayout
@property (nonatomic, assign) id<LYWaterfallLayoutDelegate> delegate;
@property (nonatomic, assign) NSUInteger columnCount; // 列数
@property (nonatomic, assign) CGFloat itemWidth; // item的宽度
@property (nonatomic, assign) UIEdgeInsets sectionInset; // 每个section的边框间距
@end
