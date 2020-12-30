//
//  LYSwitchVCViewController.m
//  
//
//  Created by liang on 15/12/18.
//
//

#import "LYSwitchVCViewController.h"

#import "SwitchViewController.h"
#import "YZTXViewController.h"
#import "YZJRViewController.h"
#import "YZWYViewController.h"
#import "YZXiMaViewController.h"

@interface LYSwitchVCViewController ()

@end

@implementation LYSwitchVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton * a = [UIButton newAutoLayoutView];
    a.backgroundColor = RandomColor;
    [a setTitle:@"类喜马拉雅(上下标)" forState:UIControlStateNormal];
    a.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:a];
    UIButton *b = [UIButton newAutoLayoutView];
    b.backgroundColor = RandomColor;
    [b setTitle:@"腾讯视频(圆角)" forState:UIControlStateNormal];
    b.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self.view addSubview:b];
    
    UIButton *c = [UIButton newAutoLayoutView];
    c.backgroundColor = RandomColor;
    [c setTitle:@"今日头条(渐变)" forState:UIControlStateNormal];
    c.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:c];
    
    UIButton *d = [UIButton newAutoLayoutView];
    d.backgroundColor = RandomColor;
    [d setTitle:@"网易新闻(缩放)" forState:UIControlStateNormal];
    d.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:d];
    
    UIButton *e = [UIButton newAutoLayoutView];
    e.backgroundColor = RandomColor;
    [e setTitle:@"喜马拉雅(下标)" forState:UIControlStateNormal];
    e.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:e];
    
    NSArray * views = @[a,b,c,d,e];
    
    //设置高40
    [views autoSetViewsDimension:ALDimensionWidth toSize:140.0];
    //设置横成一排
    [views autoDistributeViewsAlongAxis:ALAxisVertical withFixedSpacing:30 insetSpacing:YES alignment:NSLayoutFormatAlignAllCenterX];
    //设置第一个离顶部100,后面都受影响
    [a autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:100];
    
    
    
    [a addTarget:self action:@selector(aClick) forControlEvents:UIControlEventTouchUpInside];
    [b addTarget:self action:@selector(bClick) forControlEvents:UIControlEventTouchUpInside];
    [c addTarget:self action:@selector(cClick) forControlEvents:UIControlEventTouchUpInside];
    [d addTarget:self action:@selector(dClick) forControlEvents:UIControlEventTouchUpInside];
    [e addTarget:self action:@selector(eClick) forControlEvents:UIControlEventTouchUpInside];

    
    
    
    
    
}

-(void)aClick{
    SwitchViewController * sw = [[SwitchViewController alloc] init];
    [self.navigationController pushViewController:sw animated:YES];
}
-(void)bClick{
    YZTXViewController * sw1 = [[YZTXViewController alloc] init];
    [self.navigationController pushViewController:sw1 animated:YES];
}
-(void)cClick{
    YZJRViewController * sw2 = [[YZJRViewController alloc] init];
    [self.navigationController pushViewController:sw2 animated:YES];
}
-(void)dClick{
    YZWYViewController * sw3 = [[YZWYViewController alloc] init];
    [self.navigationController pushViewController:sw3 animated:YES];
}
-(void)eClick{
    YZXiMaViewController * sw4 = [[YZXiMaViewController alloc] init];
    [self.navigationController pushViewController:sw4 animated:YES];
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
