//
//  LYCardBrowseViewController.m
//  Show_Platform
//
//  Created by liang on 15/3/25.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "LYCardBrowseViewController.h"
#import "RGCardViewLayout.h"


static NSString * cellIndentifier = @"cell";

@interface LYCardBrowseViewController ()

@end

@implementation LYCardBrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    RGCardViewLayout * lay = [[RGCardViewLayout alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:lay];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIndentifier];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.backgroundColor = [UIColor colorWithWhite:0.623 alpha:1.000];
    
    [self.view addSubview:_collectionView];
    
    [_collectionView setMargin:UIEdgeInsetsMake(0, 0, 0, 0)];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //根据重用标识从重用队列取可重用的cell，如果没取到，内部自动会根据注册的类型去创建cell
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    for (UIView *view in cell.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    
    cell.layer.cornerRadius = 20;
    cell.layer.masksToBounds = YES;
    cell.backgroundColor = [UIColor redColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 300, 200);
    imageView.backgroundColor = [UIColor yellowColor];
    NSString *nameStr = [NSString stringWithFormat:@"i%ld.jpg",indexPath.section+1];
    imageView.image = [UIImage imageNamed:nameStr];
    [cell addSubview:imageView];
    
    UILabel * alabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 230, 250, 30)];
    alabel.textAlignment = NSTextAlignmentCenter;
    alabel.text = [NSString stringWithFormat:@"第 %ld 章",(long)indexPath.section];
    [cell addSubview:alabel];
    
    
    return cell;
}

//选中操作
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"=%ld=",indexPath.section);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
