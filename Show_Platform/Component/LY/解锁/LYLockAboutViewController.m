//
//  LYLockAboutViewController.m
//  
//
//  Created by liang on 15/12/10.
//
//

#import "LYLockAboutViewController.h"

@interface LYLockAboutViewController ()

@end

@implementation LYLockAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton * a = [UIButton newAutoLayoutView];
    a.backgroundColor = [UIColor redColor];
    [a setTitle:@"系统密码解锁" forState:UIControlStateNormal];
    a.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:a];
    UIButton *b = [UIButton newAutoLayoutView];
    b.backgroundColor = [UIColor colorWithRed:1.000 green:0.502 blue:0.000 alpha:1.000];
    [b setTitle:@"手势解锁(支付宝)" forState:UIControlStateNormal];
    b.titleLabel.font = [UIFont systemFontOfSize:14];

    [self.view addSubview:b];
    
    UIButton *c = [UIButton newAutoLayoutView];
    c.backgroundColor = [UIColor blueColor];
    [c setTitle:@"指纹解锁" forState:UIControlStateNormal];
    c.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:c];
    
    NSArray * views = @[a,b,c];
    
    //UIView+autoLayout方法
//    //设置高40
//    [views autoSetViewsDimension:ALDimensionHeight toSize:40.0];
//    //设置横成一排
//    [views autoDistributeViewsAlongAxis:ALAxisHorizontal withFixedSpacing:10 insetSpacing:YES alignment:NSLayoutFormatAlignAllCenterY];
//    //设置第一个离顶部100,后面都受影响
//    [a autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
    
    
    //masonry 方法(横屏)
//    [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:10 tailSpacing:10];
//    [views mas_makeConstraints:^(MASConstraintMaker *make) {
//        makeTop(100);
//        makeHeight(40);
//    }];
    
     //masonry 方法(竖屏)
    [views mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:25 leadSpacing:80 tailSpacing:80];
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        makeLeft(60);
        makeRight(-60);
    }];
    
    
    [a addTarget:self action:@selector(aClick) forControlEvents:UIControlEventTouchUpInside];
    [b addTarget:self action:@selector(bClick) forControlEvents:UIControlEventTouchUpInside];
    [c addTarget:self action:@selector(cClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

-(void)aClick{
     [self.navigationController pushViewController:[[NSClassFromString(@"SysPassWordViewController") alloc] init] animated:YES];
}

-(void)bClick{
     [self.navigationController pushViewController:[[NSClassFromString(@"GesturesUnlockViewController") alloc] init] animated:YES];
}
-(void)cClick{
    [self.navigationController pushViewController:[[NSClassFromString(@"FingerprintViewController") alloc] init] animated:YES];
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
