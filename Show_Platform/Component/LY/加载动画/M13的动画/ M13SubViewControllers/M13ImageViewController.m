//
//  M13LoadingViewController.m
//  
//
//  Created by liang on 16/2/16.
//
//

#import "M13ImageViewController.h"
#import "M13ProgressViewImage.h"

@interface M13ImageViewController ()
@property(nonatomic,retain)M13ProgressViewImage * imgView;

@end

@implementation M13ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat ringW =self.view.lyWidth-200;
    
    _imgView = [[M13ProgressViewImage alloc] initWithFrame:CGRectMake(100, 50, ringW, ringW)];
    _imgView.progressImage = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",arc4random_uniform(70)]];
    //设置背景图是否显示
    [_imgView setDrawGreyscaleBackground:YES];
    //设置图片加载方向
    [_imgView setProgressDirection:M13ProgressViewImageProgressDirectionLeftToRight];
    [self.view addSubview:_imgView];
  
    
    //有无背景图(开关)
    UISwitch * sw = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    sw.center = self.view.center;
    [sw addTarget:self action:@selector(sw:) forControlEvents:UIControlEventValueChanged];
    sw.on = YES;
    [self.view addSubview:sw];
    
    //方向
    UISegmentedControl * seg = [[UISegmentedControl alloc] initWithItems:@[@"→",@"↑",@"←",@"↓"]];
    seg.frame = CGRectMake(50, sw.lyBottom+50, self.view.lyWidth-100, 30);
    [seg addTarget:self action:@selector(seg:) forControlEvents:UIControlEventValueChanged];
    seg.selectedSegmentIndex = 0;
    [self.view addSubview:seg];
    
    //进度条
    UISlider * slider = [[UISlider alloc] initWithFrame:CGRectMake(50, 420, self.view.lyWidth-100, 30)];
    slider.minimumValue = 0.0;
    slider.maximumValue = 1.0;
    [slider addTarget:self action:@selector(changSlider:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
}
//进度条控制
-(void)changSlider:(UISlider *)slider{
    
    [_imgView setProgress:slider.value animated:NO];
}

//开关控制,无参数自动重复加载
-(void)sw:(UISwitch *)sw{
    [_imgView setDrawGreyscaleBackground:sw.on];
}
// 加载方向
-(void)seg:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 0) {
        [_imgView setProgressDirection:M13ProgressViewImageProgressDirectionLeftToRight];
    } else if (seg.selectedSegmentIndex == 1) {
        [_imgView setProgressDirection:M13ProgressViewImageProgressDirectionBottomToTop];
    } else if (seg.selectedSegmentIndex == 2) {
        [_imgView setProgressDirection:M13ProgressViewImageProgressDirectionRightToLeft];
    } else {
        [_imgView setProgressDirection:M13ProgressViewImageProgressDirectionTopToBottom];
    }

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
