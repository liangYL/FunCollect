//
//  ThreeCollectionViewController.m
//  Show_Platform
//
//  Created by liang on 15/6/3.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "ThreeCollectionViewController.h"
#import "SXLineLayout.h"
#import "SXCircleLayout.h"
#import "SXStackLayout.h"
#import "SXImageCell.h"
@interface ThreeCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
/** 所有的图片名 */
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, retain) UICollectionView *colViewA;
@property (nonatomic, retain) UICollectionView *colViewB;
@property (nonatomic, retain) UICollectionView *colViewC;

@end


@implementation ThreeCollectionViewController

static NSString *const ID = @"image";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    UIButton * waterFallBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    waterFallBtn1.frame = CGRectMake(15, 60, 60, 25);
    [waterFallBtn1 setTitle:@"瀑布流1" forState:UIControlStateNormal];
    waterFallBtn1.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [waterFallBtn1 addTarget:self action:@selector(click1) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:waterFallBtn1];
    waterFallBtn1.layer.borderWidth = 2;
    waterFallBtn1.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UIButton * waterFallBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    waterFallBtn2.frame = CGRectMake(self.view.lyWidth-75, 60, 60, 25);
    [waterFallBtn2 setTitle:@"瀑布流2" forState:UIControlStateNormal];
    waterFallBtn2.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [waterFallBtn2 addTarget:self action:@selector(click2) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:waterFallBtn2];
    waterFallBtn2.layer.borderWidth = 2;
    waterFallBtn2.layer.borderColor = [UIColor whiteColor].CGColor;
    
    // 创建布局
    SXStackLayout *layoutA = [[SXStackLayout alloc] init];
    SXLineLayout *layoutB = [[SXLineLayout alloc] init];
    SXCircleLayout *layoutC = [[SXCircleLayout alloc] init];

    
    // 创建collectionView
    self.colViewA = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150) collectionViewLayout:layoutA];
    _colViewA.dataSource = self;
    _colViewA.delegate = self;
    _colViewA.backgroundColor = [UIColor clearColor];
    //[collectionView registerNib:[UINib nibWithNibName:@"SXImageCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [_colViewA registerClass:[SXImageCell class] forCellWithReuseIdentifier:ID];
    [self.view addSubview:_colViewA];
    
    // 创建collectionView
    self.colViewB = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, 100) collectionViewLayout:layoutB];
    _colViewB.dataSource = self;
    _colViewB.delegate = self;
    _colViewB.backgroundColor = [UIColor clearColor];
    //[collectionView registerNib:[UINib nibWithNibName:@"SXImageCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [_colViewB registerClass:[SXImageCell class] forCellWithReuseIdentifier:ID];
    [self.view addSubview:_colViewB];
    
    // 创建collectionView
    self.colViewC = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, self.view.frame.size.height-300) collectionViewLayout:layoutC];
    _colViewC.dataSource = self;
    _colViewC.delegate = self;
    _colViewC.backgroundColor = [UIColor clearColor];
    //[collectionView registerNib:[UINib nibWithNibName:@"SXImageCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [_colViewC registerClass:[SXImageCell class] forCellWithReuseIdentifier:ID];
    [self.view addSubview:_colViewC];
    
    
    
    [self.view bringSubviewToFront:waterFallBtn1];
    [self.view bringSubviewToFront:waterFallBtn2];

    
}


#pragma mark - push 瀑布流

-(void)click1{
    [self.navigationController pushViewController:[[NSClassFromString(@"WaterFallCollectionViewController") alloc] init] animated:YES];
}
-(void)click2{
    [self.navigationController pushViewController:[[NSClassFromString(@"ImageCollectionViewControllerXC") alloc] init] animated:YES];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SXImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.image = self.images[indexPath.item];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 删除图片名
    [self.images removeObjectAtIndex:indexPath.item];
    
    // 刷新数据
   // [_colViewA reloadData];[_colViewB reloadData];[_colViewC reloadData];
    
    // 直接将cell删除
    [_colViewA deleteItemsAtIndexPaths:@[indexPath]];
    [_colViewB deleteItemsAtIndexPaths:@[indexPath]];
    [_colViewC deleteItemsAtIndexPaths:@[indexPath]];

}





- (NSMutableArray *)images
{
    if (!_images) {
        self.images = [[NSMutableArray alloc] init];
        
        int r= arc4random()%28;
        
        for (int i = r; i<=r+12; i++) {
            [self.images addObject:[NSString stringWithFormat:@"%d.jpg", i]];
        }
    }
    return _images;
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
