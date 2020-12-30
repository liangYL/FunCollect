//
//  ViewController.m
//  JSDropDownMenuDemo
//
//  Created by Jsfu on 15-1-12.
//  Copyright (c) 2015年 jsfu. All rights reserved.
//

#import "CategoryViewController.h"
#import "JSDropDownMenu.h"

#import "YCXMenu.h"

#import "DOPNavbarMenu.h"

#import "GooeySlideMenu.h"


@interface CategoryViewController ()<JSDropDownMenuDataSource,JSDropDownMenuDelegate,UITextViewDelegate, DOPNavbarMenuDelegate>{
 
    NSInteger _currentData1Index;
    NSInteger _currentData2Index;
    NSInteger _currentData3Index;
    
    GooeySlideMenu *menuF;
}
@property(retain,nonatomic)NSMutableArray *data1;
@property(retain,nonatomic)NSMutableArray *data2;
@property(retain,nonatomic)NSMutableArray *data3;

//第二种
@property(nonatomic,retain)NSMutableArray *items;

//第三种
@property (assign, nonatomic) NSInteger numberOfItemsInRow;
@property (strong, nonatomic) DOPNavbarMenu *menu;

//第四种

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    
    NSArray *food = @[@"全部美食", @"火锅", @"川菜", @"西餐", @"自助餐"];
    NSArray *travel = @[@"全部旅游", @"周边游", @"景点门票", @"国内游", @"境外游"];
    
    self.data1 = [NSMutableArray arrayWithObjects:@{@"title":@"美食", @"data":food}, @{@"title":@"旅游", @"data":travel}, nil];
    self.data2 = [NSMutableArray arrayWithObjects:@"智能排序", @"离我最近", @"评价最高", @"最新发布", @"人气最高", @"价格最低", @"价格最高", nil];
    self.data3 = [NSMutableArray arrayWithObjects:@"不限人数", @"单人餐", @"双人餐", @"3~4人餐",nil];
    
    //初始化起点和高
    JSDropDownMenu *menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:35];
    //小三角颜色
    menu.indicatorColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    //线条颜色
    menu.separatorColor = [UIColor colorWithRed:1.000 green:0.502 blue:0.000 alpha:1.000];
    //字体颜色
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    menu.dataSource = self;
    menu.delegate = self;
    
    [self.view addSubview:menu];
    
    /*---第二种---*/
    UIButton * lefbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [lefbtn setTitle:@"点击" forState: UIControlStateNormal];
    lefbtn.backgroundColor =[UIColor whiteColor];
    [lefbtn addTarget:self action:@selector(leClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lefbtn];
    [lefbtn setMargin:UIEdgeInsetsMake(100, 10, X, X)];
    [lefbtn setSizeView:CGSizeMake(60, 30)];
    
    UIButton * rigbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [rigbtn setTitle:@"点击" forState: UIControlStateNormal];
    rigbtn.backgroundColor =[UIColor whiteColor];
    [rigbtn addTarget:self action:@selector(riClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rigbtn];
    [rigbtn setMargin:UIEdgeInsetsMake(100, X, X,10)];
    [rigbtn setSizeView:CGSizeMake(60, 30)];
    
    /*---第三种---*/
    self.numberOfItemsInRow = 3;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"menu" style:UIBarButtonItemStylePlain target:self action:@selector(openMenu:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    
    /*---第四种,左边弹出---*/
    menuF = [[GooeySlideMenu alloc]initWithTitles:@[@"首页",@"消息",@"发布",@"发现",@"个人",@"设置"]];
    menuF.menuClickBlock = ^(NSInteger index,NSString *title,NSInteger titleCounts){
        
        NSLog(@"index:%ld title:%@ titleCounts:%ld",index,title,titleCounts);
    };

    UIButton * ftn = [UIButton buttonWithType:UIButtonTypeSystem];
    [ftn setTitle:@"trigger" forState: UIControlStateNormal];
    ftn.backgroundColor =[UIColor whiteColor];
    [ftn addTarget:self action:@selector(fClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ftn];
    [ftn setMargin:UIEdgeInsetsMake(X, X, 40,10)];
    [ftn setSizeView:CGSizeMake(60, 30)];
    
    UIButton * ltn = [UIButton buttonWithType:UIButtonTypeSystem];
    [ltn setTitle:@"开/关" forState: UIControlStateNormal];
    ltn.backgroundColor =[UIColor whiteColor];
    [ltn addTarget:self action:@selector(ltClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ltn];
    [ltn setMargin:UIEdgeInsetsMake(X, 10, 40,X)];
    [ltn setSizeView:CGSizeMake(60, 30)];
    
    
}
//标题几列
- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 3;
}
//是否需要显示为UICollectionView 默认为否
-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    
    if (column==2) {
        return YES;
    }
    return NO;
}
//是否需要两个表显示
-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    if (column==0) {
        return YES;
    }
    return NO;
}
//如果是两个表设置比例
-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    if (column==0) {
        return 0.3;
    }
    
    return 1;
}
//左边表选中
-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column==0) {
        
        return _currentData1Index;
        
    }
    if (column==1) {
        
        return _currentData2Index;
    }
        
    return 0;
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    if (column==0) {
        if (leftOrRight==0) {
            
            return _data1.count;
        } else{
            
            NSDictionary *menuDic = [self.data1 objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] count];
        }
    } else if (column==1){
        
        return _data2.count;
        
    } else if (column==2){
        
        return _data3.count;
    }
    
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    switch (column) {
        case 0: return [[_data1[0] objectForKey:@"data"] objectAtIndex:0];
            break;
        case 1: return _data2[0];
            break;
        case 2: return _data3[0];
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column==0) {
        if (indexPath.leftOrRight==0) {
            NSDictionary *menuDic = [_data1 objectAtIndex:indexPath.row];
            return [menuDic objectForKey:@"title"];
        } else{
            NSInteger leftRow = indexPath.leftRow;
            NSDictionary *menuDic = [_data1 objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
        }
    } else if (indexPath.column==1) {
        
        return _data2[indexPath.row];
        
    } else {
        
        return _data3[indexPath.row];
    }
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        
        if(indexPath.leftOrRight==0){
            
            _currentData1Index = indexPath.row;
            
            return;
        }
        
    } else if(indexPath.column == 1){
        
        _currentData2Index = indexPath.row;
        
    } else{
        
        _currentData3Index = indexPath.row;
    }
}


