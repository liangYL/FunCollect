//
//  HomeViewController.m
//  Show_Platform
//
//  Created by liang on 15/3/23.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "HomeViewController.h"
#import "UIView+AutoLayout.h"

#import "FLEXManager.h"
#import "prefixVCA.h"


@interface HomeViewController ()
@property (nonatomic,retain) NSArray * dataArray;



@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.146 green:0.704 blue:0.500 alpha:1.000];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"演示示例";
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 40);
    [rightBtn setTitle:@"结构解析" forState:UIControlStateNormal];
    rightBtn.titleLabel.font =[UIFont systemFontOfSize:14.0];
    [rightBtn addTarget:self action:@selector(showFlex) forControlEvents: UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:rightBtn] autorelease];
    
    
    
    
    UITableView * showTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    showTableView.delegate = self;
    showTableView.dataSource = self;
    showTableView.translatesAutoresizingMaskIntoConstraints = NO;
    showTableView.rowHeight = 50;
    [self.view addSubview:showTableView];
    [showTableView setMargin:UIEdgeInsetsMake(0, 0, 0, 0)];

    self.dataArray = @[@[@"测试_001",@"TestViewController"],
                       @[@"卡片浏览",@"LYCardBrowseViewController"],
                       @[@"进度条",@"ProgressViewController"],
                       @[@"加载动画",@"LodingGroupMainViewController"],
                       @[@"弹出按钮",@"PopBtnViewController"],
                       @[@"背景动画",@"YinyingViewController"],
                       @[@"二维码",@"TiaoxingmaViewController"],
                       @[@"引导页",@"YindaoyeViewController"],
                       @[@"下拉刷新动画",@"DonghuaViewController"],
                       @[@"动画组",@"LYAnimationViewController"],
                       @[@"地址选择",@"LMMainViewController"],
                       @[@"摇一摇",@"Yao1YaoViewController"],
                       @[@"各种按钮效果",@"DifEffectButtonViewController"],
                       @[@"各种图片展示效果",@"MoreShowEffectViewController"],
                       @[@"弹出提示框",@"WKAlerViewController"],
                       @[@"图片流动显示",@"XYZViewController"],
                       @[@"用户头像和评分",@"UserInfoViewController"],
                       @[@"3D标签云",@"Sphere3DViewController"],
                       @[@"滑动视图左右切换",@"LYSwitchVCViewController"],
                       @[@"拼图",@"PuzzleViewController"],
                       @[@"语音拍照",@"VoicePictureViewController"],
                       @[@"瀑布流及其他layout效果",@"ThreeCollectionViewController"],
                       @[@"分类选择",@"CategoryViewController"],
                       @[@"全景图浏览",@"PanoramaImgViewController"],
                       @[@"地图定位",@"LocationViewController"],
                       @[@"图形类",@"TuXingClassViewController"],
                       @[@"字体库",@"FontTypeViewController"],
                       @[@"音乐播放器(锁屏)",@"LYMusicViewController"],
                       @[@"图片浏览器",@"PhotoBrowserViewController"],
                       @[@"绘图功能",@"DrawCorrelationViewController"],
                       @[@"一些3D 效果",@"Some3DEffectViewController"],
                       @[@"轮播图",@"MoveImgViewController"],
                       @[@"几种解锁方式",@"LYLockAboutViewController"],
                       @[@"几种粒子效果",@"LYDazzleMainViewController"],
                       @[@"WIFI传输",@"LYWifiViewController"],
                       @[@"js效果汇总",@"LYJSViewController"]
                       
                       ];
    
    
   
    
}

#pragma mark  UITableViewDelegate,DataSource, -- UiTableView方法
//区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}
////行高(建议用 rowHeight)
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 50;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static  NSString *str =@"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:str];
    if (cell ==nil)
    {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
    }
    NSString * strr = [NSString stringWithFormat:@"%ld.   %@",(long)indexPath.row,[[self.dataArray objectAtIndex:indexPath.row] firstObject]];
    cell.textLabel.text = strr;
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}

//选中行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    NSString * nameVC = [[self.dataArray objectAtIndex:indexPath.row] lastObject];
    [self.navigationController pushViewController:[[NSClassFromString(nameVC) alloc] init] animated:YES];
}
#pragma mark  --弹出showFlex

-(void)showFlex{
     [[FLEXManager sharedManager] showExplorer];
}


#pragma mark  --懒加载
- (NSArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [NSArray array];
    }
    return _dataArray;
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
