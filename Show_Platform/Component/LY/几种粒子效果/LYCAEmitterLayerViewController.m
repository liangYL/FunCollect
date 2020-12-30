//
//  LYCAEmitterLayerViewController.m
//  
//
//  Created by liang on 15/12/31.
//
//

#import "LYCAEmitterLayerViewController.h"
#import <QuartzCore/CoreAnimation.h>

@interface LYCAEmitterLayerViewController ()
@property (strong) CAEmitterLayer *snowEmitter;
@property (strong) CAEmitterLayer *fireworksEmitter;

@property (strong) CAEmitterLayer *ringEmitter;
@property (strong) CAEmitterLayer *heartsEmitter;

@end

@implementation LYCAEmitterLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    
    //@"雪花",@"烟花",@"点击几种效果",@"火焰",@"爆炸",@"点击爆炸"
    switch ([_indexType integerValue]) {
        case 0:
            [self xuehua];
            break;
        case 1:
            [self yanhua];
            break;
        case 2:
            self.view.backgroundColor = [UIColor blackColor];
            [self jizhongxiaoguo];
            break;
        case 3:
            [self huoyan];
            break;
        case 4:
            [self baozha];
            break;
        case 5:
            [self dianjibaozha];
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame = CGRectMake((self.view.lyWidth-100)/2, self.view.lyBottom-140, 100, 40);
            [btn setTitle:@"按钮" forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor redColor];
            [btn addTarget:self action:@selector(likeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];

            break;
        default:
            break;
    }
    
}

-(void)xuehua{
    //创建粒子对象
    self.snowEmitter = [CAEmitterLayer layer];
    //粒子发射的位置
    _snowEmitter.emitterPosition = CGPointMake(self.view.bounds.size.width / 2.0, -30);
    //发射源的大小
    _snowEmitter.emitterSize		= CGSizeMake(self.view.bounds.size.width * 2.0, 0.0);;
    
    // Spawn points for the flakes are within on the outline of the line
    _snowEmitter.emitterMode		= kCAEmitterLayerOutline;//发射模式
    _snowEmitter.emitterShape	= kCAEmitterLayerLine;//发射源形状
    
    // Configure the snowflake emitter cell
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];//元素
    
    snowflake.birthRate		= 1.0;//每次产生的个数
    snowflake.lifetime		= 120.0;//生命周期多少秒
    
    snowflake.velocity		= -10;				// falling down slowly
    snowflake.velocityRange = 10;
    snowflake.yAcceleration = 2;
    snowflake.emissionRange = 0.5 * M_PI;		// some variation in angle 发射角度
    snowflake.spinRange		= 0.25 * M_PI;		// slow spin 旋转角度
    
    snowflake.contents		= (id) [[UIImage imageNamed:@"DazFlake"] CGImage];
    snowflake.color			= [[UIColor colorWithWhite:0.902 alpha:1.000] CGColor];
    //改变大小
    snowflake.scaleRange =(float)(arc4random()%100)/100 ;
    
    // Make the flakes seem inset in the background
    _snowEmitter.shadowOpacity = 1.0;
    _snowEmitter.shadowRadius  = 0.0;
    _snowEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
    _snowEmitter.shadowColor   = [[UIColor whiteColor] CGColor];
    
    // Add everything to our backing layer below the UIContol defined in the storyboard
    _snowEmitter.emitterCells = [NSArray arrayWithObject:snowflake];
    [self.view.layer insertSublayer:_snowEmitter atIndex:0];

}

