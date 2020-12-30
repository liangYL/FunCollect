//
//  CanvasAnimationsTableViewController.m
//  Show_Platform
//
//  Created by liang on 15/7/3.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "CanvasAnimationsTableViewController.h"
#import "CSAnimationView.h"

@interface CanvasAnimationsTableViewController ()
{
    CSAnimationView*a;
}
@property(nonatomic,retain)NSArray *dataArray;

@end

@implementation CanvasAnimationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.rowHeight = 60;
 self.dataArray=@[@"bounceLeft",@"bounceRight",@"bounceDown",@"bounceUp",@"fadeIn",@"fadeOut",@"fadeInLeft",@"fadeInRight",@"fadeInDown",@"fadeInUp",@"slideLeft",@"slideRight",@"slideDown",@"slideUp",@"pop",@"morph",@"flash",@"shake",@"zoomIn",@"zoomOut",@"slideDownReverse",@"fadeInSemi",@"fadeOutSemi",@"fadeOutRight",@"fadeOutLeft",@"popDown",@"popAlpha",@"popAlphaUp",@"popAlphaOut"];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  UITableViewDelegate,DataSource, -- UiTableView方法
//区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
////行高
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 60;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static  NSString *str =@"cell";
    //UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:str];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell ==nil)
    {
        cell =[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        a= [[CSAnimationView alloc] initWithFrame:CGRectMake(200, 5, 50, 50)];
        a.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
        a.type = [self.dataArray objectAtIndex:indexPath.row];
        a.duration = 1;
        [cell addSubview:a];
        [a release];
        a.layer.masksToBounds = YES;
        a.layer.cornerRadius = 25;
        [a startCanvasAnimation];
        
        UIImage * img= [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", arc4random()%40]];
        a.layer.contents = (id)img.CGImage;
        a.layer.backgroundColor = [UIColor clearColor].CGColor;

    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"类型: %@",[self.dataArray objectAtIndex:indexPath.row]];
    
    return cell;
}

//选中行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell startCanvasAnimation];
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell startCanvasAnimation];
    cell.backgroundColor = [UIColor clearColor];
}

-(NSArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSArray array];
    }
    return _dataArray;
}




@end
