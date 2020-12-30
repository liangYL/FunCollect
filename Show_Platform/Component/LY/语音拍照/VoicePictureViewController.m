//
//  ViewController.m
//  photo
//
//  Created by liang on 15/5/15.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "VoicePictureViewController.h"
#import "MobileCoreServices/MobileCoreServices.h"


#import <iflyMSC/IFlySpeechUtility.h>

#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "iflyMSC/IFlyRecognizerView.h"


@interface VoicePictureViewController ()
{
    UIImagePickerController*imagepicker;
    IFlyRecognizerView*iflyRecognizerView;
    UILabel *aLabel;
    NSString *textStr;
    UIImageView * img;
}
@end

@implementation VoicePictureViewController

-(void)viewWillAppear:(BOOL)animated{
    //将“12345678”替换成您申请的APPID,申请地址:http://open.voicecloud.cn
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",@"548107a2"];[IFlySpeechUtility createUtility:initString];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    imagepicker = [[UIImagePickerController alloc] init];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"设备不支持相机");
        return;
    }
    //指定使用照相机模式,可以指定使用相册／照片库
    imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //设置当拍照完或在相册选完照片后，是否跳到编辑模式进行图片剪裁。只有当showsCameraControls属性为true时才有效果
    imagepicker.editing = YES;
    //设置拍照时的下方的工具栏是否显示，如果需要自定义拍摄界面，则可把该工具栏隐藏
    imagepicker.showsCameraControls  = NO;
    //设置使用后置摄像头，可以使用前置摄像头
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
        imagepicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }else{
        imagepicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }
    //闪关灯
    if (![UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceFront]) {
        NSLog(@"设备不支持前置闪光灯");
    }
    imagepicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;//闪关灯
    //设置相机支持的类型，拍照和录像
    imagepicker.mediaTypes = @[(NSString*)kUTTypeImage,(NSString*)kUTTypeMovie];
    //设置拍摄时屏幕的view的transform属性，可以实现旋转，缩放功能
    // imagepicker.cameraViewTransform = CGAffineTransformMakeRotation(M_PI*45/180);
    // imagepicker.cameraViewTransform = CGAffineTransformMakeScale(1.5, 1.5);
    //所有含有cameraXXX的属性都必须要sourceType是UIImagePickerControllerSourceTypeCamera时设置才有效果，否则会有异常
    //设置UIImagePickerController的代理
    imagepicker.delegate = self;
    
   
    
    //相机底部工具栏
    UIToolbar* tool = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-55, self.view.frame.size.width, 55)];
    tool.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem* cancel = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(clearCamera)];
    UIBarButtonItem* add = [[UIBarButtonItem alloc]initWithTitle:@"拍照" style:UIBarButtonItemStylePlain target:self action:@selector(savePhoto)];
     UIBarButtonItem* aa = [[UIBarButtonItem alloc]initWithTitle:@"前/后" style:UIBarButtonItemStylePlain target:self action:@selector(qiehuan)];
    UIBarButtonItem* bb = [[UIBarButtonItem alloc]initWithTitle:@"语音拍照" style:UIBarButtonItemStylePlain target:self action:@selector(startListenning:)];
    UIBarButtonItem* cc = [[UIBarButtonItem alloc]initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(xiangce)];
    [tool setItems:[NSArray arrayWithObjects:cancel,add,aa,bb,cc, nil]];
    //把自定义的view设置到imagepickercontroller的overlay属性中
    
    imagepicker.cameraOverlayView = tool;
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(savePhoto) userInfo:nil repeats:YES];

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(10,30, self.view.frame.size.width-20, 70);
    [button setTitle:@"开始拍照" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sta) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    img = [[UIImageView alloc] init];
    img.backgroundColor = [UIColor colorWithRed:0.400 green:1.000 blue:1.000 alpha:1.000];
    img.frame = CGRectMake(10, 100, self.view.frame.size.width-20, 330);
    [self.view addSubview:img];
    
    
    aLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height-133+5, self.view.frame.size.width-20, 60)];
    aLabel.textAlignment = NSTextAlignmentCenter;
    aLabel.numberOfLines = 0;
    aLabel.backgroundColor = [UIColor redColor];
    [imagepicker.view addSubview:aLabel];

    //创建语音听写的对象
    iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
    //delegate需要设置，确保delegate回调可以正常返回
    iflyRecognizerView.delegate = self;
    
     [self presentViewController:imagepicker animated:YES completion:nil];
}