-(void)yanhua{
    // Cells spawn in the bottom, moving up
    self.fireworksEmitter = [CAEmitterLayer layer];
    CGRect viewBounds = self.view.layer.bounds;
    _fireworksEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height);
    _fireworksEmitter.emitterSize	= CGSizeMake(viewBounds.size.width/2.0, 0.0);
    _fireworksEmitter.emitterMode	= kCAEmitterLayerOutline;
    _fireworksEmitter.emitterShape	= kCAEmitterLayerLine;
    _fireworksEmitter.renderMode		= kCAEmitterLayerAdditive;
    _fireworksEmitter.seed = (arc4random()%100)+1;
    
    // Create the rocket
    CAEmitterCell* rocket = [CAEmitterCell emitterCell];
    
    rocket.birthRate		= 1.0;
    rocket.emissionRange	= 0.25 * M_PI;  // some variation in angle
    rocket.velocity			= 380;
    rocket.velocityRange	= 100;
    rocket.yAcceleration	= 75;
    rocket.lifetime			= 1.02;	// we cannot set the birthrate < 1.0 for the burst
    
    rocket.contents			= (id) [[UIImage imageNamed:@"DazRing"] CGImage];
    rocket.scale			= 0.2;
    rocket.color			= [[UIColor redColor] CGColor];
    rocket.greenRange		= 1.0;		// different colors
    rocket.redRange			= 1.0;
    rocket.blueRange		= 1.0;
    rocket.spinRange		= M_PI;		// slow spin
    
    
    
    // the burst object cannot be seen, but will spawn the sparks
    // we change the color here, since the sparks inherit its value
    CAEmitterCell* burst = [CAEmitterCell emitterCell];
    
    burst.birthRate			= 1.0;		// at the end of travel
    burst.velocity			= 0;
    burst.scale				= 2.5;
    burst.redSpeed			=-1.5;		// shifting
    burst.blueSpeed			=+1.5;		// shifting
    burst.greenSpeed		=+1.0;		// shifting
    burst.lifetime			= 0.35;
    
    // and finally, the sparks
    CAEmitterCell* spark = [CAEmitterCell emitterCell];
    
    spark.birthRate			= 400;
    spark.velocity			= 125;
    spark.emissionRange		= 2* M_PI;	// 360 deg
    spark.yAcceleration		= 75;		// gravity
    spark.lifetime			= 3;
    
    spark.contents			= (id) [[UIImage imageNamed:@"DazHeart"] CGImage];
    spark.scaleSpeed		=-0.2;
    spark.greenSpeed		=-0.1;
    spark.redSpeed			= 0.4;
    spark.blueSpeed			=-0.1;
    spark.alphaSpeed		=-0.25;
    spark.spin				= 2* M_PI;
    spark.spinRange			= 2* M_PI;
    
    // putting it together
    _fireworksEmitter.emitterCells	= [NSArray arrayWithObject:rocket];
    rocket.emitterCells				= [NSArray arrayWithObject:burst];
    burst.emitterCells				= [NSArray arrayWithObject:spark];
    [self.view.layer addSublayer:_fireworksEmitter];
}
-(void)jizhongxiaoguo{
    CGRect viewBounds = self.view.layer.bounds;
    
    // Create the emitter layer
    self.ringEmitter = [CAEmitterLayer layer];
    
    // Cells spawn in a 50pt circle around the position
    self.ringEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height/2.0);
    self.ringEmitter.emitterSize	= CGSizeMake(50, 0);
    self.ringEmitter.emitterMode	= kCAEmitterLayerOutline;
    self.ringEmitter.emitterShape	= kCAEmitterLayerCircle;
    self.ringEmitter.renderMode		= kCAEmitterLayerBackToFront;
    
    // Create the fire emitter cell
    CAEmitterCell* ring = [CAEmitterCell emitterCell];
    [ring setName:@"ring"];
    
    ring.birthRate			= 0;
    ring.velocity			= 250;
    ring.scale				= 0.5;
    ring.scaleSpeed			=-0.2;
    ring.greenSpeed			=-0.2;	// shifting to green
    ring.redSpeed			=-0.5;
    ring.blueSpeed			=-0.5;
    ring.lifetime			= 2;
    
    ring.color = [[UIColor whiteColor] CGColor];
    ring.contents = (id) [[UIImage imageNamed:@"DazTriangle"] CGImage];
    
    
    CAEmitterCell* circle = [CAEmitterCell emitterCell];
    [circle setName:@"circle"];
    
    circle.birthRate		= 10;			// every triangle creates 20
    circle.emissionLongitude = M_PI * 0.5;	// sideways to triangle vector
    circle.velocity			= 50;
    circle.scale			= 0.5;
    circle.scaleSpeed		=-0.2;
    circle.greenSpeed		=-0.1;	// shifting to blue
    circle.redSpeed			=-0.2;
    circle.blueSpeed		= 0.1;
    circle.alphaSpeed		=-0.2;
    circle.lifetime			= 4;
    
    circle.color = [[UIColor whiteColor] CGColor];
    circle.contents = (id) [[UIImage imageNamed:@"DazRing"] CGImage];
    
    
    CAEmitterCell* star = [CAEmitterCell emitterCell];
    [star setName:@"star"];
    
    star.birthRate		= 10;	// every triangle creates 20
    star.velocity		= 100;
    star.zAcceleration  = -1;
    star.emissionLongitude = -M_PI;	// back from triangle vector
    star.scale			= 0.5;
    star.scaleSpeed		=-0.2;
    star.greenSpeed		=-0.1;
    star.redSpeed		= 0.4;	// shifting to red
    star.blueSpeed		=-0.1;
    star.alphaSpeed		=-0.2;
    star.lifetime		= 2;
    
    star.color = [[UIColor whiteColor] CGColor];
    star.contents = (id) [[UIImage imageNamed:@"DazStarOutline"] CGImage];
    
    // First traigles are emitted, which then spawn circles and star along their path
    self.ringEmitter.emitterCells = [NSArray arrayWithObject:ring];
    ring.emitterCells = [NSArray arrayWithObjects:circle, star, nil];
    //circle.emitterCells = [NSArray arrayWithObject:star];	// this is SLOW!
    [self.view.layer addSublayer:self.ringEmitter];
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    [self touchAtPosition:touchPoint];
}
- (void) touchAtPosition:(CGPoint)position
{
    // Bling bling..
    CABasicAnimation *burst = [CABasicAnimation animationWithKeyPath:@"emitterCells.ring.birthRate"];
    burst.fromValue			= [NSNumber numberWithFloat: 125.0];	// short but intense burst
    burst.toValue			= [NSNumber numberWithFloat: 0.0];		// each birth creates 20 aditional cells!
    burst.duration			= 0.5;
    burst.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.ringEmitter addAnimation:burst forKey:@"burst"];
    
    // Move to touch point
    [CATransaction begin];
    [CATransaction setDisableActions: YES];
    self.ringEmitter.emitterPosition = position;
    [CATransaction commit];
}





