//
//  PopBtnViewController.m
//  Show_Platform
//
//  Created by liang on 15/3/27.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "PopBtnViewController.h"
//第二种
#import "UIView+Screenshot.h"
#import "UIImage+ImageEffects.h"
#import "FancyTabBar.h"
//第三种
#import "AwesomeMenu.h"
@interface PopBtnViewController ()<FancyTabBarDelegate, AwesomeMenuDelegate>
@property(nonatomic,retain)UILabel *aLabel1;
@property(nonatomic,retain)UILabel *aLabel2;
@property(nonatomic,retain)UILabel *aLabel3;
@property(nonatomic,retain)UILabel *aLabel4;
@property(nonatomic,retain)UILabel *aLabel5;
@property(nonatomic,retain)UIView *aView;
@property(nonatomic,retain)UILabel * backView;
//第二种
@property(nonatomic,strong) FancyTabBar *fancyTabBar;
@property (nonatomic,strong) UIImageView *backgroundView;
@end

@implementation PopBtnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    [self createContextSheet];
/*
    NSInteger age = 60;
    
    _aLabel1 = [[UILabel alloc] init];
    _aLabel1.text = @"长按";
    _aLabel1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_aLabel1];
    [_aLabel1 setMargin:UIEdgeInsetsMake(age, age, X, X)];
    [_aLabel1 setSizeView:CGSizeMake(40, 40)];
    
    _aLabel2 = [[UILabel alloc] init];
    _aLabel2.text = @"长按";
    _aLabel2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_aLabel2];
    [_aLabel2 setMargin:UIEdgeInsetsMake(X, age, age, X)];
    [_aLabel2 setSizeView:CGSizeMake(40, 40)];
    
    _aLabel3 = [[UILabel alloc] init];
    _aLabel3.text = @"长按";
    _aLabel3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_aLabel3];
    [_aLabel3 setMargin:UIEdgeInsetsMake(age, X, X, age)];
    [_aLabel3 setSizeView:CGSizeMake(40, 40)];
    
    _aLabel4 = [[UILabel alloc] init];
    _aLabel4.text = @"长按";
    _aLabel4.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_aLabel4];
    [_aLabel4 setMargin:UIEdgeInsetsMake(X, X, age,age)];
    [_aLabel4 setSizeView:CGSizeMake(40, 40)];
    _aLabel1.userInteractionEnabled = YES;
    _aLabel2.userInteractionEnabled = YES;
    _aLabel3.userInteractionEnabled = YES;
    _aLabel4.userInteractionEnabled = YES;
*/
    
    
    _backView = [[UILabel alloc] init];
    _backView.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    _backView.text = @"长按背景";
    _backView.textAlignment = NSTextAlignmentCenter;
    _backView.textColor = [UIColor colorWithWhite:0.600 alpha:1.000];
    [self.view addSubview:_backView];
    [_backView setAutoLayoutBlock:^{
        [_backView setMargin:UIEdgeInsetsMake(0, 0, 300, 0)];
        [_backView release];
    }];

    UIGestureRecognizer *gest1 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    [self.view addGestureRecognizer:gest1];
    
    
    //第二种
    
    _fancyTabBar = [[FancyTabBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-100)];
    [_fancyTabBar setUpChoices:self choices:@[@"gallery",@"dropbox",@"camera",@"draw"] withMainButtonImage:[UIImage imageNamed:@"main_button"]];
    _fancyTabBar.delegate = self;
    [self.view addSubview:_fancyTabBar];
    
    
    //第三种
    [self creatAwesomeMenu];
    
    
}
//第一种方法代理
# pragma mark---
- (void) createContextSheet {
    VLDContextSheetItem *item1 = [[VLDContextSheetItem alloc] initWithTitle: @"礼包"
                                                                      image: [UIImage imageNamed: @"gift_button@2x"]
                                                           highlightedImage: [UIImage imageNamed: @"gift_button2@2x"]];
    VLDContextSheetItem *item2 = [[VLDContextSheetItem alloc] initWithTitle: @"下载"
                                                                      image: [UIImage imageNamed: @"add_to_collection_button@2x"]
                                                           highlightedImage: [UIImage imageNamed: @"add_to_collection_button2@2x"]];
    VLDContextSheetItem *item3 = [[VLDContextSheetItem alloc] initWithTitle: @"分享"
                                                                      image: [UIImage imageNamed: @"share_button@2x"]
                                                           highlightedImage: [UIImage imageNamed: @"share_button2@2x"]];
    self.contextSheet = [[VLDContextSheet alloc] initWithItems: @[ item1, item2, item3]];
    self.contextSheet.delegate = self;
}



