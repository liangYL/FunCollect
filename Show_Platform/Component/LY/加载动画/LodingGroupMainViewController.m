//
//  LodingGroupMainViewController.m
//  
//
//  Created by liang on 16/2/16.
//
//

#import "LodingGroupMainViewController.h"

@interface LodingGroupMainViewController ()

@end

@implementation LodingGroupMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton * a = [UIButton newAutoLayoutView];
    a.backgroundColor = RandomColorLight;
    [a setTitle:@"32中加载动画" forState:UIControlStateNormal];
    a.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:a];
    
    UIButton *b = [UIButton newAutoLayoutView];
    b.backgroundColor = RandomColorLight;
    [b setTitle:@"M13的动画" forState:UIControlStateNormal];
    b.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:b];
    
    
    NSArray * views = @[a,b];
    
    //设置高40
    [views autoSetViewsDimension:ALDimensionWidth toSize:140.0];
    //设置横成一排
    [views autoDistributeViewsAlongAxis:ALAxisVertical withFixedSpacing:50 insetSpacing:YES alignment:NSLayoutFormatAlignAllCenterX];
    //设置第一个离顶部100,后面都受影响
    [a autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:100];
    
    //添加方法
    [a addTarget:self action:@selector(a) forControlEvents:UIControlEventTouchUpInside];
    [b addTarget:self action:@selector(b) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark----跳转
-(void)a{
    [self.navigationController pushViewController:[[NSClassFromString(@"LoadingEffectViewController") alloc] init] animated:YES];
}
-(void)b{
    [self.navigationController pushViewController:[[NSClassFromString(@"M13MainViewController") alloc] init] animated:YES];
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
