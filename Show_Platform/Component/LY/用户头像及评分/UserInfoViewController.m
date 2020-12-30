//
//  UserInfoViewController.m
//  Show_Platform
//
//  Created by liang on 15/4/27.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "UserInfoViewController.h"
#import "STCameraSheet.h"
#import "HCSStarRatingView.h"

#import <AVFoundation/AVFoundation.h>

@interface UserInfoViewController ()
@property(nonatomic,retain)UIImageView *imgView;
@property(nonatomic,retain)UILabel *staLabel;

@property (nonatomic, retain)AVCaptureSession * AVSession;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    
    //用户头像视图
    _imgView = [[UIImageView alloc] init];
    _imgView.backgroundColor = [UIColor yellowColor];
    _imgView.layer.cornerRadius = 50;
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.borderWidth = 3.5;
    _imgView.layer.borderColor = [UIColor colorWithRed:1.000 green:0.502 blue:0.000 alpha:1.000].CGColor;
    _imgView.userInteractionEnabled = YES;
    [self.view addSubview:_imgView];
    [_imgView setMargin:UIEdgeInsetsMake(50, 100, X, X)];
    [_imgView setSizeView:CGSizeMake(100, 100)];
    
    //头像点击
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aa)];
    [_imgView addGestureRecognizer:tap];
    
    
    //星星控件
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] init];
    starRatingView.maximumValue = 6;       //最大星星个数
    starRatingView.minimumValue = 0;       //最小星星个数
    starRatingView.value = 4.5f;           //星星默认值
    starRatingView.allowsHalfStars = YES;  //是否允许半星
    starRatingView.tintColor = [UIColor redColor];  //星星颜色
    starRatingView.userInteractionEnabled = YES;//星星是否能点击(默认可以)
    [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:starRatingView];
    [starRatingView setSizeView:CGSizeMake(200, 30)];
    [starRatingView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imgView withOffset:10];
    [starRatingView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_imgView withOffset:-50];
    
    // 星星后面的评分 label
    _staLabel = [[UILabel alloc] init];
    _staLabel.text = [NSString stringWithFormat:@"%.1f",starRatingView.value];
    [self.view addSubview:_staLabel];
    [_staLabel setSizeView:CGSizeMake(100, 30)];
    [_staLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:starRatingView withOffset:0];
    [_staLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:starRatingView withOffset:0];
    
    //打开关闭相机闪光灯
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(30, 250, 260, 40);
    button.backgroundColor = [UIColor brownColor];
    [button setTitle:@"打开闪光灯" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(doClickLightOnOrOff:) forControlEvents:UIControlEventTouchUpInside];
    
    //另一种选择方式
    UIButton * abutton = [UIButton buttonWithType:UIButtonTypeSystem];
    abutton.frame = CGRectMake(100,button.lyBottom+20, self.view.lyWidth-200, 40);
//    abutton.backgroundColor = [UIColor brownColor];
    [abutton setTitle:@"打开图库" forState:UIControlStateNormal];
    [self.view addSubview:abutton];
    [abutton addTarget:self action:@selector(doClickImg) forControlEvents:UIControlEventTouchUpInside];
    

}

#pragma mark 调用闪光灯
//调用闪光灯的代码

- (void)doClickLightOnOrOff:(UIButton *)btn
{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        if ([btn.titleLabel.text isEqualToString:@"打开闪光灯"]) {
            [btn setTitle:@"关闭闪光灯" forState:UIControlStateNormal];
            [self openFlashLight];
        }else{
            [self closeFlashLight];
            [btn setTitle:@"打开闪光灯" forState:UIControlStateNormal];
        }
    }else{
        //没有摄像头
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无法调用闪光灯" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}

-(void)openFlashLight
{
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device.torchMode == AVCaptureTorchModeOff) {
        //Create an AV session
        self.AVSession = [[AVCaptureSession alloc]init];
        
        // Create device input and add to current session
        AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        [_AVSession addInput:input];
        
        // Create video output and add to current session
        AVCaptureVideoDataOutput * output = [[AVCaptureVideoDataOutput alloc]init];
        [_AVSession addOutput:output];
        
        // Start session configuration
        [_AVSession beginConfiguration];
        [device lockForConfiguration:nil];
        
        // Set torch to on
        [device setTorchMode:AVCaptureTorchModeOn];
        
        [device unlockForConfiguration];
        [_AVSession commitConfiguration];
        
        // Start the session
        [_AVSession startRunning];
        
        // Keep the session around
        [self setAVSession:self.AVSession];
        
        [output release];
    }
}

-(void)closeFlashLight
{
    [self.AVSession stopRunning];
    [self.AVSession release];
}

#pragma mark---------

//头像点击
-(void)aa{
    
    [[STCameraSheet CameraSheet] CameraWithController:self editing:Editing onDismiss:^(UIImage *cameraImage) {
        _imgView.image = cameraImage;
        
    } onError:^(NSString *str) {
        
    }];
    
}

//评分星星点击
-(void)didChangeValue:(HCSStarRatingView *)sende{
    
    _staLabel.text = [NSString stringWithFormat:@"%.1f",sende.value];

}
#pragma mark---------另一种点击
-(void)doClickImg{
    [self.navigationController pushViewController:[[NSClassFromString(@"JSViewController") alloc] init] animated:YES];
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
