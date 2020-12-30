//
//  ViewController.m
//  tableView的Cell展开和关闭
//
//  Created by qianfeng on 15/11/5.
//  Copyright (c) 2015年 李明星. All rights reserved.
//

#import "LYkgViewController.h"
#import "HeaderView.h"


@interface LYkgViewController ()<UITableViewDataSource,UITableViewDelegate>
//tableView
@property(nonatomic)UITableView *tableView;

//数据源每区下每行数据
@property(nonatomic)NSMutableArray *data;

//开关状态,点开/关闭,用0关,1开
@property(nonatomic)NSMutableArray *sectionStatus;

//每个区的标题
@property(nonatomic)NSMutableArray *titles;

//点击行,区头赋值
@property(nonatomic)NSMutableArray *centerTitles;


@end

@implementation LYkgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self createData];
    [self createUitableView];
    
    
}


-(void)createData
{
    //初始化每个区的开关状态
    _sectionStatus = [[NSMutableArray alloc] init];
    //_data = [[NSMutableArray alloc] init];
    _titles = [@[@"回访目的",@"交流类型",@"回访结果",@"关注类型",@"关注程度",@"产品名称",@"家庭情况",@"交流内容"] mutableCopy];
    
    //区下面行的数据
    _data =  [@[@[@"活动推广",@"自主营销",@"客户维护"],
                        @[@"眼睛",@"鼻子"],
                        @[@"好结果",@"坏结果"],
                        @[@"QQ",@"微信"],
                        @[@"只是喜欢",@"近期不购买",@"已购买",@"有购买意向"],
                        @[@"严重",@"一般"],
                        @[@"真龙天子酒",@"春夏秋冬"],
                        @[@"富豪",@"明星",@"警察"]
                        ] mutableCopy];
    
    
    //存放点击的元素
    _centerTitles = [[NSMutableArray alloc] init];
    //初始化空
    for (int i = 0; i< _titles.count; i++) {
        [_centerTitles addObject:@""];
    }
    //上下等价
    for (NSString *name in _titles) {
        NSLog(@"%@",name);
        [_sectionStatus addObject:@0];
    }
}

-(void)createUitableView
{

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height -20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
//    [_tableView registerClass:[AATableViewCell class] forCellReuseIdentifier:@"reusable"];
   
}


#pragma mark -代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _data.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_sectionStatus[section] isEqualToNumber:@0]) {
        return 0;
    }
    return [_data[section] count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString * str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    cell.textLabel.text = _data[indexPath.section][indexPath.row];
    return cell;
    
}
#pragma mark - 区视图
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = _titles[section];
    HeaderView*header = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    header.tag = 200+section;
    BOOL status = [_sectionStatus[section] boolValue];
    [header updateWith:title WithStatus:status];
    [header updateCenterWith:_centerTitles[section]];

    header.block =^{
        NSNumber *num = status? @0 :@1;
        [_sectionStatus replaceObjectAtIndex:section withObject:num];
        
            //重新加载当前区
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    };
    
    return header;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIView *vwTest = [self.tableView viewWithTag:200 + indexPath.section]; //[1]
    NSLog(@"[1] : %@",((HeaderView *)vwTest).aLabel.text);
    
    NSString * str = _data[indexPath.section][indexPath.row];
    [_centerTitles replaceObjectAtIndex:indexPath.section withObject:str];
    
    BOOL status = [_sectionStatus[indexPath.section] boolValue];
    NSNumber *num = status? @0 :@1;
    [_sectionStatus replaceObjectAtIndex:indexPath.section withObject:num];
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
