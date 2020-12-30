//
//  AppDelegate.m
//  Show_Platform
//
//  Created by liang on 15/3/23.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "LYAnimationTools.h"

#import "UIImage+gif.h"//gif 图片播放

#import <Accelerate/Accelerate.h>
#import "YYFPSLabel.h"//帧数测试

//测试栏
#import "LinesViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window                 = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];

    
    //添加 gif 动画图
    [self loginView];
    
    //[self testVC];
    
    return YES;
}

-(void)testVC
{
    LinesViewController * loginVC = [[LinesViewController alloc] init];
    UINavigationController * navVC  = [[UINavigationController alloc] initWithRootViewController:loginVC];
    navVC.navigationBar.translucent = NO;
    self.window.rootViewController = navVC;
    [self.window makeKeyAndVisible];
}




-(void)loginView{
    
    HomeViewController * loginVC = [[HomeViewController alloc] init];
    UINavigationController * navVC  = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
   // [LYAnimationTools cATransitionAnimation:self.window type:@"oglFlip" subType:kCATransitionFromRight duration:0.7 animation:^{
        self.window.rootViewController = navVC;
        [self.window makeKeyAndVisible];
        [loginVC release];
        [navVC release];
    //}];

    //FPS 流畅帧检测工具(不用可关了)
    YYFPSLabel * aa= [[YYFPSLabel alloc] initWithFrame:CGRectMake(self.window.lyWidth-100, 64, 100, 50)];
    aa.backgroundColor  =[UIColor clearColor];
    [navVC.view addSubview:aa];
    
    
    //添加动态图片
    UIView * aView = [[UIView alloc] initWithFrame:self.window.frame];
    aView.backgroundColor = [UIColor whiteColor];
    [self.window addSubview:aView];
  
    /*
    //添加背景图
    UIImage * imge  = [self blurryImage:[UIImage imageNamed:@"10266937.jpg"] withBlurLevel:0.2];
    aView.layer.contents  = (id)imge.CGImage;
    aView.layer.backgroundColor = [UIColor clearColor].CGColor;
    */
    
    UIImageView * img= [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.window.frame.size.height-200)/2, self.window.frame.size.width, 200)];
    img.image = [UIImage sd_animatedGIFNamed:[NSString stringWithFormat:@"%d.gif",arc4random()%4]];
    img.backgroundColor = [UIColor whiteColor];
    img.layer.masksToBounds = YES;
    img.layer.cornerRadius = 5;
    [aView addSubview:img];
    
    //延迟几秒执行任务(效率高)(等价于per......方法)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [aView removeFromSuperview];
        NSLog(@"延迟调用");
    });
    
}


//加模糊效果，image是图片，blur是模糊度
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    //模糊度,
    if ((blur < 0.1f) || (blur > 2.0f)) {
        blur = 0.5f;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    NSLog(@"boxSize:%i",boxSize);
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入
    /*
     This document describes the Accelerate Framework, which contains C APIs for vector and matrix math, digital signal processing, large number handling, and image processing.
     本文档介绍了Accelerate Framework，其中包含C语言应用程序接口（API）的向量和矩阵数学，数字信号处理，大量处理和图像处理。
     */
    
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