-(NSMutableArray*)data1{
    if (!_data1) {
        self.data1 = [NSMutableArray array];
    }
    return _data1;
}

-(NSMutableArray*)data2{
    if (!_data2) {
        self.data2 = [NSMutableArray array];
    }
    return _data2;
}

-(NSMutableArray*)data3{
    if (!_data3) {
        self.data3 = [NSMutableArray array];
    }
    return _data3;
}

#pragma mark------------YCXmenu 相关

-(void)leClick:(UIButton *)sender{
    [YCXMenu setHasShadow:YES];
    [YCXMenu setBackgrounColorEffect:YCXMenuBackgrounColorEffectGradient];
    [YCXMenu setTintColor:[UIColor colorWithRed:0.212 green:0.255 blue:0.678 alpha:1]];
    [YCXMenu showMenuInView:self.view fromRect:sender.frame menuItems:self.items selected:^(NSInteger index, YCXMenuItem *item) {
        NSLog(@"%@",item);
    }];

}

-(void)riClick:(UIButton *)sender{
    //显示阴影
    [YCXMenu setHasShadow:YES];
    [YCXMenu setBackgrounColorEffect:YCXMenuBackgrounColorEffectSolid];
    [YCXMenu setTintColor:[UIColor redColor]];
    //字体大小可能改变弹出框大小
    [YCXMenu setTitleFont:[UIFont systemFontOfSize:13.0]];
    [YCXMenu showMenuInView:self.view fromRect:sender.frame menuItems:self.items selected:^(NSInteger index, YCXMenuItem *item) {
        NSLog(@"%@",item);
    }];

}






- (NSMutableArray *)items {
    if (!_items) {
        
        //设置标题
        YCXMenuItem *menuTitle = [YCXMenuItem menuTitle:@"主菜单" WithIcon:nil];
        menuTitle.foreColor = [UIColor blackColor];
        menuTitle.titleFont = [UIFont boldSystemFontOfSize:20.0f];
        
        //设置 logout 按钮属性
        YCXMenuItem *logoutItem = [YCXMenuItem menuItem:@"退出" image:nil target:self action:@selector(logout:)];
        logoutItem.foreColor = [UIColor redColor];
        logoutItem.alignment = NSTextAlignmentCenter;
        
        //设置菜单组
        _items = [@[menuTitle,
                    [YCXMenuItem menuItem:@"个人中心"
                                    image:nil
                                      tag:1100
                                 userInfo:@{@"title":@"Menu"}],
                    [YCXMenuItem menuItem:@"ACTION 133"
                                    image:nil
                                      tag:1101
                                 userInfo:@{@"title":@"Menu"}],
                    [YCXMenuItem menuItem:@"检查更新"
                                    image:nil
                                      tag:1102
                                 userInfo:@{@"title":@"Menu"}],
                    logoutItem
                    ] mutableCopy];
    }
    return _items;
}

- (void)logout:(id)sender {
    NSLog(@"退出登录");
}


#pragma mark------------第三种 相关

- (DOPNavbarMenu *)menu {
    if (_menu == nil) {
        DOPNavbarMenuItem *item1 = [DOPNavbarMenuItem ItemWithTitle:@"第一章" icon:[UIImage imageNamed:@"30-30-3"]];
        _menu = [[DOPNavbarMenu alloc] initWithItems:@[item1,item1,item1,item1,item1,item1,item1] width:self.view.dop_width maximumNumberInRow:_numberOfItemsInRow];
        _menu.backgroundColor = [UIColor blackColor];
        _menu.separatarColor = [UIColor whiteColor];
        _menu.delegate = self;
    }
    return _menu;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.menu) {
        [self.menu dismissWithAnimation:NO];
    }
}
- (void)openMenu:(id)sender {
    self.navigationItem.rightBarButtonItem.enabled = NO;
    if (self.menu.isOpen) {
        [self.menu dismissWithAnimation:YES];
    } else {
        [self.menu showInNavigationController:self.navigationController];
    }
}

- (void)didShowMenu:(DOPNavbarMenu *)menu {
    [self.navigationItem.rightBarButtonItem setTitle:@"dismiss"];
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)didDismissMenu:(DOPNavbarMenu *)menu {
    [self.navigationItem.rightBarButtonItem setTitle:@"menu"];
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)didSelectedMenu:(DOPNavbarMenu *)menu atIndex:(NSInteger)index {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"you selected" message:[NSString stringWithFormat:@"number %@", @(index+1)] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [av show];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.numberOfItemsInRow = [textView.text integerValue];
    self.menu = nil;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    self.menu = nil;
}
//--------

#pragma mark --左边弹出菜单
-(void)fClick{
    [menuF trigger];
}
#pragma mark -------跳转
-(void)ltClick{
    
    [self.navigationController pushViewController:[[NSClassFromString(@"LYkgViewController") alloc] init] animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
