//
//  imgView.m
//  StoryboardExample
//
//  Created by liang on 16/6/21.
//
//

#import "imgView.h"

@implementation imgView


 //Only override drawRect: if you perform custom drawing.
 //An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    if(!_str){
        return;
    }
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",_str]];
    [image drawInRect:CGRectMake(0, 0, 180, 260)];
    
    
}


@end