-(void)sta{
    [self presentViewController:imagepicker animated:YES completion:nil];
}


#pragma  mark - 讯飞语音相关

-(void)viewWillDisappear:(BOOL)animated
{
    //终止识别
    //[iflyRecognizerView cancel];
    //[iflyRecognizerView setDelegate:nil];
    
    //[super viewWillDisappear:animated];
}
/**
 启动按钮响应方法
 */
- (void)startListenning:(id)sender
{
    [iflyRecognizerView setParameter: @"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    //设置结果数据格式，可设置为json，xml，plain，默认为json。
    [iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    [iflyRecognizerView start];
    NSLog(@"start listenning...");

}
/** 识别结果回调方法
 @param resultArray 结果列表
 @param isLast YES 表示最后一个，NO表示后面还有结果
 */
- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    NSLog(@"===%@",result);
    aLabel.text = result;
    textStr = result;
//  aLabel.text = [NSString stringWithFormat:@"%@%@",_textView.text,result];
  
}
/** 识别结束回调方法
 @param error 识别错误
 */
- (void)onError:(IFlySpeechError *)error
{
    NSLog(@"errorCode:%d",[error errorCode]);
}



#pragma  mark - 相机相关

-(void)savePhoto{
    //拍照，会自动回调- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info，对于自定义照相机界面，拍照后回调可以不退出实现连续拍照效果
    if(aLabel.text.length>0){
    }else{return;}
    if ([self baohan:aLabel.text sub:@"拍照"]||[self baohan:aLabel.text sub:@"123"]||[self baohan:aLabel.text sub:@"茄子"]||[self baohan:aLabel.text sub:@"田七"]||[self baohan:aLabel.text sub:@"开始"]||[self baohan:aLabel.text sub:@"盼盼"]||[self baohan:aLabel.text sub:@"照"])
    {
        [imagepicker takePicture];
        aLabel.text = @"";
    }
}
//判断字符串包含子串
-(BOOL)baohan:(NSString *)sup sub:(NSString *)sub{
        if ([sup rangeOfString:sub].location != NSNotFound) {
            return YES;
        }
    return NO;
}
//成功获得相片还是视频后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //通过UIImagePickerControllerMediaType判断返回的是照片还是视频
    NSString* type = [info objectForKey:UIImagePickerControllerMediaType];
    //如果返回的type等于kUTTypeImage，代表返回的是照片,并且需要判断当前相机使用的sourcetype是拍照还是相册
    if ([type isEqualToString:(NSString*)kUTTypeImage]&&picker.sourceType==UIImagePickerControllerSourceTypeCamera) {
        //获取照片的原图
        UIImage* original = [info objectForKey:UIImagePickerControllerOriginalImage];
        //获取图片裁剪的图
        //UIImage* edit = [info objectForKey:UIImagePickerControllerEditedImage];
        //获取图片裁剪后，剩下的图
        //UIImage* crop = [info objectForKey:UIImagePickerControllerCropRect];
        //获取图片的url
        //NSURL* url = [info objectForKey:UIImagePickerControllerMediaURL];
        //获取图片的metadata数据信息
        //NSDictionary* metadata = [info objectForKey:UIImagePickerControllerMediaMetadata];
        //如果是拍照的照片，则需要手动保存到本地，系统不会自动保存拍照成功后的照片
        UIImageWriteToSavedPhotosAlbum(original, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        img.image = original;
    }else{
        
    }
    //模态方式退出uiimagepickercontroller
    [imagepicker dismissViewControllerAnimated:YES completion:nil];
}
//取消照相机的回调
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //模态方式退出uiimagepickercontroller
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)clearCamera{
    [imagepicker dismissViewControllerAnimated:YES completion:nil];
}

//保存照片成功后的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo{
    NSLog(@"saved..");
}
//切换前后镜头
-(void)qiehuan{
    if (imagepicker.cameraDevice == UIImagePickerControllerCameraDeviceRear) {
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            imagepicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
    }
    else {
        imagepicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }
}
//相册
-(void)xiangce{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    picker.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    [imagepicker presentViewController:picker animated:YES completion:nil];
}


-(void)viewDidAppear:(BOOL)animated{
    aLabel.text = @"";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
