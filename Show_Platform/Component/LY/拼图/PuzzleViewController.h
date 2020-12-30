//
//  ViewController.h
//  Puzze
//
//  Created by WHNUKE on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageView.h"

@interface PuzzleViewController : UIViewController<imagedelegate>
{
    UIImageView *tempimage;
    ImageView *imgView;
}

-(void)upchange:(UIImageView *)image;
-(void)leftchange:(UIImageView *)image;
-(void)rightchange:(UIImageView *)image;
-(void)downchange:(UIImageView *)image;

-(NSDictionary*)SeparateImage:(UIImage*)image ByX:(int)x andY:(int)y cacheQuality:(float)quality;

@end
