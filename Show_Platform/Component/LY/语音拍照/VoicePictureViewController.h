//
//  ViewController.h
//  photo
//
//  Created by liang on 15/5/15.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iflyMSC/IFlyRecognizerViewDelegate.h"

@interface VoicePictureViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,IFlyRecognizerViewDelegate>

/**
 有UI语音识别demo
 使用该功能仅仅需要四步
 1.创建识别对象；
 2.设置识别参数；
 3.有选择的实现识别回调；
 4.启动识别
 */
//带界面的听写识别对象



@end

