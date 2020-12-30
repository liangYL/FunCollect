//
//  TiaoxingmaViewController.m
//  Yingshe
//
//  Created by liang on 15/4/1.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "TiaoxingmaViewController.h"
#import "UIImage+LXDCreateBarcode.h"
@interface TiaoxingmaViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation TiaoxingmaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 90, 40);
    [leftBtn setTitle:@"二维码封装" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(jump) forControlEvents: UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftBtn] autorelease];
    
    
    
    //生成的二维码图片
    self.imageView        = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview:self.imageView];
    //[_imageView setMargin:UIEdgeInsetsMake(20, 20, 180, 20)];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        makeSize(150, 150);
        makeCenterView(self.view);
    }];
    
    UIButton * aBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    aBtn.frame = CGRectMake(50, 400, 100, 30);
    aBtn.backgroundColor = [UIColor whiteColor];
    [aBtn setTitle:@"生成二维码" forState:UIControlStateNormal];
    [aBtn addTarget:self action:@selector(aa) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aBtn];
    
    UIButton * aBtn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    aBtn1.frame = CGRectMake(180, 400, 100, 30);
    aBtn1.backgroundColor = [UIColor whiteColor];
    [aBtn1 setTitle:@"生成条形码" forState:UIControlStateNormal];
    [aBtn1 addTarget:self action:@selector( bb) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aBtn1];
    
    NSArray * arr = @[aBtn,aBtn1];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        makeTop(50);makeHeight(30);
    }];
    
    
    UIButton * aBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    aBtn2.frame = CGRectMake(120, 440, 100, 30);
    aBtn2.backgroundColor = [UIColor whiteColor];
    [aBtn2 setTitle:@"生成二维码(2)" forState:UIControlStateNormal];
    [aBtn2 addTarget:self action:@selector(cc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aBtn2];
    [aBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        makeMargin(nil, 10, -50, -10);
        makeHeight(30);
    }];
    
    
    
}
#pragma mark---
-(void)jump{
    
    [self.navigationController pushViewController:[[NSClassFromString(@"CreatScanningViewController") alloc] init] animated:YES];
    
}

#pragma mark---

-(void)aa{
    [self generateCode:@"CIAztecCodeGenerator"];

}

-(void)bb{
    [self generateCode:@"CICode128BarcodeGenerator"];
}

-(void)cc{
    UIImage *qrcode = [self createNonInterpolatedUIImageFormCIImageA:[self createQRForStringA:@"http://www.baidu.com"] withSize:250.0f];
    UIImage *customQrcode = [self imageBlackToTransparentA:qrcode withRed:60.0f  andGreen:74.0f andBlue:189.0f];
    self.imageView.image = customQrcode;
//    self.imageView.image = qrcode;

    // set shadow
    self.imageView.layer.shadowOffset = CGSizeMake(0, 2);
    self.imageView.layer.shadowRadius = 2;
    self.imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.imageView.layer.shadowOpacity = 0.5;
    
    UIImageView * centerView = [[UIImageView alloc] init];
    [self.imageView addSubview:centerView];
    [centerView setSizeView:CGSizeMake(40, 40)];
    [centerView autoCenterInSuperview];
    centerView.image = [UIImage imageNamed:@"icon.png"];
    

}


- (UIImage *)resizeImage:(UIImage *)image
             withQuality:(CGInterpolationQuality)quality
                    rate:(CGFloat)rate {
    UIImage *resized = nil;
    CGFloat width    = image.size.width * rate;
    CGFloat height   = image.size.height * rate;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, quality);
    [image drawInRect:CGRectMake(0, 0, width, height)];
    resized = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resized;
}



- (void)generateCode:(NSString *)filtername{
    
    // @"CICode128BarcodeGenerator"  条形码
    // @"CIAztecCodeGenerator"       二维码
    //NSString *filtername = @"CICode128BarcodeGenerator";
    
    
    CIFilter *filter = [CIFilter filterWithName:filtername];
    [filter setDefaults];
    
    NSData *data = [@"http://www.baidu.com" dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    
    CIImage *outputImage = [filter outputImage];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outputImage
                                       fromRect:[outputImage extent]];
    UIImage *image = [UIImage imageWithCGImage:cgImage
                                         scale:1.
                                   orientation:UIImageOrientationUp];
    
    // Resize without interpolating
    CGFloat scaleRate = self.imageView.frame.size.width / image.size.width;
    UIImage *resized = [self resizeImage:image
                             withQuality:kCGInterpolationNone
                                    rate:scaleRate];
    
    self.imageView.image = resized;
    
    CGImageRelease(cgImage);
}




#define cc -方法
#pragma mark - InterpolatedUIImage
- (UIImage *)createNonInterpolatedUIImageFormCIImageA:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // create a bitmap image that we'll draw into a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

#pragma mark - QRCodeGenerator
- (CIImage *)createQRForStringA:(NSString *)qrString {
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // Send the image back
    return qrFilter.outputImage;
}

//#pragma mark - imageToTransparent
//void ProviderReleaseData (void *info, const void *data, size_t size){
//    free((void*)data);
//}
- (UIImage*)imageBlackToTransparentA:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // traverse pixe
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
            // change color
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // context to image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, nil);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // release
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
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
