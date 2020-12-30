//
//  JSViewController.m
//  iOS8Style-ImagePicker
//
//  Created by Jake Sieradzki on 09/01/2015.
//  Copyright (c) 2015 Jake Sieradzki. All rights reserved.
//

#import "JSViewController.h"
#import "JSImagePickerViewController.h"

@interface JSViewController () <JSImagePickerViewControllerDelegate>
@property (nonatomic, retain) UIButton *showButton;
@property (nonatomic, retain)UIImageView *img;
@end

@implementation JSViewController

- (void)viewDidLoad {
  [super viewDidLoad];
    _showButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _showButton.frame = CGRectMake(100, 100, 100, 40);
    [_showButton setTitle:@"选取图片" forState:UIControlStateNormal];
    _showButton.backgroundColor = [UIColor colorWithRed:0.527 green:0.767 blue:1.000 alpha:1.000];
    [_showButton addTarget:self action:@selector(showBtnWasPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_showButton];

    
    self.img = [[UIImageView alloc] initWithFrame:CGRectMake(10, _showButton.lyBottom+10, self.view.lyWidth-20, 200)];
    _img.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    _img.image = [UIImage imageNamed:@""];
    [self.view addSubview:_img];
    
    
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)showBtnWasPressed{
  JSImagePickerViewController *imagePicker = [[JSImagePickerViewController alloc] init];
  imagePicker.delegate = self;
  [imagePicker showImagePickerInController:self animated:YES];
}

#pragma mark - JSImagePikcerViewControllerDelegate

- (void)imagePicker:(JSImagePickerViewController *)imagePicker didSelectImage:(UIImage *)image {
  self.img.image = image;
}

@end
