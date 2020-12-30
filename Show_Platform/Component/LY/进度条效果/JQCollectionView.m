//
//  JQCollectionView.m
//  
//
//  Created by James on 15/7/18.
//
//

#import "JQCollectionView.h"
#import "JQIndicatorView.h"

@interface JQCollectionView ()<UICollectionViewDelegateFlowLayout>

@end

@implementation JQCollectionView

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    //cell的大小
    layout.itemSize = CGSizeMake(100, 100);
    //上下间隔（上下滚动时）
    layout.minimumLineSpacing = 20;
    //左右间隔（上下滚动时）
    layout.minimumInteritemSpacing = 10;
    //设置区头视图宽高
    layout.headerReferenceSize = CGSizeMake(320, 50);
    //设置区尾视图高度
    layout.footerReferenceSize = CGSizeMake(320, 80);
    //分区间的间隔
    layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    
    //滚动方向
    //layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds  collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.delaysContentTouches = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    //集合视图必须通过注册的形式，如果没有可重用的cell，根据你注册的类型去创建cell
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.view addSubview:collectionView];
    [collectionView release];

    
    // Register cell classes
   // [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //用Integer代替枚举
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
        JQIndicatorView *indicator = [[JQIndicatorView alloc] initWithType:indexPath.row tintColor:[self randomColor]];
        indicator.tag = 101 + indexPath.row;
        
        indicator.center = cell.contentView.center;
        [cell.contentView addSubview:indicator];
        [indicator startAnimating];
    
    
    
    // Configure the cell
    
    return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 100);
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    JQIndicatorView *indicator = (JQIndicatorView *)[[collectionView cellForItemAtIndexPath:indexPath] viewWithTag:101+indexPath.row];
    if (indicator.isAnimating == YES) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定停止么？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            if (indicator.isAnimating == YES) {
                [indicator stopAnimating];
            }
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        [indicator startAnimating];
    }
}

#pragma mark - Others

- (UIColor *)randomColor{
    CGFloat red = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}
//
//- (IBAction)changeColor:(UIBarButtonItem *)sender {
//    [self.collectionView reloadData];
//}
@end
