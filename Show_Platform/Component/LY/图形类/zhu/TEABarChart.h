//
//  TEABarChart.h
//  Xhacker
//
//  Created by Xhacker on 2013-07-25.
//  Copyright (c) 2013 Xhacker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TEABarChart : UIView

// Array of NSNumber
@property (nonatomic,retain) NSArray *data;

// Array of NSString, nil if you don't want labels.
@property (nonatomic,retain) NSArray *xLabels;//最底层标题

// Max y value for chart (only works when autoMax is NO)
@property (nonatomic,assign) CGFloat max;

// Auto set max value
@property (nonatomic,assign) BOOL autoMax;

@property (nonatomic,retain) UIColor *barColor;
@property (nonatomic,retain) NSArray *barColors;
@property (nonatomic,assign) NSInteger barSpacing;
@property (nonatomic,retain)  UIColor *backgroundColor;

// Round bar height to pixel for sharper chart
@property (nonatomic,assign) BOOL roundToPixel;

@end
