#import "UIViewAdditions.h"


@implementation UIView (TTCategory)

- (BOOL)visible{
	return !self.hidden;
}

- (void)setVisible:(BOOL)visible{
	self.hidden = !visible;
}

- (CGFloat)lyLeft {
  return self.frame.origin.x;
}

- (void)setLyLeft:(CGFloat)x {
  CGRect frame = self.frame;
  frame.origin.x = x;
  self.frame = frame;
}

- (CGFloat)lyTop {
  return self.frame.origin.y;
}

- (void)setLyTop:(CGFloat)y {
  CGRect frame = self.frame;
  frame.origin.y = y;
  self.frame = frame;
}

- (CGFloat)lyRight {
  return self.frame.origin.x + self.frame.size.width;
}

- (void)setLyRight:(CGFloat)lyRight {
  CGRect frame = self.frame;
  frame.origin.x = lyRight - frame.size.width;
  self.frame = frame;
}

- (CGFloat)lyBottom {
  return self.frame.origin.y + self.frame.size.height;
}

- (void)setLyBottom:(CGFloat)lyBottom {
  CGRect frame = self.frame;
  frame.origin.y = lyBottom - frame.size.height;
  self.frame = frame;
}

- (CGFloat)lyCenterX {
  return self.center.x;
}

- (void)setLyCenterX:(CGFloat)centerX {
  self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)lyCenterY {
  return self.center.y;
}

- (void)setLyCenterY:(CGFloat)lyCenterY {
  self.center = CGPointMake(self.center.x, lyCenterY);
}

- (CGFloat)lyWidth {
  return self.frame.size.width;
}

- (void)setlyWidth:(CGFloat)lyWidth {
  CGRect frame = self.frame;
  frame.size.width = lyWidth;
  self.frame = frame;
}

- (CGFloat)lyHeight {
  return self.frame.size.height;
}

- (void)setlyHeight:(CGFloat)lyHeight {
  CGRect frame = self.frame;
  frame.size.height = lyHeight;
  self.frame = frame;
}

- (CGFloat)screenX {
  CGFloat x = 0;
  for (UIView* view = self; view; view = view.superview) {
    x += view.lyLeft;
  }
  return x;
}

- (CGFloat)screenY {
  CGFloat y = 0;
  for (UIView* view = self; view; view = view.superview) {
    y += view.lyTop;
  }
  return y;
}

- (CGFloat)screenViewX {
  CGFloat x = 0;
  for (UIView* view = self; view; view = view.superview) {
      x += view.lyLeft;

    if ([view isKindOfClass:[UIScrollView class]]) {
      UIScrollView* scrollView = (UIScrollView*)view;
      x -= scrollView.contentOffset.x;
    }
  }
  
  return x;
}

- (CGFloat)screenViewY {
  CGFloat y = 0;
  for (UIView* view = self; view; view = view.superview) {
    y += view.lyTop;

    if ([view isKindOfClass:[UIScrollView class]]) {
      UIScrollView* scrollView = (UIScrollView*)view;
      y -= scrollView.contentOffset.y;
    }
  }
  return y;
}

- (CGRect)screenFrame {
  return CGRectMake(self.screenViewX, self.screenViewY, self.lyWidth, self.lyHeight);
}

- (CGPoint)origin {
  return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
  CGRect frame = self.frame;
  frame.origin = origin;
  self.frame = frame;
}

- (CGSize)lySize {
  return self.frame.size;
}

- (void)setLySize:(CGSize)size {
  CGRect frame = self.frame;
  frame.size = size;
  self.frame = frame;
}

- (CGPoint)offsetFromView:(UIView*)otherView {
  CGFloat x = 0, y = 0;
  for (UIView* view = self; view && view != otherView; view = view.superview) {
    x += view.lyLeft;
    y += view.lyTop;
  }
  return CGPointMake(x, y);
}
/*
- (CGFloat)orientationWidth {
  return UIInterfaceOrientationIsLandscape(TTInterfaceOrientation())
    ? self.height : self.width;
}

- (CGFloat)orientationHeight {
  return UIInterfaceOrientationIsLandscape(TTInterfaceOrientation())
    ? self.width : self.height;
}
*/
- (UIView*)descendantOrSelfWithClass:(Class)cls {
  if ([self isKindOfClass:cls])
    return self;
  
  for (UIView* child in self.subviews) {
    UIView* it = [child descendantOrSelfWithClass:cls];
    if (it)
      return it;
  }
  
  return nil;
}

- (UIView*)ancestorOrSelfWithClass:(Class)cls {
  if ([self isKindOfClass:cls]) {
    return self;
  } else if (self.superview) {
    return [self.superview ancestorOrSelfWithClass:cls];
  } else {
    return nil;
  }
}

- (void)removeAllSubviews {
  while (self.subviews.count) {
    UIView* child = self.subviews.lastObject;
    [child removeFromSuperview];
  }
}



- (UIViewController*)viewController {
  for (UIView* next = [self superview]; next; next = next.superview) {
    UIResponder* nextResponder = [next nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
      return (UIViewController*)nextResponder;
    }
  }
  return nil;
}


- (void)addSubviews:(NSArray *)views
{
	for (UIView* v in views) {
		[self addSubview:v];
	}
}

+ (UILabel *)labelWithFrame:(CGRect)frame
                   fontSize:(CGFloat)fontSize
              textAlignment:(NSTextAlignment)alignment
                       text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = alignment;
    label.text = text;
    label.textColor = [UIColor blackColor];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    return [label autorelease];
}


@end

@interface NSString (ParseCategory)
- (NSMutableDictionary *)explodeToDictionaryInnerGlue:(NSString *)innerGlue 
outterGlue:(NSString *)outterGlue;
@end

@implementation NSString (ParseCategory)

- (NSMutableDictionary *)explodeToDictionaryInnerGlue:(NSString *)innerGlue 
                                           outterGlue:(NSString *)outterGlue 
{
  NSArray *firstExplode = [self componentsSeparatedByString:outterGlue];
  NSArray *secondExplode;
  
  NSInteger count = [firstExplode count];
  NSMutableDictionary* returnDictionary = [NSMutableDictionary dictionaryWithCapacity:count];
  
  for (NSInteger i = 0; i < count; i++)
  {
    secondExplode = 
    [(NSString*)[firstExplode objectAtIndex:i] componentsSeparatedByString:innerGlue];
    if ([secondExplode count] == 2) 
    {
      [returnDictionary setObject:[secondExplode objectAtIndex:1] 
                           forKey:[secondExplode objectAtIndex:0]];
    }
  }
  return returnDictionary;
}


@end
