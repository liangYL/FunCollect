//
//  SXAnimateVIew.h
//  SXFiveScoreShow
//
//  Created by dongshangxian on 15/5/26.
//  Copyright (c) 2015年 Sankuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXAnimateVIew : UIView

//这5个参数,代表有几个角
@property(nonatomic,assign)CGFloat subScore1;
@property(nonatomic,assign)CGFloat subScore2;
@property(nonatomic,assign)CGFloat subScore3;
@property(nonatomic,assign)CGFloat subScore4;
@property(nonatomic,assign)CGFloat subScore5;

//类型[1:填充,2:不填充]
@property(nonatomic,assign)int showType;
@property(nonatomic,strong)UIColor *showColor;//整体颜色
@property(nonatomic,assign)float showWidtn;//不填充可看到线宽度

@end