- (void) contextSheet: (VLDContextSheet *) contextSheet didSelectItem: (VLDContextSheetItem *) item {
    NSLog(@"Selected item: %@", item.title);
}


- (void) longPressed: (UIGestureRecognizer *) gestureRecognizer {
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        //_aLabel1.alpha = 0;_aLabel2.alpha = 0;_aLabel3.alpha = 0;_aLabel4.alpha = 0;
        _backView.alpha=0;
        [self.contextSheet startWithGestureRecognizer: gestureRecognizer
                                               inView: self.view];
    }
    if (gestureRecognizer.state  == UIGestureRecognizerStateEnded) {
        //_aLabel1.alpha = 1;_aLabel2.alpha = 1;_aLabel3.alpha = 1;_aLabel4.alpha = 1;
        _backView.alpha=1;
    }
}

- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) toInterfaceOrientation
                                 duration: (NSTimeInterval) duration {
    [super willRotateToInterfaceOrientation: toInterfaceOrientation duration: duration];
    [self.contextSheet end];
}

//第二种方法代理
#pragma mark - FancyTabBarDelegate
- (void) didCollapse{
    [UIView animateWithDuration:0.3 animations:^{
        _backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        if(finished) {
            [_backgroundView removeFromSuperview];
            _backgroundView = nil;
        }
    }];
}


- (void) didExpand{
    if(!_backgroundView){
        _backgroundView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _backgroundView.alpha = 0;
        [self.view addSubview:_backgroundView];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
    }];
    
    [self.view bringSubviewToFront:_fancyTabBar];
    UIImage *backgroundImage = [self.view convertViewToImage];
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    UIImage *image = [backgroundImage applyBlurWithRadius:10 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
    _backgroundView.image = image;
}
// PERFORM SEGUES TO NEXT VIEWS BASED ON INDEX PATH
- (void)optionsButton:(UIButton*)optionButton didSelectItem:(int)index{
    NSLog(@"Hello index %d tapped !", index);
    //GALLERY SEGUE
    if (index == 1) {
        //[self performSegueWithIdentifier:@"YOUR NEXT VIEW" sender: self];
    }
}


//第三种
-(void)creatAwesomeMenu{
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
    
    // 1(四边展开)
    AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem4 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    
    
    NSArray *menuItems = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, nil];
    
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg-addbutton.png"]
                                                       highlightedImage:[UIImage imageNamed:@"bg-addbutton-highlighted.png"]
                                                           ContentImage:[UIImage imageNamed:@"icon-plus.png"]
                                                highlightedContentImage:[UIImage imageNamed:@"icon-plus-highlighted.png"]];
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:self.view.bounds startItem:startItem menuItems:menuItems];
    //多种属性设置nearRadius, endRadius, farRadius, timeOffset, rotateAngle, menuWholeAngle, startPoint, expandRotation, closeRotation, animationDuration, rotateAddButton;
    menu.farRadius = 50;
    menu.endRadius = 80;
    menu.delegate = self;
    [self.view addSubview:menu];
    
    //  2(展开1/4)
    AwesomeMenuItem *starMenuItem11 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem22 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem33 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem44 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    
    NSArray *menus = [NSArray arrayWithObjects:starMenuItem11, starMenuItem22, starMenuItem33, starMenuItem44, nil];
    
    AwesomeMenuItem *startItem11 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg-addbutton.png"]
                                                       highlightedImage:[UIImage imageNamed:@"bg-addbutton-highlighted.png"]
                                                           ContentImage:[UIImage imageNamed:@"icon-plus.png"]
                                                highlightedContentImage:[UIImage imageNamed:@"icon-plus-highlighted.png"]];
    
    AwesomeMenu *menu11 = [[AwesomeMenu alloc] initWithFrame:self.view.bounds startItem:startItem11 optionMenus:menus];
    menu11.delegate = self;
    
    menu11.menuWholeAngle = M_PI_2;
    menu11.farRadius = 110.0f;
    menu11.endRadius = 100.0f;
    menu11.nearRadius = 90.0f;
    menu11.animationDuration = 0.3f;
    menu11.startPoint = CGPointMake(50.0, 410.0);
    
    [self.view addSubview:menu11];
    
}
//代理方法
- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSLog(@"Select the index : %d",idx);
}
- (void)awesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu {
    NSLog(@"Menu was closed!");
}
- (void)awesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu {
    NSLog(@"Menu is open!");
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
