//
//  LYLockView.m
//  
//
//  Created by liang on 16/1/1.
//
//

#import "LYLockView.h"


#define ZoomFactor 5 //缩放系数

//匿名扩展（类目的特例） ：可以声明属性
@interface LYLockView ()
@property (nonatomic, strong) NSMutableArray *selectedBtnArray;
@property (nonatomic, assign) CGPoint currentPoint;

@end

@implementation LYLockView

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self AddButton];
//    }
//    return self;
//}
//通过代码创建会调用这个方法
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        [self AddButtonWithFrame:frame];
    }
    return self;
}
////通过storyboard 或者 xib 文件创建的时候会调用
//-(id)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super initWithCoder:aDecoder]) {
//        [self AddButton];
//    }
//    return self;
//}

#pragma mark--添加按钮控件

-(void)AddButtonWithFrame:(CGRect)frame
{
    CGFloat selfWidth = frame.size.width;
    CGFloat selfHight = frame.size.height;
    
    for (int i = 0; i<3; i++) {
        for (int j = 0; j<3; j++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            //设置默认的图片
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
            btn.userInteractionEnabled = NO;
            //设置选中的图片
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
            btn.tag = i+100;
            
            btn.frame = CGRectMake(i+j*(selfWidth/3), i*selfHight/3, selfWidth/3, selfHight/3);
            
            //缩放系数
            NSInteger num = ZoomFactor;
            
            btn.frame = CGRectMake(btn.frame.origin.x+btn.frame.size.width/num, btn.frame.origin.y+btn.frame.size.height/num, btn.frame.size.width-(btn.frame.size.width/num)*2, btn.frame.size.height-(btn.frame.size.height/num)*2);
            
            
            [self addSubview:btn];
        }
    }
}
#pragma mark--- 触摸事件

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    UIButton *selectBtn;
    
    for (UIButton * btn in self.subviews) {
        //if 点在按钮范围内取出这个按钮
        if (CGRectContainsPoint(btn.frame, touchPoint)) {
            selectBtn = btn;
        }
    }
    //如果按钮存在且没选中,设置按钮状态并添加进数组
    if (selectBtn && selectBtn.selected ==NO) {
        selectBtn.selected = YES;
        NSLog(@"%@",NSStringFromCGPoint(selectBtn.center));
        [self.selectedBtnArray addObject:selectBtn];
         self.currentPoint = selectBtn.center;
    }
    
    [self setNeedsDisplay];

}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    UIButton *selectBtn;
    
    for (UIButton * btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, touchPoint)) {
            selectBtn = btn;
        }
    }
    
    if (selectBtn && selectBtn.selected ==NO) {
        selectBtn.selected = YES;
        NSLog(@"%@",NSStringFromCGPoint(selectBtn.center));
        [self.selectedBtnArray addObject:selectBtn];
    }else{
        self.currentPoint = touchPoint;
    }
    [self setNeedsDisplay];
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //makeObjectsPerformSelector  向数组中的每一个对象发送方法 setSelected:，方法参数为 NO
    [self.selectedBtnArray makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
    [self.selectedBtnArray removeAllObjects];
    [self setNeedsDisplay];

}

#pragma mark --绘图
//绘制按钮路径
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    if (self.selectedBtnArray.count ==0) {
        return;
    }
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    path.lineWidth = ((UIButton *)[self.selectedBtnArray firstObject]).frame.size.width/6;
    //设置线条头为弧度的-防止拐角显现
    path.lineJoinStyle = kCGLineJoinRound;

    [[UIColor colorWithRed:32/255.0 green:210/255.0 blue:254/255.0 alpha:0.5] set];

    [path moveToPoint:((UIButton *)[self.selectedBtnArray firstObject]).center];

    for (int i = 1; i < [self.selectedBtnArray count]; i++)
    {
        [path addLineToPoint:((UIButton *)[self.selectedBtnArray objectAtIndex:i]).center];
    }
    [path addLineToPoint:self.currentPoint];

    
    [path stroke];
    
}

//懒加载
-(NSMutableArray *)selectedBtnArray{
    if (!_selectedBtnArray) {
        self.selectedBtnArray = [NSMutableArray array];
    }
    return _selectedBtnArray;
}

@end
