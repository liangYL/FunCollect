//
//  WaterFallCell.m
//  Show_Platform
//
//  Created by liang on 15/7/22.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "WaterFallCell.h"

@implementation WaterFallCell
- (void)dealloc
{
    self.indexLabel = nil;
    self.imageView = nil;
    //[_img release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor redColor];
        
//        self.aImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        [self addSubview:_aImageView];
//        [_aImageView release];
        
//        self.indexLabel = [[UILabel alloc] initWithFrame:CGRectMake((frame.size.width - 50) / 2, 20, 50, 30)];
//        _indexLabel.backgroundColor = [UIColor yellowColor];
//        _indexLabel.font = [UIFont systemFontOfSize:12];
//        [self addSubview:_indexLabel];
//        [_indexLabel release];
        
        
        //        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        //        button.frame = CGRectMake(20, 50, 50, 30);
        //        [button setImage:[UIImage imageNamed:@"title_set_normal.png"] forState:UIControlStateNormal];
        //        [button setImage:[UIImage imageNamed:@"title_set_press.png"] forState:UIControlStateHighlighted];
        //        [self addSubview:button];
        
    }
    return self;
}

//不用 xib 这样初始化才不会乱
- ( UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_imageView];
        [_imageView release];
    }
    return _imageView;
}

- (void)layoutSubviews
{
    _imageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}

@end