-(void)huoyan{
    CGRect viewBounds = self.view.layer.bounds;
    
    // Create the emitter layers
    CAEmitterLayer * fireEmitter	= [CAEmitterLayer layer];
    CAEmitterLayer *smokeEmitter	= [CAEmitterLayer layer];
    
    // Place layers just above the tab bar
    fireEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height - 60);
    fireEmitter.emitterSize	= CGSizeMake(viewBounds.size.width/2.0, 0);
    fireEmitter.emitterMode	= kCAEmitterLayerOutline;
    fireEmitter.emitterShape	= kCAEmitterLayerLine;
    // with additive rendering the dense cell distribution will create "hot" areas
    fireEmitter.renderMode		= kCAEmitterLayerAdditive;
    
    smokeEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height - 60);
    smokeEmitter.emitterMode	= kCAEmitterLayerPoints;
    
    // Create the fire emitter cell
    CAEmitterCell* fire = [CAEmitterCell emitterCell];
    [fire setName:@"fire"];
    
    fire.birthRate			= 100;
    fire.emissionLongitude  = M_PI;
    fire.velocity			= -80;
    fire.velocityRange		= 30;
    fire.emissionRange		= 1.1;
    fire.yAcceleration		= -200;
    fire.scaleSpeed			= 0.3;
    fire.lifetime			= 50;
    fire.lifetimeRange		= (50.0 * 0.35);
    
    fire.color = [[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1] CGColor];
    fire.contents = (id) [[UIImage imageNamed:@"DazFire"] CGImage];
    
    
    // Create the smoke emitter cell
    CAEmitterCell* smoke = [CAEmitterCell emitterCell];
    [smoke setName:@"smoke"];
    
    smoke.birthRate			= 11;
    smoke.emissionLongitude = -M_PI / 2;
    smoke.lifetime			= 10;
    smoke.velocity			= -40;
    smoke.velocityRange		= 20;
    smoke.emissionRange		= M_PI / 4;
    smoke.spin				= 1;
    smoke.spinRange			= 6;
    smoke.yAcceleration		= -160;
    smoke.contents			= (id) [[UIImage imageNamed:@"DazSmoke"] CGImage];
    smoke.scale				= 0.1;
    smoke.alphaSpeed		= -0.12;
    smoke.scaleSpeed		= 0.7;
    
    
    // Add the smoke emitter cell to the smoke emitter layer
    smokeEmitter.emitterCells	= [NSArray arrayWithObject:smoke];
    fireEmitter.emitterCells	= [NSArray arrayWithObject:fire];
    [self.view.layer addSublayer:smokeEmitter];
    [self.view.layer addSublayer:fireEmitter];
    
    /*---*/
    
    //火焰高度
    CGFloat zeroToOne = (arc4random()%100+50)/100.0;
    // Update the fire properties
    [fireEmitter setValue:[NSNumber numberWithInt:(zeroToOne * 500)]
               forKeyPath:@"emitterCells.fire.birthRate"];
    [fireEmitter setValue:[NSNumber numberWithFloat:zeroToOne]
               forKeyPath:@"emitterCells.fire.lifetime"];
    [fireEmitter setValue:[NSNumber numberWithFloat:(zeroToOne * 0.35)]
               forKeyPath:@"emitterCells.fire.lifetimeRange"];
    fireEmitter.emitterSize = CGSizeMake(50 * zeroToOne, 0);
    
    [smokeEmitter setValue:[NSNumber numberWithInt:zeroToOne * 4]
                forKeyPath:@"emitterCells.smoke.lifetime"];
    [smokeEmitter setValue:(id)[[UIColor colorWithRed:1 green:1 blue:1 alpha:zeroToOne * 0.3] CGColor]
                forKeyPath:@"emitterCells.smoke.color"];
}

