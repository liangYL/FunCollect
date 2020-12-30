//
//  BingViewController.m
//  Show_Platform
//
//  Created by liang on 15/6/12.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "BingViewController.h"
#import "UIColor+HexColor.h"
#import "VBPieChart.h"
@interface BingViewController ()
@property (nonatomic, retain) VBPieChart *chart;

@property (nonatomic, retain) NSArray *chartValues;
@end

@implementation BingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view setNeedsLayout];
    
    
    
    self.chart = [[VBPieChart alloc] init];
    [self.view addSubview:_chart];

    [_chart setFrame:CGRectMake(10, 50, 200,200)];
    [_chart setEnableStrokeColor:YES];
    //中间圆心的大小
    [_chart setHoleRadiusPrecent:0.3];
    
    //设置标签(标题)位置[4种]
    [_chart setLabelsPosition:VBLabelsPositionOnChart];
    //阴影
    [_chart.layer setShadowOffset:CGSizeMake(2, 2)];
    [_chart.layer setShadowRadius:3];
    [_chart.layer setShadowColor:[UIColor blackColor].CGColor];
    [_chart.layer setShadowOpacity:0.7];

    
    //设置参数数组
    self.chartValues = @[
                         @{@"name":@"20", @"value":@20, @"color":[UIColor colorWithHex:0xdd191daa]},
                         @{@"name":@"20", @"value":@20, @"color":[UIColor colorWithHex:0xd81b60aa]},
                         @{@"name":@"40", @"value":@40, @"color":[UIColor colorWithHex:0x8e24aaaa]},
                         @{@"name":@"70", @"value":@70, @"color":[UIColor colorWithHex:0x3f51b5aa]},
                         @{@"name":@"65", @"value":@65, @"color":[UIColor colorWithHex:0x5677fcaa]},
                         @{@"name":@"23", @"value":@23, @"color":[UIColor colorWithHex:0x2baf2baa]},
                         @{@"name":@"34", @"value":@34, @"color":[UIColor colorWithHex:0xb0bec5aa]},
                         @{@"name":@"54", @"value":@54, @"color":[UIColor colorWithHex:0xf57c00aa]},
                         @{@"name":@"100", @"value":@100, @"color":[UIColor redColor]}
                         ];

    //设置动画
    [_chart setChartValues:_chartValues animation:YES];
    
    
    //EXAMPLE for custom label position
    
    //    [_chart setLabelsPosition:VBLabelsPositionOutChart];
    //    [_chart setLabelBlock:^CGPoint( CALayer *layer) {
    //        NSInteger ind = [layer.superlayer.sublayers indexOfObject:layer]+2;
    //        return CGPointMake(sin(-ind/10.0*M_PI)*50+50, ind*30);
    //    }];
    
    
    //创建按钮,控制样式
    NSArray *arr= @[@"半/全",@"向内显",@"向外显",@"一起显",@"从头到尾(内)",@"从头到尾(外)",@"从头到尾(平)"];
    for (int i  = 0; i<7; i++) {
        UIButton *aBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [aBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        aBtn.tag = 11200+i;
        [aBtn setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        [self.view addSubview:aBtn];
        [aBtn setMargin:UIEdgeInsetsMake(10+40*i, X, X, 10)];
        [aBtn setSizeView:CGSizeMake(100, 40)];
    }
    
    
    for (int i = 0; i<3; i++) {
        UISlider * ddd = [[UISlider alloc] init];
        ddd.minimumValue = 0;
        ddd.maximumValue = 1;
        ddd.tag = 11300+i;
        [ddd addTarget:self action:@selector(scl:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:ddd];
        
        [ddd setMargin:UIEdgeInsetsMake(300+40*i, 50, X, X)];
        [ddd setSizeView:CGSizeMake(200, 40)];
        
    }
    
    
    
    
    
    
}


-(void)click:(UIButton *)btn{
    
    switch (btn.tag) {
        case 11200:
            if (_chart.length < M_PI*2-0.01) {
                _chart.length = M_PI*2;
                _chart.startAngle = 0;
            } else {
                _chart.length = M_PI;
                _chart.startAngle = M_PI;
            }
            
            [_chart setChartValues:_chart.chartValues animation:YES];
            break;
        case 11201:
            [_chart setChartValues:_chartValues animation:YES options:VBPieChartAnimationGrowthBackAll | VBPieChartAnimationTimingEaseInOut];
            break;
        case 11202:
            [_chart setChartValues:_chartValues animation:YES options:VBPieChartAnimationGrowthAll | VBPieChartAnimationTimingEaseInOut];
            break;
        case 11203:
            [_chart setChartValues:_chartValues animation:YES duration:0.35 options:VBPieChartAnimationFan];
            break;
        case 11204:
            [_chart setChartValues:_chartValues animation:YES duration:1.0 options:VBPieChartAnimationGrowth];
            break;
        case 11205:
            [_chart setChartValues:_chartValues animation:YES duration:1.0 options:VBPieChartAnimationGrowthBack];
            break;
        case 11206:
            [_chart setChartValues:_chartValues animation:YES options:VBPieChartAnimationFanAll];
            break;
        default:
            break;
    }
}




-(void)scl:(UISlider *)slider{
    
    float value = [slider value];
    
    switch (slider.tag) {
        case 11300: {
            //            [_chart setFrame:CGRectMake(100, 100, value, value)];
            slider.maximumValue = 1000;
            
            NSMutableArray *array = [NSMutableArray arrayWithArray:_chart.chartValues];
            
            NSMutableDictionary *object = [NSMutableDictionary dictionaryWithDictionary:[array objectAtIndex:slider.tag-11300]];
            [object setObject:[NSNumber numberWithFloat:slider.value] forKey:@"value"];
            [array replaceObjectAtIndex:slider.tag-11300 withObject:object];
            _chart.chartValues = array;
        }
            break;
            
        case 11301:
            [_chart setRadiusPrecent:value];
            break;
        case 11302:
            [_chart setHoleRadiusPrecent:value];
            break;
    }

}


//可360°旋转
//- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//
//    UITouch *t = [[touches allObjects] lastObject];
//    CGPoint p1 = [t previousLocationInView:self.view];
//    CGPoint p2 = [t locationInView:self.view];
//
//    CGPoint delta;
//    delta.x = p1.x - p2.x;
//    delta.y = p1.y - p2.y;
//
//    _chart.layer.transform = CATransform3DRotate(_chart.layer.transform, delta.y * M_PI / 180.0f, 1, 0, 0);
////    self.layer.transform = CATransform3DRotate(self.layer2.transform, delta.y * M_PI / 180.0f, 1, 0, 0);
//
//    _chart.layer.transform = CATransform3DRotate(_chart.layer.transform, delta.x * M_PI / 180.0f, 0, -1, 0);
////    self.layer2.transform = CATransform3DRotate(self.layer2.transform, delta.x * M_PI / 180.0f, 0, -1, 0);
//
//
//}











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
