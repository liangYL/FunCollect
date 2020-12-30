//
//  LYDazzleMainViewController.m
//  
//
//  Created by liang on 15/12/31.
//
//

#import "LYDazzleMainViewController.h"
#import "LYCAEmitterLayerViewController.h"
@interface LYDazzleMainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)NSArray *dataArray;

@end

@implementation LYDazzleMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 50, self.view.frame.size.width-100, self.view.frame.size.height-200) style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    self.dataArray = @[@"雪花",@"烟花",@"点击几种效果",@"火焰",@"爆炸",@"点击爆炸"];
    tableView.separatorInset = UIEdgeInsetsMake(1, -15, 1, 15);
    tableView.separatorColor = [UIColor whiteColor];
    
    
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
    return 60;
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
        aLabel.backgroundColor = RandomColorLight;
    }
    
    
    
    return cell;
}

//选中行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LYCAEmitterLayerViewController * caEmitterVC = [[LYCAEmitterLayerViewController alloc] init];
    caEmitterVC.indexType = [NSString stringWithFormat:@"%@",@(indexPath.row)];
    [self.navigationController pushViewController:caEmitterVC animated:YES];
    
    
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
