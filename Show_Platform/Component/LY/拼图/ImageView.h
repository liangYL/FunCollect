//
//  ImageView.h
//  Puzze
//
//  Created by WHNUKE on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol imagedelegate <NSObject>
@optional
-(void)movedeciton:(UIImageView *)imageview;
@end

@interface ImageView : UIImageView
{
    id delegate;
}

@property (nonatomic,retain) id delegate;

@end
