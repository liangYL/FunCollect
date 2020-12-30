//
//  JTBorderDotAnimation.h
//  JTBorderDotAnimation
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

@interface JTBorderDotAnimation : NSObject

@property (retain, nonatomic) UIView *animatedView;

@property (assign, nonatomic) NSUInteger numberPoints;
@property (assign, nonatomic) CFTimeInterval duration;
@property (assign, nonatomic) float repeatCount;
@property (assign, nonatomic) CGFloat pointSize;
@property (retain, nonatomic) UIColor *pointColor;

- (void)start;
- (void)stop;

@end
