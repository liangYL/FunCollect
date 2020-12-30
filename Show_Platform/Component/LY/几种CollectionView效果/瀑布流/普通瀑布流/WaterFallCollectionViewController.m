//
//  WaterFallCollectionViewController.m
//  Show_Platform
//
//  Created by liang on 15/7/22.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "WaterFallCollectionViewController.h"
#import "HMWaterflowLayout.h"
#import "LYWaterfallLayout.h"

#import "WaterFallCell.h"

@interface WaterFallCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, HMWaterflowLayoutDelegate,LYWaterfallLayoutDelegate>
@property (nonatomic, retain)NSMutableArray * dataArray;
@property(nonatomic,retain) UICollectionView * collectionView;
@end
static NSString * cellIndentifier = @"cell";

@implementation WaterFallCollectionViewController

- (void)dealloc
{
    self.collectionView = nil;
    [super dealloc];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //self.dataArray = [@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""] mutableCopy];
    
    for (int i = 0; i<41; i++) {
        [self.dataArray addObjectsFromArray:@[[NSString stringWithFormat:@"%d.jpg",i]]];
    }
   
    //不同作者的瀑布流方法实现一样的效果
    
    //HM 的
//        HMWaterflowLayout *layout = [[HMWaterflowLayout alloc] init];
//        layout.delegate = self;
//        layout.columnsCount = 2;
//    
    //我的
    LYWaterfallLayout *layout = [[LYWaterfallLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.delegate = self;
    
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds  collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    //集合视图必须通过注册的形式，如果没有可重用的cell，根据你注册的类型去创建cell
    [_collectionView registerClass:[WaterFallCell class] forCellWithReuseIdentifier:cellIndentifier];
    //用 xib 实现的方法
    //[_collectionView registerNib:[UINib nibWithNibName:@"WaterFallCell" bundle:nil] forCellWithReuseIdentifier:cellIndentifier];
    
    [self.view addSubview:_collectionView];
    [layout release];
    [_collectionView release];

}
// HMde 代理
- (CGFloat)waterflowLayout:(HMWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    return arc4random()%200+100;
}
//我的代理
//每个cell高度指定代理
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(LYWaterfallLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return arc4random()%200+100;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //根据重用标识从重用队列取可重用的cell，如果没取到，内部自动会根据注册的类型去创建cell
    WaterFallCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    
   // cell.img.image = [UIImage imageNamed:[self.dataArray objectAtIndex:indexPath.row]];
    cell.imageView.image =[UIImage imageNamed:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"++");
}




//
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [self updateLayout];
//}
//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//                                         duration:(NSTimeInterval)duration
//{
//    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation
//                                            duration:duration];
//    [self updateLayout];
//}
//- (void)updateLayout
//{
//    LYWaterfallLayout *layout =
//    (LYWaterfallLayout *)self.collectionView.collectionViewLayout;
//    layout.columnCount = (self.collectionView.bounds.size.width-layout.sectionInset.left-layout.sectionInset.right) / 145;
//    layout.itemWidth = 145;
//    
//}








- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}



@end
