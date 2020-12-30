//
//  M13LoadingViewController.m
//  
//
//  Created by liang on 16/2/16.
//
//

#import "M13MainViewController.h"

@interface M13MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)NSArray *dataArray;

@end

@implementation M13MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 50, self.view.frame.size.width-100, self.view.frame.size.height-200) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    [self.view addSubview:tableView];
    
    tableView.layer.masksToBounds = NO;
    
    tableView.layer.cornerRadius = 10;
    
    self.dataArray = @[@"环形",@"条形",@"加载图片",@"..."];
    
    
    
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
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static  NSString *str =@"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:str];
    if (cell ==nil)
    {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel * aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 50)];
        aLabel.text = [self.dataArray objectAtIndex:indexPath.row];
        aLabel.textAlignment = NSTextAlignmentCenter;
        aLabel.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
        [cell addSubview:aLabel];
    }
    
    
    
    return cell;
}

//选中行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==3) {
        return;
    }
    
    NSArray * arr = @[@"CircularViewController",@"LinesViewController",@"M13ImageViewController"];
    
    [self.navigationController pushViewController:[[NSClassFromString(arr[indexPath.row]) alloc] init] animated:YES];
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
