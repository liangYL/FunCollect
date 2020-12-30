//
//  M13LoadingViewController.m
//  
//
//  Created by liang on 16/2/16.
//
//

#import "CircularViewController.h"
#import "M13ProgressViewRing.h"
#import "M13ProgressViewSegmentedRing.h"
#import "M13ProgressViewPie.h"

@interface CircularViewController ()
@property(nonatomic,retain)M13ProgressViewRing * ring1;
@property(nonatomic,retain)M13ProgressViewSegmentedRing * ring2;
@property(nonatomic,retain)M13ProgressViewPie * ring3;
@end

@implementation CircularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat ringW =(self.view.lyWidth-40)/3;
    CGFloat topH = 50;
    
    //初始化视图,颜色等设置参见父类
    _ring1 = [[M13ProgressViewRing alloc] initWithFrame:CGRectMake(10, topH, ringW, ringW)];
    //圆环的宽度
    _ring1.backgroundRingWidth = 2;
    //内环的宽度
    _ring1.progressRingWidth = 6;
    //是否显示百分比
    _ring1.showPercentage = YES;
    //可以设置加载,无或者成功或者失败时的符号
    [_ring1 performAction:M13ProgressViewActionNone animated:YES];
    //无任何参数动画(参数无效)
    //[_ring1 setIndeterminate:YES];
    [self.view addSubview:_ring1];
    
    _ring2 = [[M13ProgressViewSegmentedRing alloc] initWithFrame:CGRectMake(_ring1.lyRight+10, topH, ringW, ringW)];
    //环的宽度
    _ring2.progressRingWidth = arc4random_uniform(20)+10;
    //环的个数
    _ring2.numberOfSegments = 5;
    //_ring2.segmentSeparationAngle = 20;
    //一种间隙是直的,一种间隙是斜的
    _ring2.segmentBoundaryType =M13ProgressViewSegmentedRingSegmentBoundaryTypeRectangle;
    //是否显示百分比
    _ring2.showPercentage = YES;
    [self.view addSubview:_ring2];
    
    _ring3 = [[M13ProgressViewPie alloc] initWithFrame:CGRectMake(_ring2.lyRight+10, topH, ringW, ringW)];
    //环的宽度
    _ring3.backgroundRingWidth = 2;
    [self.view addSubview:_ring3];
    
    
    
    //有参/无参(开关)
    UISwitch * sw = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    sw.center = self.view.center;
    [sw addTarget:self action:@selector(aaa:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:sw];
    
    //进度条
    UISlider * slider = [[UISlider alloc] initWithFrame:CGRectMake(50, 420, self.view.lyWidth-100, 30)];
    slider.minimumValue = 0.0;
    slider.maximumValue = 1.0;
    [slider addTarget:self action:@selector(changSlider:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
}
-(void)changSlider:(UISlider *)slider{
    
    [_ring1 setProgress:slider.value animated:NO];
    [_ring2 setProgress:slider.value animated:NO];
    [_ring3 setProgress:slider.value animated:NO];

    
    if(slider.value==1){
        [_ring1 performAction:M13ProgressViewActionSuccess animated:YES];
        [_ring2 performAction:M13ProgressViewActionSuccess animated:YES];
        [_ring3 performAction:M13ProgressViewActionSuccess animated:YES];

    }else{
        [_ring1 performAction:M13ProgressViewActionNone animated:YES];
        [_ring2 performAction:M13ProgressViewActionNone animated:YES];
        [_ring3 performAction:M13ProgressViewActionNone animated:YES];

    }
    
}


-(void)aaa:(UISwitch *)sw{
    if (sw.on) {
        [_ring1 setIndeterminate:YES];
        [_ring2 setIndeterminate:YES];
        [_ring3 setIndeterminate:YES];

    } else {
        [_ring1 setIndeterminate:NO];
        [_ring2 setIndeterminate:NO];
        [_ring3 setIndeterminate:NO];
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
