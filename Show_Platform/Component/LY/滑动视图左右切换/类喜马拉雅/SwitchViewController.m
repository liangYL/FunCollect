//
//  SwitchViewController.m
//  Show_Platform
//
//  Created by liang on 15/4/28.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "SwitchViewController.h"
#import "SUNSlideSwitchView.h"
#import "SwitchMainViewController.h"
@interface SwitchViewController ()
@property (nonatomic, retain)SUNSlideSwitchView *slideSwitchView;
@property (nonatomic, retain) NSArray *dataSource;
@end

@implementation SwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSArray *configs = @[
                         @{@"title":@"所有", @"method":@"category/10"},
                         @{@"title":@"电影", @"method":@"category/1"},
                         @{@"title":@"电视剧", @"method":@"category/2"},
                         @{@"title":@"音乐", @"method":@"category/3"},
                         @{@"title":@"小说", @"method":@"category/11"},
                         @{@"title":@"活动", @"method":@"category/12"},
                         @{@"title":@"会议", @"method":@"category/14"}
                         ];
    NSMutableArray *dataSource = [NSMutableArray arrayWithCapacity:5];
    [configs enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
        SwitchMainViewController * viewController = [[SwitchMainViewController alloc] init];
        viewController.view.backgroundColor = RandomColor;
        viewController.title = [obj objectForKey:@"title"];
        [dataSource addObject:viewController];
    }];
    self.dataSource = dataSource;
    self.hidesBottomBarWhenPushed = YES;
    
    
    self.slideSwitchView = [[SUNSlideSwitchView alloc] initWithFrame:self.view.bounds];
    self.slideSwitchView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.slideSwitchView.tabItemNormalColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    self.slideSwitchView.tabItemSelectedColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.502 alpha:1.000];
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    self.slideSwitchView.slideSwitchViewDelegate = self;
    [self.slideSwitchView buildUI];
    [self.view addSubview:self.slideSwitchView];

    
    
}

- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view {
    return self.dataSource.count;
}

- (UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number {
    if (number >= self.dataSource.count) {
        return nil;
    }
    return self.dataSource[number];
}


- (void)slideSwitchView:(SUNSlideSwitchView *)view didselectTab:(NSUInteger)number {
    if (number >= self.dataSource.count) {
        return;
    }
    SwitchMainViewController *beautyViewController = self.dataSource[number];
    [beautyViewController viewDidCurrentView:[NSString stringWithFormat:@"%lu",(unsigned long)number]];
    
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
