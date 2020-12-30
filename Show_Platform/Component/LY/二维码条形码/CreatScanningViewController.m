//
//  CreatScanningViewController.m
//  
//
//  Created by liang on 15/11/9.
//
//

#import "CreatScanningViewController.h"
#import "UIImage+LXDCreateBarcode.h"
#import "LXDScanCodeController.h"
#import <AVFoundation/AVFoundation.h>


#import "QRCodeReaderDelegate.h"
#import "QRCodeReaderViewController.h"
#import "QRCodeReader.h"
@interface CreatScanningViewController ()<LXDScanCodeControllerDelegate,QRCodeReaderDelegate>


@end

@implementation CreatScanningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //生成二维码
    UIButton * aBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    aBtn.frame = CGRectMake(self.view.lyWidth/5-20, 100, self.view.lyWidth/4, 40);
    aBtn.backgroundColor = [UIColor whiteColor];
    [aBtn setTitle:@"生成" forState:UIControlStateNormal];
    [aBtn addTarget:self action:@selector(creatView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aBtn];
    
    //扫描二维码
    UIButton * bBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    bBtn.frame = CGRectMake(aBtn.lyRight+10, 100, self.view.lyWidth/4, 40);
    bBtn.backgroundColor = [UIColor whiteColor];
    [bBtn setTitle:@"扫描一" forState:UIControlStateNormal];
    [bBtn addTarget:self action:@selector(saomiao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bBtn];
    
    //扫描二维码
    UIButton *  cBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cBtn.frame = CGRectMake(bBtn.lyRight+10, 100, self.view.lyWidth/4, 40);
    cBtn.backgroundColor = [UIColor whiteColor];
    [cBtn setTitle:@"扫描二" forState:UIControlStateNormal];
    [cBtn addTarget:self action:@selector(saomiaoA) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cBtn];
}


-(void)creatView{
    
    //可生成不同颜色,圆角
    UIImage * image = [UIImage imageOfQRFromURL: @"https://www.baidu.com" codeSize: 160 red: 255 green: 0 blue: 255 insertImage: [UIImage imageNamed:@"icon"] roundRadius: 15.0f];
    CGSize size = image.size;
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:  ((CGRect){(CGPointZero), (size)})];
    imageView.center = self.view.center;
    imageView.image = image;
    [self.view addSubview: imageView];
}


#pragma mark - LXDScanCodeController
-(void)saomiao{
    LXDScanCodeController * scanCodeController = [LXDScanCodeController scanCodeController];
    scanCodeController.scanDelegate = self;
    [self.navigationController pushViewController: scanCodeController animated: YES];
}
#pragma mark - LXDScanCodeControllerDelegate
- (void)scanCodeController:(LXDScanCodeController *)scanCodeController codeInfo:(NSString *)codeInfo
{
    NSURL * url = [NSURL URLWithString: codeInfo];
    if ([[UIApplication sharedApplication] canOpenURL: url]) {
        [[UIApplication sharedApplication] openURL: url];
    } else {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"警告" message: [NSString stringWithFormat: @"%@:%@", @"无法解析的二维码", codeInfo] delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
        [alertView show];
    }
}

//-------------二相关
-(void)saomiaoA{
    if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
        static QRCodeReaderViewController *reader = nil;
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            reader = [QRCodeReaderViewController new];
        });
        reader.delegate = self;
        
        [reader setCompletionWithBlock:^(NSString *resultAsString) {
            NSLog(@"Completion with result: %@", resultAsString);
        }];
        
        [self presentViewController:reader animated:YES completion:NULL];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Reader not supported by the current device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }

}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QRCodeReader" message:result delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
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
