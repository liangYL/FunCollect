//
//  ViewController.m
//  Puzze
//
//  Created by WHNUKE on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PuzzleViewController.h"

@implementation PuzzleViewController

#define everynumber 100

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijingtu.png"]];
//    UIImage *image = [UIImage imageNamed:@"beijingtu.png"];
//    self.view.layer.contents = (id)image.CGImage;
    UIButton * aBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    aBtn.frame = CGRectMake(100, 330, 100, 30);
    aBtn.backgroundColor = [UIColor whiteColor];
    [aBtn setTitle:@"点击换图" forState:UIControlStateNormal];
    [aBtn addTarget:self action:@selector( Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aBtn];
    
    [self Click];
    
   }
-(void)Click{

    for (UIView *a in self.view.subviews) {
        if ([a isKindOfClass:[UIImageView class]]) {
            [a removeFromSuperview];
        }
    }
    
    NSDictionary *dict = [[NSDictionary alloc] init];
    dict = [self SeparateImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",arc4random()%36]] ByX:3 andY:3 cacheQuality:1];
    
    tempimage = [[UIImageView alloc] initWithFrame:CGRectMake(210, 210, everynumber, everynumber)];
    tempimage.tag = 100;
    //tempimage.backgroundColor = [UIColor redColor];
    [self.view addSubview:tempimage];
    [tempimage release];
    
    for(int i =0;i<3;i++)
    {
        for (int j = 0; j<3; j++)
        {
            NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSString *filepath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"win_%d_%d.jpg",i,j]];
            UIImage *image = [UIImage imageWithContentsOfFile:filepath];
            
            imgView = [[ImageView alloc] initWithImage:image];
            
            imgView.tag = i*2+j;
            if(i==1)
            {
                imgView.tag = i*2+j+1;
            }
            if(i==2)
            {
                imgView.tag = i*2+j+2;
            }
            imgView.delegate = self;
            imgView.frame = CGRectMake(everynumber*i+10, everynumber*j+10, everynumber, everynumber);
            [self.view addSubview:imgView];
            [imgView release];
        }
    }
    ImageView *img=(ImageView *)[self.view viewWithTag:imgView.tag];
    img.hidden= YES;

}





-(void)movedeciton:(UIImageView *)imageview
{
    CGFloat wid = imageview.frame.origin.x;
    CGFloat hig = imageview.frame.origin.y;
    
    if(tempimage.frame.origin.x==wid+everynumber&&tempimage.frame.origin.y==hig)
    {
        NSLog(@"right");
        [self rightchange:imageview];
    }
    if(tempimage.frame.origin.x==wid-everynumber&&tempimage.frame.origin.y==hig)
    {
        NSLog(@"left");
        [self leftchange:imageview];
    }
    if(tempimage.frame.origin.x==wid&&tempimage.frame.origin.y==hig+everynumber)
    {
        NSLog(@"down");
        [self downchange:imageview];
        
    }
    if(tempimage.frame.origin.x==wid&&tempimage.frame.origin.y==hig-everynumber)
    {
        NSLog(@"up");
        [self upchange:imageview];
    }
}

-(void)upchange:(UIImageView *)image
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    image.frame = CGRectMake(image.frame.origin.x, image.frame.origin.y-everynumber, everynumber, everynumber);
    tempimage.frame = CGRectMake(image.frame.origin.x,image.frame.origin.y+everynumber , everynumber, everynumber);
}
-(void)leftchange:(UIImageView *)image
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    image.frame = CGRectMake(image.frame.origin.x-everynumber, image.frame.origin.y, everynumber, everynumber);
    tempimage.frame = CGRectMake(image.frame.origin.x+everynumber,image.frame.origin.y, everynumber, everynumber);
}
-(void)rightchange:(UIImageView *)image
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    image.frame = CGRectMake(image.frame.origin.x+everynumber, image.frame.origin.y, everynumber, everynumber);
    tempimage.frame = CGRectMake(image.frame.origin.x-everynumber,image.frame.origin.y, everynumber, everynumber);
}
-(void)downchange:(UIImageView *)image
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    image.frame = CGRectMake(image.frame.origin.x, image.frame.origin.y+everynumber, everynumber, everynumber);
    tempimage.frame = CGRectMake(image.frame.origin.x,image.frame.origin.y-everynumber , everynumber, everynumber);
}

-(NSDictionary*)SeparateImage:(UIImage*)image ByX:(int)x andY:(int)y cacheQuality:(float)quality
{
	
	//kill errors
	if (x<1) {
		NSLog(@"illegal x!");
		return nil;
	}else if (y<1) {
		NSLog(@"illegal y!");
		return nil;
	}
	if (![image isKindOfClass:[UIImage class]]) {
		NSLog(@"illegal image format!");
		return nil;
	}
	
	//attributes of element
	float _xstep=image.size.width*1.0/y;
	float _ystep=image.size.height*1.0/x;
	NSMutableDictionary*_mutableDictionary=[[[NSMutableDictionary alloc]initWithCapacity:1]autorelease];
	//NSArray*_array=[imageName componentsSeparatedByString:@"."];
	//NSString*prefixName=[_array objectAtIndex:0];
	NSString*prefixName=@"win";
	
	//snap in context and create element image view
	for (int i=0; i<x; i++) 
	{
		for (int j=0; j<y; j++)
		{
			CGRect rect=CGRectMake(_xstep*j, _ystep*i, _xstep, _ystep);
			CGImageRef imageRef=CGImageCreateWithImageInRect([image CGImage],rect);
			UIImage* elementImage=[UIImage imageWithCGImage:imageRef];
			UIImageView*_imageView=[[UIImageView alloc] initWithImage:elementImage];
			_imageView.frame=rect;
			NSString*_imageString=[NSString stringWithFormat:@"%@_%d_%d.jpg",prefixName,i,j];
			[_mutableDictionary setObject:_imageView forKey:_imageString];
			//CFRelease(imageRef);
			if (quality<=0) 
			{
				continue;
			}
			quality=(quality>1)?1:quality;
            
            NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
			NSString*_imagePath=[path stringByAppendingPathComponent:_imageString];			NSData* _imageData=UIImageJPEGRepresentation(elementImage, quality);
            NSLog(@"%@",_imagePath);
			[_imageData writeToFile:_imagePath atomically:YES];
		}
	}
	//return dictionary including image views
	NSDictionary *_dictionary=_mutableDictionary;
	return _dictionary;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
