//
//  XYZViewController.m
//  demo6_PhotoRiver
//
//  Created by BOBO on 15/3/23.
//  Copyright (c) 2015年 BobooO. All rights reserved.
//

#import "XYZViewController.h"
#import "XYZPhoto.h"

#define IMAGEWIDTH 120
#define IMAGEHEIGHT 160

@interface XYZViewController ()
@property(nonatomic, retain) NSMutableArray * photos;
@property(nonatomic,retain)NSTimer * timer;

@end

@implementation XYZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
  /*
    self.photos = [[NSMutableArray alloc]init];
    NSMutableArray *photoPaths = [[NSMutableArray alloc]init];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    
    NSLog(@"path =%@", path);
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSArray *fileNames = [fm contentsOfDirectoryAtPath:path error:nil];
    for (NSString *fileName in fileNames ) {
        if ([fileName hasSuffix:@"jpg"] || [fileName hasSuffix:@"JPG"]) {
            NSString *photoPath = [path stringByAppendingPathComponent:fileName];
            [photoPaths addObject:photoPath];
        }
    }
    
    
    //添加9个图片到界面中
    if (photoPaths) {
        for (int i = 0; i < 12; i++) {
            CGFloat X1 = arc4random()%((NSInteger)self.view.bounds.size.width - IMAGEWIDTH);
            CGFloat Y = arc4random()%((NSInteger)self.view.bounds.size.height - IMAGEHEIGHT);
            CGFloat W = IMAGEWIDTH;
            CGFloat H = IMAGEHEIGHT;
            
            XYZPhoto *photo = [[XYZPhoto alloc]initWithFrame:CGRectMake(X1, Y, W, H)];
            [photo updateImage:[UIImage imageWithContentsOfFile:photoPaths[i]]];
            [self.view addSubview:photo];
            
            
            CGFloat alpha = i*1.0/10 + 0.2;
           [photo setImageAlphaAndSpeedAndSize:alpha];
            [self.photos addObject:photo];
            [photo release];
        }
    }

    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
   */
 
    
     _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];

}


#pragma mark-下雪动画 动画

- (void)onTimer:(NSTimer *)timer;
{
    int b = self.view.frame.size.width;
    int a = self.view.frame.size.height;
    //UIImage * aImage = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",arc4random()%40]];
    
    
    NSMutableArray *photoPaths = [[NSMutableArray alloc]init];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *fileNames = [fm contentsOfDirectoryAtPath:path error:nil];
    for (NSString *fileName in fileNames ) {
        if ([fileName hasSuffix:@"jpg"] || [fileName hasSuffix:@"JPG"]) {
            NSString *photoPath = [path stringByAppendingPathComponent:fileName];
            [photoPaths addObject:photoPath];
        }
    }
    UIImage * aImage = [UIImage imageWithContentsOfFile:photoPaths[arc4random()%[photoPaths count]]];
    
  
    

    UIImageView * flakeView = [[[UIImageView alloc] initWithImage:aImage] autorelease];
    int startY = arc4random() % a;
    //int endX = arc4random() % a;
    //图片放大倍数
    //double scale = 1 / arc4random() % 100 + 1.0;
    //double speed = 1 / arc4random() % 100 + 1.0;
    double whith = (arc4random() % 120) + 30;
    double hight = whith*1.4;
    
    flakeView.frame = CGRectMake(-whith, startY, whith, hight);
    flakeView.alpha = whith/150;
    [self.view addSubview:flakeView];
    
    [UIView beginAnimations:nil context:(__bridge void *)(flakeView)];
    [UIView setAnimationDuration:4+whith/130];
    flakeView.frame = CGRectMake(b, startY,flakeView.frame.size.width, flakeView.frame.size.height);
    [UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

- (void)onAnimationComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    UIImageView *flakeView = (__bridge UIImageView *)(context);
    [flakeView  removeFromSuperview];
    [self.view.layer removeAllAnimations];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.view.layer removeAllAnimations];
    [_timer setFireDate:[NSDate distantFuture]];
}
- (void)dealloc
{
    self.timer = nil;
    [super dealloc];
}



/*
- (void)doubleTap {

    NSLog(@"DoubleTap...........");
    
    for (XYZPhoto *photo in self.photos) {
        if (photo.state == XYZPhotoStateDraw || photo.state == XYZPhotoStateBig) {
            return;
        }
    }
    
    CGFloat W = self.view.bounds.size.width / 3;
    CGFloat H = self.view.bounds.size.height / 3;
    
    [UIView animateWithDuration:1 animations:^{
        for (int i = 0; i < self.photos.count; i++) {
            XYZPhoto *photo = [self.photos objectAtIndex:i];
            
            if (photo.state == XYZPhotoStateNormal) {
                photo.oldAlpha = photo.alpha;
                photo.oldFrame = photo.frame;
                photo.oldSpeed = photo.speed;
                photo.alpha = 1;
                photo.frame = CGRectMake(i%3*W, i/3*H, W, H);
                photo.imageView.frame = photo.bounds;
                photo.drawView.frame = photo.bounds;
                photo.speed = 0;
                photo.state = XYZPhotoStateTogether;
            } else if (photo.state == XYZPhotoStateTogether) {
                photo.alpha = photo.oldAlpha;
                photo.frame = photo.oldFrame;
                photo.speed = photo.oldSpeed;
                photo.imageView.frame = photo.bounds;
                photo.drawView.frame = photo.bounds;
                photo.state = XYZPhotoStateNormal;
            }
        }

    }];
    
}
*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
