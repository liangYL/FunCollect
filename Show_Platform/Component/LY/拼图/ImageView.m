//
//  ImageView.m
//  Puzze
//
//  Created by WHNUKE on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ImageView
@synthesize delegate;



- (id) initWithImage:(UIImage *)image
{
    if (self = [super initWithImage:image]) {
        [self setUserInteractionEnabled:YES];
        [self setMultipleTouchEnabled:YES];
        self.layer.borderWidth = 2;
        self.layer.borderColor = UIColor.redColor.CGColor;
        
    }
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([delegate respondsToSelector:@selector(movedeciton:)])
    {
        [delegate movedeciton:self];
    }
}

@end
