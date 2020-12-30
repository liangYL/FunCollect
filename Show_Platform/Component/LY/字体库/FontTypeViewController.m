//
//  FontTypeViewController.m
//  Show_Platform
//
//  Created by liang on 15/7/24.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import "FontTypeViewController.h"

@interface FontTypeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)NSArray *dataArray;
@end

@implementation FontTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 50, self.view.frame.size.width-100, self.view.frame.size.height-200) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];


    self.dataArray = @[@"系统字体库",@"RTLabelDemo",@"MyAttributed"];


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
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static  NSString *str =@"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:str];
    if (cell ==nil)
    {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel * aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 40)];
        aLabel.text = [self.dataArray objectAtIndex:indexPath.row];
        aLabel.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:aLabel];
    }
    
   
    
    return cell;
}

//选中行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        [self.navigationController pushViewController:[[NSClassFromString(@"SysFontViewController") alloc] init] animated:YES];
    }else if(indexPath.row == 1){
        [self.navigationController pushViewController:[[NSClassFromString(@"DemoTableViewController") alloc] init] animated:YES];
    }else if(indexPath.row ==2 ){
        [self.navigationController pushViewController:[[NSClassFromString(@"DemoMyAttributeViewController") alloc] init] animated:YES];
    }
    
    
}


-(NSArray *)dataArray{
    if(!_dataArray){
        self.dataArray = [NSArray array];
    }
    return _dataArray;
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
