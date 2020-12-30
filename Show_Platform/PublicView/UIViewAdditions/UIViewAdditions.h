#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (TTCategory)

@property(nonatomic) CGFloat lyLeft;
@property(nonatomic) CGFloat lyTop;
@property(nonatomic) CGFloat lyRight;
@property(nonatomic) CGFloat lyBottom;

@property(nonatomic) CGFloat lyWidth;
@property(nonatomic) CGFloat lyHeight;

@property(nonatomic) CGFloat lyCenterX;
@property(nonatomic) CGFloat lyCenterY;

@property(nonatomic,readonly) CGFloat screenX;
@property(nonatomic,readonly) CGFloat screenY;
@property(nonatomic,readonly) CGFloat screenViewX;
@property(nonatomic,readonly) CGFloat screenViewY;
@property(nonatomic,readonly) CGRect screenFrame;

@property(nonatomic) CGPoint origin;
@property(nonatomic) CGSize lySize;

@property(nonatomic) BOOL visible;

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView*)descendantOrSelfWithClass:(Class)cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView*)ancestorOrSelfWithClass:(Class)cls;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;


/**
 * Calculates the offset of this view from another view in screen coordinates.
 */
- (CGPoint)offsetFromView:(UIView*)otherView;


/**
 * The view controller whose view contains this view.
 */
- (UIViewController*)viewController;


- (void)addSubviews:(NSArray *)views;

+ (UILabel *)labelWithFrame:(CGRect)frame fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)alignment text:(NSString *)text;
@end
