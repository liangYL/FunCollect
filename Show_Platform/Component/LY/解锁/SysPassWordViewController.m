//
//  SysPassWordViewController.m
//  
//
//  Created by liang on 15/12/10.
//
//

#import "SysPassWordViewController.h"
#import "CopyiPhoneFadeView.h"
#import "MimaViewController.h"

@interface SysPassWordViewController ()<MimaViewDelegate>
@property(nonatomic,retain)UILabel * aLabel;
@property(nonatomic,retain)UIView * mimaView;
@property(nonatomic,retain)UILabel * timLabel;
@end

@implementation SysPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    CGRect ff =[[UIScreen mainScreen] bounds];

    UIImage * img                   = [UIImage imageNamed:@"222.png"];
    self.view.layer.contents        = (id)img.CGImage;
    self.view.layer.backgroundColor = [UIColor clearColor].CGColor;
    
   
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiperight)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight; //往右扫
    [self.view addGestureRecognizer:swipe];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 20, 50, 40);
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    
    
    //键盘界面
    self.mimaView  = [[UIView alloc] initWithFrame:CGRectMake(-ff.size.width, 30, ff.size.width, ff.size.height-20)];
    _mimaView.backgroundColor = [UIColor whiteColor];
    _mimaView.userInteractionEnabled = YES;
    [self.view addSubview:_mimaView];
    
    MimaViewController * mima = [[MimaViewController alloc] initWithFrame:ff];
    mima.delegate = self;
    mima.userInteractionEnabled = YES;
    [_mimaView addSubview:mima];
     mima.backgroundColor = [[UIColor colorWithRed:0.031 green:0.055 blue:0.059 alpha:1.000] colorWithAlphaComponent:0.99];//背景色半透明
    
    UISwipeGestureRecognizer * swipeMima = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeMima)];
    swipeMima.direction = UISwipeGestureRecognizerDirectionLeft; //往右扫
    [_mimaView addGestureRecognizer:swipeMima];
    
    
    self.timLabel = [[UILabel alloc] initWithFrame:CGRectMake((ff.size.width-200)/2+ff.size.width, 40, 200, 100)];
    _timLabel.textAlignment = NSTextAlignmentCenter;
    _timLabel.font = [UIFont fontWithName:@"GillSans-Light" size:70];//KhmerSangamMN,GujaratiSangamMN,HelveticaNeue-Light,GillSans-Light
    _timLabel.backgroundColor = [UIColor clearColor];
    _timLabel.textColor = [UIColor whiteColor];
    [_mimaView addSubview:_timLabel];
    NSDate * date = [[NSDate alloc]init];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"hh:mm"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    _timLabel.text = dateString;
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onon) userInfo:nil repeats:YES];

    
    //滑动解锁 label
    CopyiPhoneFadeView *iphoneFade = [[CopyiPhoneFadeView alloc] initWithFrame:CGRectMake((ff.size.width-220)/2+ff.size.width, 0, 220, 40)];
    iphoneFade.text = @"＞ 滑动来解锁";
    iphoneFade.foreColor = [UIColor whiteColor];
    iphoneFade.backColor = [UIColor grayColor];
    iphoneFade.font = [UIFont systemFontOfSize:23.0];
    iphoneFade.alignment = NSTextAlignmentCenter;
    iphoneFade.center = CGPointMake(self.view.bounds.size.width/2.0+ff.size.width, ff.size.height-90);
    [_mimaView addSubview:iphoneFade];
    
    [iphoneFade iPhoneFadeWithDuration:2];// 速度
    
    
    
    //隐藏电池导航
    [super.navigationController setNavigationBarHidden:YES animated:YES];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    
}



- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

-(void)swiperight{
    NSLog(@"++++");
    CGRect ff =[[UIScreen mainScreen] bounds];
    [UIView animateWithDuration:0.2 animations:^{
        _mimaView.frame = CGRectMake(0, 30,ff.size.width, ff.size.height-20);
    }];
    
}
-(void)swipeMima{
    CGRect ff =[[UIScreen mainScreen] bounds];
    [UIView animateWithDuration:0.2 animations:^{
        _mimaView.frame = CGRectMake(-ff.size.width, 30,ff.size.width, ff.size.height-20);
    }];
}


-(void)quxiaoClick{
    [self swipeMima];
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    [super.navigationController setNavigationBarHidden:NO animated:YES];

}
-(void)viewWillDisappear:(BOOL)animated{
    [_mimaView removeFromSuperview];
}

-(void)onon{
    //当前时间
    NSDate * date = [[NSDate alloc]init];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"hh:mm"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    _timLabel.text = dateString;
    NSLog(@"date -- %@",dateString);
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
