//
//  M13LoadingViewController.m
//  
//
//  Created by liang on 16/2/16.
//
//

#import "LinesViewController.h"
#import "M13ProgressViewBar.h"
#import "M13ProgressViewSegmentedBar.h"
#import "M13ProgressViewBorderedBar.h"
#import "M13ProgressViewStripedBar.h"

@interface LinesViewController ()
@property(nonatomic,retain)M13ProgressViewBar * ring1;
@property(nonatomic,retain)M13ProgressViewSegmentedBar * ring2;
@property(nonatomic,retain)M13ProgressViewBorderedBar * ring3;
@property(nonatomic,retain)M13ProgressViewStripedBar * ring4;

@end

@implementation LinesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat ringW =self.view.lyWidth-20;
    
    //初始化视图,颜色等设置参见父类
    _ring1 = [[M13ProgressViewBar alloc] initWithFrame:CGRectMake(10, 30, ringW, 20)];
    //百分数显示的位置(上下左右)
    _ring1.percentagePosition= M13ProgressViewBarPercentagePositionRight;
    //进度条从那个方向进行加载(上下左右)
    _ring1.progressDirection = M13ProgressViewBarProgressDirectionRightToLeft;
    //线条粗细
    _ring1.progressBarThickness = 2;
    //圆角(线条比较粗时明显)
    _ring1.progressBarCornerRadius = 1;
    //加载成功颜色(加载完成时设置)
    _ring1.successColor = [UIColor greenColor];
    //加载失败的颜色
    _ring1.failureColor = [UIColor redColor];
    //是否显示百分比
    _ring1.showPercentage = YES;
    [self.view addSubview:_ring1];
    
    _ring2 = [[M13ProgressViewSegmentedBar alloc] initWithFrame:CGRectMake(10, _ring1.lyBottom+15, ringW, 30)];
    //加载成功颜色(加载完成时设置)
    _ring2.successColor = [UIColor greenColor];
    //加载失败的颜色
    _ring2.failureColor = [UIColor redColor];
    [self.view addSubview:_ring2];
    
    _ring3 = [[M13ProgressViewBorderedBar alloc] initWithFrame:CGRectMake(10, _ring2.lyBottom+15, ringW, 30)];
    //加载成功颜色(加载完成时设置)
    _ring3.successColor = [UIColor greenColor];
    //加载失败的颜色
    _ring3.failureColor = [UIColor redColor];
    [self.view addSubview:_ring3];
    
    _ring4 = [[M13ProgressViewStripedBar alloc] initWithFrame:CGRectMake(10, _ring3.lyBottom+15, ringW, 30)];
    //是否有斜杠
    _ring4.showStripes = YES;
    //斜杠是否会动
    _ring4.animateStripes = YES;
    [self.view addSubview:_ring4];
    
    //有参/无参(开关)
    UISwitch * sw = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    sw.center = self.view.center;
    [sw addTarget:self action:@selector(sw:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:sw];
    
    //圆角类型
    UISegmentedControl * seg = [[UISegmentedControl alloc] initWithItems:@[@"Square",@"Rounded",@"Circle"]];
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
    
    [_ring1 setProgress:slider.value animated:NO];
    [_ring2 setProgress:slider.value animated:NO];
    [_ring3 setProgress:slider.value animated:NO];
    [_ring4 setProgress:slider.value animated:NO];

    
    if(slider.value==1){
        [_ring1 performAction:M13ProgressViewActionSuccess animated:YES];
        [_ring2 performAction:M13ProgressViewActionSuccess animated:YES];
        [_ring3 performAction:M13ProgressViewActionSuccess animated:YES];
        //[_ring4 performAction:M13ProgressViewActionSuccess animated:YES];

    }else{
        [_ring1 performAction:M13ProgressViewActionNone animated:YES];
        [_ring2 performAction:M13ProgressViewActionNone animated:YES];
        [_ring3 performAction:M13ProgressViewActionNone animated:YES];
        //[_ring4 performAction:M13ProgressViewActionNone animated:YES];

    }
    
}

//开关控制,无参数自动重复加载
-(void)sw:(UISwitch *)sw{
    if (sw.on) {
        [_ring1 setIndeterminate:YES];
        [_ring2 setIndeterminate:YES];
        [_ring3 setIndeterminate:YES];
        [_ring4 setIndeterminate:YES];
    } else {
        [_ring1 setIndeterminate:NO];
        [_ring2 setIndeterminate:NO];
        [_ring3 setIndeterminate:NO];
        [_ring4 setIndeterminate:NO];
    }
}
//改变圆角
-(void)seg:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 0) {
        _ring2.segmentShape=M13ProgressViewSegmentedBarSegmentShapeRectangle;
        _ring3.cornerType = M13ProgressViewStripedBarCornerTypeSquare;
        _ring4.cornerType = M13ProgressViewStripedBarCornerTypeSquare;
    } else if (seg.selectedSegmentIndex == 1) {
        _ring2.segmentShape=M13ProgressViewSegmentedBarSegmentShapeRoundedRect;
        _ring3.cornerType = M13ProgressViewStripedBarCornerTypeRounded;
        _ring4.cornerType = M13ProgressViewStripedBarCornerTypeRounded;
    } else if (seg.selectedSegmentIndex == 2) {
        _ring2.segmentShape = M13ProgressViewSegmentedBarSegmentShapeCircle;
        _ring3.cornerType = M13ProgressViewStripedBarCornerTypeCircle;
        _ring4.cornerType = M13ProgressViewStripedBarCornerTypeCircle;
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
