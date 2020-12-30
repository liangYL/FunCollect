//
//  MoreShowEffectViewController.m
//  Show_Platform
//
//  Created by liang on 15/4/17.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "MoreShowEffectViewController.h"
#import "ReflectionView.h"
#import "imgView.h"
#define ITEM_SPACING 200


@interface MoreShowEffectViewController ()

@end


@implementation MoreShowEffectViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        _wrap = YES;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    backgroundView.image = [UIImage imageNamed:@"background.png"];
    [self.view addSubview:backgroundView];
    
    
    _carousel = [[iCarousel alloc] initWithFrame:self.view.bounds];
    _carousel.delegate = self;
    _carousel.dataSource = self;
    _carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _carousel.type = iCarouselTypeCoverFlow;
    [self.view addSubview:_carousel];
    [_carousel release];
   
    
    
    _navItem.title = @"封面展示";
    
    UIButton * aBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    aBtn.backgroundColor = [UIColor whiteColor];
    [aBtn setTitle:@"展示效果" forState:UIControlStateNormal];
    [aBtn addTarget:self action:@selector(switchCarouselType) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aBtn];
    [aBtn setMargin:UIEdgeInsetsMake(30, 10, X, X)];
    [aBtn setSizeView:CGSizeMake(100, 30)];
    
    UIButton * bBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    bBtn.backgroundColor = [UIColor whiteColor];
    [bBtn setTitle:@"边界开/关" forState:UIControlStateNormal];
    [bBtn addTarget:self action:@selector(toggleWrap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bBtn];
    [bBtn setMargin:UIEdgeInsetsMake(30, X, X, 10)];
    [bBtn setSizeView:CGSizeMake(100, 30)];
    
    
}

- (void)switchCarouselType
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择类型" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"直线", @"圆圈", @"反向圆圈", @"圆桶", @"反向圆桶", @"封面展示", @"封面展示2", @"折纸",@"折纸2",@"左纸牌",@"右纸牌", nil];
    [sheet showInView:self.view];
    [sheet release];
}

- (void)toggleWrap
{
    _wrap = !_wrap;
    _navItem.rightBarButtonItem.title = _wrap? @"边界:ON": @"边界:OFF";
    [_carousel reloadData];
}
#pragma mark -

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    for (UIView *view in _carousel.visibleItemViews)
    {
        view.alpha = 1.0;
    }
    
    [UIView beginAnimations:nil context:nil];
    _carousel.type = (int)buttonIndex;
    [UIView commitAnimations];
    
    _navItem.title = [actionSheet buttonTitleAtIndex:buttonIndex];
}

#pragma mark -

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 80;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable imgView *)view
{

    if (view == nil)
    {
//        //阴影
//        view = [[[ReflectionView alloc] init] autorelease];
//        view.layer.backgroundColor = [UIColor clearColor].CGColor;
//        view.frame = CGRectMake(70, 80, 180, 260);
//        //view.dynamic = YES;// yes 关, no 开(默认)
//        ((ReflectionView*)view).reflectionScale = 0.2;
        
        view = [[imgView alloc] initWithFrame:CGRectMake(0, 0, 180, 260)];
        view.contentMode = UIViewContentModeCenter;
    }
    ((imgView*)view).str =[NSString stringWithFormat:@"%@",@(index)];
    //[view setNeedsDisplay];
    
//    UIImage * img                   = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",@(index)]]];
//    view.layer.contents        = (id)img.CGImage;
    
    return view;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return ITEM_SPACING;
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform{
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.carousel.itemWidth);
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return self.wrap;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax:
        {
            if (self.carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}

//------------------

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.carousel = nil;
    self.navItem = nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (void)dealloc
{
    [_carousel release];
    [_navItem release];
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
    [super dealloc];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [_carousel removeFromSuperview];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
