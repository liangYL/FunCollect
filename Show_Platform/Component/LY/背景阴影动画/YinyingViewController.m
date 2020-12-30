//
//  YinyingViewController.m
//  Yingshe
//
//  Created by liang on 15/4/1.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "YinyingViewController.h"

@interface YinyingViewController ()
@property (nonatomic, retain) UIImageView *bgImageView;
@property (nonatomic, assign) CGRect       leftRect;
@property (nonatomic, assign) CGRect       rightRect;
@property (nonatomic,assign)BOOL left;
@end

@implementation YinyingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 背景图(移动)
    self.bgImageView        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"301132181393097.jpg"]];
    _bgImageView.frame = self.view.bounds;
    _bgImageView.center = self.view.center;
    [self.view addSubview:_bgImageView];
    [_bgImageView release];
    
    // 存储必要的frame值
    CGRect  midRect = self.bgImageView.frame;
    CGFloat offsetX = 20.f;
    self.leftRect   = CGRectMake(midRect.origin.x - offsetX,
                                 midRect.origin.y,
                                 midRect.size.width,
                                 midRect.size.height);
    self.rightRect  = CGRectMake(midRect.origin.x + offsetX,
                                 midRect.origin.y,
                                 midRect.size.width,
                                 midRect.size.height);
    
    // 遮盖图(固定)
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"301131599359468.jpg"]];
    imageView.frame        = self.view.bounds;
    [self.view addSubview:imageView];
    [imageView release];
    
    _left = YES;

    //移动前先移动到右边
    [UIView animateWithDuration:2.f animations:^{
        _bgImageView.frame = _rightRect;
    }];
    
    //每2秒移动一次
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(animationBGImageViewWithDirection) userInfo:nil repeats:YES];
    
}


//执行动画
- (void)animationBGImageViewWithDirection{
    
    if (_left == YES) {
        [UIView animateWithDuration:2.f animations:^{
            _bgImageView.frame = _leftRect;
        }completion:^(BOOL finished){}];
    } else {
        [UIView animateWithDuration:2.f animations:^{
            _bgImageView.frame = _rightRect;
        }completion:^(BOOL finished){}];
    }
    _left = !_left;
 
}


- (void)dealloc
{
    [super dealloc];
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
