//
//  MoveImgViewController.m
//  
//
//  Created by liang on 15/11/25.
//
//

#import "MoveImgViewController.h"
#import "XTLoopScrollView.h"
#import "SDCycleScrollView.h"

@interface MoveImgViewController ()

@end

@implementation MoveImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    
//-------1.XT 方法(图片不适应 view)
    NSArray * arrayImg = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg"];
    
    
    XTLoopScrollView *loopScroll = [[XTLoopScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.lyWidth, 120) andImageList:arrayImg canLoop:YES duration:2.0] ;
    //loopScroll.delegate = self;//有代理
    loopScroll.color_pageControl =[UIColor grayColor];
    loopScroll.color_currentPageControl = [UIColor redColor] ;
    [self.view addSubview:loopScroll] ;
    
//---------2.SDCycle 方法(图片适应 view)
    // 情景一：采用本地图片实现
    NSArray *images = @[[UIImage imageNamed:@"11.jpg"],
                        [UIImage imageNamed:@"12.jpg"],
                        [UIImage imageNamed:@"13.jpg"],
                        [UIImage imageNamed:@"14.jpg"],
                        [UIImage imageNamed:@"15.jpg"],
                        [UIImage imageNamed:@"16.jpg"],
                        [UIImage imageNamed:@"17.jpg"]
                        ];
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    // 情景三：图片配文字
    NSArray *titles = @[@"感谢您的支持，如果下载的",
                        @"如果代码在使用过程中出现问题",
                        @"您可以发邮件到gsdios@126.com",
                        @"感谢您的支持"
                        ];

    CGFloat w = self.view.bounds.size.width;
    
    // 本地加载 --- 创建不带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(100, loopScroll.lyBottom+20, w-200, 180) imagesGroup:images];
    cycleScrollView.infiniteLoop = YES;
//    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.view addSubview:cycleScrollView];
    //         --- 轮播时间间隔，默认1.0秒，可自定义
    //cycleScrollView.autoScrollTimeInterval = 4.0;
    
    //网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, cycleScrollView.lyBottom+20, w, 100) imageURLStringsGroup:imagesURLStrings]; // 模拟网络延时情景
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    cycleScrollView2.delegate = self;
    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.dotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    cycleScrollView2.placeholderImage = [UIImage imageNamed:@"u=404741989,2424926641&fm=21&gp=0.jpg"];
    [self.view addSubview:cycleScrollView2];

    
    // 清除缓存
   // [cycleScrollView2 clearCache];
    
    
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
