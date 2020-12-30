//
//  Sphere3DViewController.m
//  Show_Platform
//
//  Created by liang on 15/4/28.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "Sphere3DViewController.h"
#import "ZYQSphereView.h"
@interface Sphere3DViewController ()
@property (nonatomic, retain) ZYQSphereView *sphereView;

@end

@implementation Sphere3DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    
    NSArray *tags = @[@"导航", @"侧滑", @"标签", @"主题", @"列表", @"瀑布", @"图片", @"大图", @"链接", @"排版", @"菊花", @"音频", @"录音", @"音谱", @"存储", @"算法", @"相册", @"缓存", @"扩展", @"网络", @"下载", @"iOS7", @"手势", @"MVC"];
    
    self.sphereView = [[ZYQSphereView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.5 - 150, self.view.frame.size.height * 0.5 - 200, 300, 300)];
    self.sphereView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    //遍历数组相当于 for(in),效率可能稍微高一点
    [tags enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *tagView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        tagView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100. green:arc4random_uniform(100)/100. blue:arc4random_uniform(100)/100. alpha:1];
        [tagView setTitle:obj forState:UIControlStateNormal];
        tagView.layer.masksToBounds=YES;
        tagView.layer.cornerRadius=3;
        [tagView addTarget:self action:@selector(_tagButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [items addObject:tagView];
        [tagView release];
    }];
    [self.sphereView setItems:items];
    [self.view addSubview:self.sphereView];
    [_sphereView release];
    
    //标签云自动转动
    [self.sphereView timerStart];
    
  
    
}


-(void)_tagButtonAction:(UIButton*)sender{
    BOOL isStart=[self.sphereView isTimerStart];
    [self.sphereView timerStop];
    [UIView animateWithDuration:0.3 animations:^{
        sender.transform=CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            sender.transform=CGAffineTransformMakeScale(1, 1);
            if (isStart) {
                [self.sphereView timerStart];
            }
        }];
    }];
    NSLog(@"%@",sender.titleLabel.text);
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
