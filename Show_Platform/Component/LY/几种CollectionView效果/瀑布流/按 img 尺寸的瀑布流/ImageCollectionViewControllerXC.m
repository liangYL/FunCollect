//
//  ImageCollectionViewController.m
//  GreedoLayoutExample
//
//  Created by Denny Hoang on 2016-02-10.
//  Copyright © 2016 500px. All rights reserved.
//



#import "ImageCollectionViewControllerXC.h"

#import "GreedoCollectionViewLayout.h"

@interface ImageCollectionViewControllerXC () <GreedoCollectionViewLayoutDataSource, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (retain, nonatomic)  UICollectionView *collectionView;
@property (retain, nonatomic) GreedoCollectionViewLayout *collectionViewSizeCalculator;
@property (retain, nonatomic) NSArray *assetFetchResults;

@end
static NSString * cellIndentifier = @"cell";

@implementation ImageCollectionViewControllerXC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Configure spacing between cells
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 5.0f;
    layout.minimumLineSpacing = 5.0f;
    layout.sectionInset = UIEdgeInsetsMake(10.0f, 5.0f, 5.0f, 5.0f);
    
    //    self.collectionView.collectionViewLayout = layout;
    _collectionView =[[UICollectionView alloc] initWithFrame:self.view.bounds  collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.delaysContentTouches = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    //集合视图必须通过注册的形式，如果没有可重用的cell，根据你注册的类型去创建cell
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIndentifier];
    [self.view addSubview:_collectionView];
        
    self.collectionViewSizeCalculator.rowMaximumHeight = CGRectGetHeight(self.view.bounds) / 3;

    self.automaticallyAdjustsScrollViewInsets = NO;


  
    
    
    [self retrieveImagesFromDevice];
}

- (void)retrieveImagesFromDevice
{

    self.assetFetchResults = @[[UIImage imageNamed:@"11.jpg"],
                               [UIImage imageNamed:@"callPhone.jpg"],
                               [UIImage imageNamed:@"i1.jpg"],
                               [UIImage imageNamed:@"13.jpg"],
                               [UIImage imageNamed:@"14.jpg"],
                               [UIImage imageNamed:@"icon.png"],
                               [UIImage imageNamed:@"16.jpg"],
                               [UIImage imageNamed:@"1000.png"],
                               [UIImage imageNamed:@"12.jpg"],
                               [UIImage imageNamed:@"15.jpg"],
                               [UIImage imageNamed:@"49.jpg"]];
    
//    NSString *path = [[NSBundle mainBundle] bundlePath];
//    NSFileManager *fm = [NSFileManager defaultManager];
//    NSArray *fileNames = [fm contentsOfDirectoryAtPath:path error:nil];
//    for (NSString *fileName in fileNames ) {
//        if ([fileName hasSuffix:@"jpg"] || [fileName hasSuffix:@"JPG"]) {
//            NSString *photoPath = [path stringByAppendingPathComponent:fileName];
//            
//             UIImage * aImage = [UIImage imageWithContentsOfFile:photoPath];
//            
//            [self.assetFetchResults addObject:aImage];
//        }
//    }
   
    
    
    
    
    
    
    [self.collectionView reloadData];
}

#pragma mark - <UICollectionViewDataSource>

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];


    UIImageView * img = [[UIImageView alloc] initWithFrame:cell.bounds];
    img.backgroundColor = [UIColor redColor];
    [cell addSubview:img];
    img.image =[self.assetFetchResults objectAtIndex:indexPath.row];
   

    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assetFetchResults.count;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.collectionViewSizeCalculator sizeForPhotoAtIndexPath:indexPath];
}

#pragma mark - <GreedoCollectionViewLayoutDataSource>

- (CGSize)greedoCollectionViewLayout:(GreedoCollectionViewLayout *)layout originalImageSizeAtIndexPath:(NSIndexPath *)indexPath
{
    // Return the image size to GreedoCollectionViewLayout
    if (indexPath.item < self.assetFetchResults.count) {
        UIImage * im = [self.assetFetchResults objectAtIndex:indexPath.row];
        return CGSizeMake(im.size.width,im.size.height);
    }

    return CGSizeMake(0.1, 0.1);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",@(indexPath.row));
}

#pragma mark - Lazy Loading

- (GreedoCollectionViewLayout *)collectionViewSizeCalculator
{
    if (!_collectionViewSizeCalculator) {
        _collectionViewSizeCalculator = [[GreedoCollectionViewLayout alloc] initWithCollectionView:self.collectionView];
        _collectionViewSizeCalculator.dataSource = self;
    }

    return _collectionViewSizeCalculator;
}

- (NSArray *)assetFetchResults
{
    if (!_assetFetchResults) {
        _assetFetchResults = [NSArray array];
    }
    
    return _assetFetchResults;
}


@end
