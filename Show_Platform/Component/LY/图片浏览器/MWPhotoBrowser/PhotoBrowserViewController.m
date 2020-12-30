//
//  PhotoViewController.m
//  post
//
//  Created by liang on 15/7/4.
//  Copyright (c) 2015年 liang. All rights reserved.
//

//git地址
//https://github.com/mwaterfall/MWPhotoBrowser

#import "PhotoBrowserViewController.h"
#import "MWCaptionView.h"
#import "MWPhoto.h"
#import "MWPhotoBrowser.h"

@interface PhotoBrowserViewController ()<MWPhotoBrowserDelegate>


@property(nonatomic,retain)NSMutableArray *photos;
@end

@implementation PhotoBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
//    MWPhoto * photo = [MWPhoto photoWithURL:[NSURL URLWithString:@"https://ss0.baidu.com/73F1bjeh1BF3odCf/it/u=611494095,3700309934&fm=96&s=E8BB21D500F3C596B1A0B54A0300F033"]];
//    photo.caption = @"aaaaaaaaaaaaaaaaaaaaa";
//    [_photos addObject:photo];
//    
//    MWPhoto * photo1 = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"2" ofType:@"jpg"]]];
//    photo1.caption = @"aaaaaaaaaaaaaaaaaaaaa";
//    [_photos addObject:photo1];
    
    [self loadingDataArray];
    
    
//    UIButton *aBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    [aBtn setTitle:@"浏览图片" forState:UIControlStateNormal];
//    [aBtn addTarget:self action:@selector(open) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:aBtn];
//    [aBtn setMargin:UIEdgeInsetsMake(100, 100, X, 100)];
//    [aBtn setHight:40];
//    
//    UIButton *bBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    [bBtn setTitle:@"图片多选" forState:UIControlStateNormal];
//    [bBtn addTarget:self action:@selector(imgMultiSelect) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:bBtn];
//    [bBtn setMargin:UIEdgeInsetsMake(160, 100, X, 100)];
//    [bBtn setHight:40];
    
    UIButton * a = [UIButton newAutoLayoutView];
    a.backgroundColor = RandomColor;
    [a setTitle:@"图片浏览" forState:UIControlStateNormal];
    a.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:a];

    UIButton *b = [UIButton newAutoLayoutView];
    b.backgroundColor = RandomColor;
    [b setTitle:@"相册选择" forState:UIControlStateNormal];
    b.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:b];
    
//    UIButton *c = [UIButton newAutoLayoutView];
//    c.backgroundColor = [UIColor blueColor];
//    [c setTitle:@"指纹解锁" forState:UIControlStateNormal];
//    c.titleLabel.font = [UIFont systemFontOfSize:14];
//    [self.view addSubview:c];
    
    NSArray * views = @[a,b];
    
    //设置高40
    [views autoSetViewsDimension:ALDimensionWidth toSize:140.0];
    //设置横成一排
    [views autoDistributeViewsAlongAxis:ALAxisVertical withFixedSpacing:50 insetSpacing:YES alignment:NSLayoutFormatAlignAllCenterX];
    //设置第一个离顶部100,后面都受影响
    [a autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:100];
    
    
    
    [a addTarget:self action:@selector(open) forControlEvents:UIControlEventTouchUpInside];
    [b addTarget:self action:@selector(imgMultiSelect) forControlEvents:UIControlEventTouchUpInside];
   // [c addTarget:self action:@selector(cClick) forControlEvents:UIControlEventTouchUpInside];
    

    
   
    
}
#pragma mark---- 图片多选
-(void)imgMultiSelect{
    [self.navigationController pushViewController:[[NSClassFromString(@"JFMultiSelectController") alloc] init] animated:YES];
}

#pragma mark---- 图片浏览器
-(void)loadingDataArray{
    for (int i = 0; i<98; i++) {
        MWPhoto * photo1 = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d",i] ofType:@"jpg"]]];
        photo1.caption = [NSString stringWithFormat:@"这是第%d张图片",i+1];
        [self.photos addObject:photo1];
    }
 
}

-(void)open{
    MWPhotoBrowser *browser = [[[MWPhotoBrowser alloc] initWithDelegate:self] autorelease];
    //显示操作按钮允许分享、复制等(默认为YES)
    browser.displayActionButton = YES;
    //是否在工具栏显示左和右导航箭头(默认NO)
    browser.displayNavArrows = YES;
    //选择按钮是否显示在每个图像(默认NO)
    browser.displaySelectionButtons = YES;
    //切换图片:nav,toolbar是否显示-> yes 显示, no 不显示(默认NO)
    browser.alwaysShowControls =NO;
    //图像充满全屏
    browser.zoomPhotosToFill = NO;
    //是否允许查看所有图片缩略图的网格(默认为YES)
    browser.enableGrid = YES;
    //yes 直接进网格, no 进单张图片浏览(默认 NO)
    browser.startOnGrid =  NO;
    // browser.enableSwipeToDismiss = NO;
    
    
    // Manipulate
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    //从第几张显示
    [browser setCurrentPhotoIndex:0];
    
    [self.navigationController pushViewController:browser animated:YES];
}


- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return self.photos.count;
}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
    return nil;
}
//网格
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
    return nil;
}
//自定义
//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index{
//    MWPhoto *photo = [_photos objectAtIndex:index];
//    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
//    return captionView;
//}
//可以设置标题
//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index{
//    return @"haha";
//}





-(NSMutableArray *)photos{
    if (!_photos) {
        self.photos = [NSMutableArray array];
    }
    return _photos;
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
