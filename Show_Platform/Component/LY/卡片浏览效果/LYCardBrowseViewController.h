//
//  LYCardBrowseViewController.h
//  Show_Platform
//
//  Created by liang on 15/3/25.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYCardBrowseViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,retain)UICollectionView *collectionView;

@end