-(void)baozha{
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.view.bounds;
    [self.view.layer addSublayer:emitter];
    
    //configure emitter
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0, emitter.frame.size.height / 2.0);
    
    //create a particle template
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"DazStarOutline"].CGImage;
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2.0;
    
    //add particle template to emitter
    emitter.emitterCells = @[cell];

}
-(void)dianjibaozha{
    self.heartsEmitter = [CAEmitterLayer layer];
    self.heartsEmitter.emitterPosition = CGPointMake(100,400);
    self.heartsEmitter.emitterSize = CGSizeMake(100, 200);
    
    // Spawn points for the hearts are within the area defined by the button frame
    self.heartsEmitter.emitterMode = kCAEmitterLayerVolume;
    self.heartsEmitter.emitterShape = kCAEmitterLayerRectangle;
    self.heartsEmitter.renderMode = kCAEmitterLayerAdditive;
    
    // Configure the emitter cell
    CAEmitterCell *heart = [CAEmitterCell emitterCell];
    heart.name = @"heart";
    
    heart.emissionLongitude = M_PI/2.0; // up
    heart.emissionRange = 0.55 * M_PI;  // in a wide spread
    heart.birthRate		= 0.0;			// emitter is deactivated for now
    heart.lifetime		= 6.0;			// hearts vanish after 10 seconds
    
    heart.velocity		= -120;			// particles get fired up fast
    heart.velocityRange = 60;			// with some variation
    heart.yAcceleration = 20;			// but fall eventually
    
    heart.contents		= (id) [[UIImage imageNamed:@"DazHeart"] CGImage];
    heart.color			= [[UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:0.5] CGColor];
    heart.redRange		= 0.3;			// some variation in the color
    heart.blueRange		= 0.3;
    heart.alphaSpeed	= -0.5 / heart.lifetime;  // fade over the lifetime
    
    heart.scale			= 0.15;			// let them start small
    heart.scaleSpeed	= 0.5;			// but then 'explode' in size
    heart.spinRange		= 2.0 * M_PI;	// and send them spinning from -180 to +180 deg/s
    
    // Add everything to our backing layer
    self.heartsEmitter.emitterCells = [NSArray arrayWithObject:heart];
    [self.view.layer addSublayer:_heartsEmitter];

}
- (void) likeButtonPressed
{
    // Fires up some hearts to rain on the view
    CABasicAnimation *heartsBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.heart.birthRate"];
    heartsBurst.fromValue		= [NSNumber numberWithFloat:150.0];
    heartsBurst.toValue			= [NSNumber numberWithFloat:  0.0];
    heartsBurst.duration		= 3.0;
    heartsBurst.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.heartsEmitter addAnimation:heartsBurst forKey:@"heartsBurst"];
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [self.snowEmitter removeFromSuperlayer];
    self.snowEmitter = nil;
    
    [self.fireworksEmitter removeFromSuperlayer];
    self.fireworksEmitter = nil;
    
    [self.heartsEmitter removeFromSuperlayer];
    self.heartsEmitter = nil;
    [self.ringEmitter removeFromSuperlayer];
    self.ringEmitter = nil;
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
