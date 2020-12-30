//
//  ViewController.m
//  LYWifiTransmission
//
//  Created by liang on 16/2/24.
//  Copyright (c) 2016年 梁银龙. All rights reserved.
//

#import "LYWifiViewController.h"
#import "HTTPServer.h"
#import "AYHTTPConnection.h"
#import "FLEXFileBrowserTableViewController.h"

#define GBUnit 1073741824
#define MBUnit 1048576
#define KBUnit 1024

@interface LYWifiViewController ()<UITableViewDataSource,UITableViewDelegate,UIDocumentInteractionControllerDelegate>
@property(strong,nonatomic)UITableView * tableView;
@property(strong,nonatomic)NSMutableArray * dataArray;
//预览
@property(nonatomic,retain)UIDocumentInteractionController *docController;


@property (strong, nonatomic) UIProgressView *progressView;   //upload progress
@property (strong, nonatomic) UILabel *lbHTTPServer;
@property (strong, nonatomic) UILabel *lbFileSize; //Total size of uploaded file
@property (strong, nonatomic) UILabel *lbCurrentFileSize;  //The size of the current upload



@end

@implementation LYWifiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化加载视图
    [self initViews];
    //添加通知
    [self addNotification];
    
    //初始化服务
    [self initServer];
    //开始服务
    [self startServer];
    
    //加载数据
    [self loadingData];
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [_httpserver stop];
}





#pragma mark- 加载数据

-(void)loadingData{
    if (self.dataArray.count>0) {
        [self.dataArray removeAllObjects];
    }
    //输出资源目录
    //缓存目录
    NSString *docoumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/lyResource"];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    //没有创建缓存目录
    if(![fm fileExistsAtPath:docoumentsPath])
    {
        [fm createDirectoryAtPath:docoumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //取出数据元素名称
    NSArray *files = [fm subpathsOfDirectoryAtPath:docoumentsPath error:nil];
    [self.dataArray addObjectsFromArray:files];
    
    
//    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager]enumeratorAtPath:docoumentsPath];
//    for (NSString *fileName in enumerator)
//    {
//        NSLog(@"------------%@",fileName);
//        [self.dataArray addObject:fileName];
//    }
    [_tableView reloadData];
}
#pragma mark-- 服务器

-(void)initServer{
    //初始化服务器
    _httpserver = [[HTTPServer alloc] init];
    [_httpserver setType:@"_http._tcp."];
    [_httpserver setPort:Host];//设置域
    NSString *webPath = [[[NSBundle mainBundle] pathForResource:@"website" ofType:@"bundle"] stringByAppendingPathComponent:@"website"];//index.html 位置
    [_httpserver setDocumentRoot:webPath];
    [_httpserver setConnectionClass:[AYHTTPConnection class]];//设置请求类
}
//启动服务
- (void) startServer
{
    NSError *error;
    if ([_httpserver start:&error])
    {
        NSString * wifiAdd =[NSString stringWithFormat:@"无线传输网址\nhttp://%@:%hu", [_httpserver hostName], [_httpserver listeningPort]];
        
        [_lbHTTPServer setText:wifiAdd];
        NSLog(@"%@",wifiAdd);
    }
    else
    {
        NSLog(@"启动失败Error Started HTTP Server:%@", error);
        //直接显示文件夹文件
        [self loadingData];
    }
}


#pragma mark--通知代理相关

-(void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadWithStart:) name:UPLOADSTART object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploading:) name:UPLOADING object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadWithEnd:) name:UPLOADEND object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadWithDisconnect:) name:UPLOADISCONNECTED object:nil];
}

//开始上传
- (void) uploadWithStart:(NSNotification *) notification
{
    UInt64 fileSize = [(NSNumber *)[notification.userInfo objectForKey:@"totalfilesize"] longLongValue];
    __block NSString *showFileSize = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        if (fileSize>GBUnit)
            showFileSize = [[NSString alloc] initWithFormat:@"/%.1fG", (CGFloat)fileSize / (CGFloat)GBUnit];
        if (fileSize>MBUnit && fileSize<=GBUnit)
            showFileSize = [[NSString alloc] initWithFormat:@"/%.1fMB", (CGFloat)fileSize / (CGFloat)MBUnit];
        else if (fileSize>KBUnit && fileSize<=MBUnit)
            showFileSize = [[NSString alloc] initWithFormat:@"/%lliKB", fileSize / KBUnit];
        else if (fileSize<=KBUnit)
            showFileSize = [[NSString alloc] initWithFormat:@"/%lliB", fileSize];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_lbFileSize setText:showFileSize];
            [_progressView setHidden:NO];
        });
    });
    showFileSize = nil;
}
//上传完成
- (void) uploadWithEnd:(NSNotification *) notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        currentDataLength = 0;
        //[_progressView setHidden:YES];
        [_progressView setProgress:0.0];
        [_lbFileSize setText:@""];
        [_lbCurrentFileSize setText:@""];
        
        UIAlertView * ni = [[UIAlertView alloc] initWithTitle:@"文件上传成功" message: nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [ni show];
        
        [self loadingData];

    });
    
}
//失去连接
- (void) uploadWithDisconnect:(NSNotification *) notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        currentDataLength = 0;
        [_progressView setHidden:YES];
        [_progressView setProgress:0.0];
        [_lbFileSize setText:@""];
        [_lbCurrentFileSize setText:@""];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information" message:@"连接中断!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
    });
}
//上传中
- (void) uploading:(NSNotification *)notification
{
    float value = [(NSNumber *)[notification.userInfo objectForKey:@"progressvalue"] floatValue];
    currentDataLength += [(NSNumber *)[notification.userInfo objectForKey:@"cureentvaluelength"] intValue];
    __block NSString *showCurrentFileSize = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        if (currentDataLength>GBUnit)
            showCurrentFileSize = [[NSString alloc] initWithFormat:@"%.1fG", (CGFloat)currentDataLength / (CGFloat)GBUnit];
        if (currentDataLength>MBUnit && currentDataLength<=GBUnit)
            showCurrentFileSize = [[NSString alloc] initWithFormat:@"%.1fMB", (CGFloat)currentDataLength / (CGFloat)MBUnit];
        else if (currentDataLength>KBUnit && currentDataLength<=MBUnit)
            showCurrentFileSize = [[NSString alloc] initWithFormat:@"%lliKB", currentDataLength / KBUnit];
        else if (currentDataLength<=KBUnit)
            showCurrentFileSize = [[NSString alloc] initWithFormat:@"%lliB", currentDataLength];
        dispatch_async(dispatch_get_main_queue(), ^{
            _progressView.progress += value;
            [_lbCurrentFileSize setText:showCurrentFileSize];
        });
    });
    showCurrentFileSize = nil;
}

# pragma mark -------------初始化

//初始化显示控件
- (void) initViews
{


//----传输文件显示


    //一.可以再其他应用程序预览的模式
    self.tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-100) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:_tableView];

    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 40);
    [rightBtn setImage:[UIImage imageNamed:@"screens"] forState:UIControlStateNormal];
    rightBtn.titleLabel.font =[UIFont systemFontOfSize:14.0];
    [rightBtn addTarget:self action:@selector(showFlex) forControlEvents: UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    
    
    
//------底部加载视图
    UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-160, self.view.frame.size.width, 120)];
    footView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.view addSubview:footView];
    
    //标题
    _lbHTTPServer = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, 300.0, 40.0)];
    [_lbHTTPServer setBackgroundColor:[UIColor clearColor]];
    [_lbHTTPServer setFont:[UIFont boldSystemFontOfSize:14.0]];
    [_lbHTTPServer setLineBreakMode:NSLineBreakByWordWrapping];
    [_lbHTTPServer setNumberOfLines:2];
    [footView addSubview:_lbHTTPServer];
    
    //上传量
    _lbFileSize = [[UILabel alloc] initWithFrame:CGRectMake(250.0, 55.0, 60.0, 20.0)];
    [_lbFileSize setBackgroundColor:[UIColor clearColor]];
    [_lbFileSize setFont:[UIFont boldSystemFontOfSize:13.0]];
    [footView addSubview:_lbFileSize];
    
    //总量
    _lbCurrentFileSize = [[UILabel alloc] initWithFrame:CGRectMake(188.0, 55.0, 60.0, 20.0)];
    [_lbCurrentFileSize setBackgroundColor:[UIColor clearColor]];
    [_lbCurrentFileSize setFont:[UIFont boldSystemFontOfSize:13.0]];
    [_lbCurrentFileSize setTextAlignment:NSTextAlignmentRight];
    [footView addSubview:_lbCurrentFileSize];
    
    //进度条
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    [_progressView setFrame:CGRectMake(10.0, 80.0, 300.0, 20.0)];
    [_progressView setBackgroundColor:[UIColor grayColor]];
    [_progressView setHidden:NO];
    [footView addSubview:_progressView];
    
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
        
    }
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

//选中行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //缓存目录
    NSString *docoumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/lyResource"];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *files = [fm subpathsOfDirectoryAtPath:docoumentsPath error:nil];

    NSString * str =[NSString stringWithFormat:@"%@/%@",docoumentsPath,[files objectAtIndex:indexPath.row]];
    
    //一定要用路径错误写法[NSURL URLWithString:@""]
    NSURL *url = [NSURL fileURLWithPath:str];
    
    if (self.docController == nil){
        self.docController = [UIDocumentInteractionController interactionControllerWithURL:url];
        self.docController.delegate = self;
    }
    else{
        self.docController.URL = url;
    }

    //[self.docController presentOptionsMenuFromRect:CGRectMake(10, 10, 300, 300) inView:self.view animated:YES];
    //显示不包含预览菜单项
    [self.docController presentOpenInMenuFromRect:CGRectMake(10, 10, 300, 300) inView:self.view animated:YES];
}



#pragma mark  --DocumentInteractionControllerDelegate

- (UIViewController*)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController*)controller
{
    return self;
}
- (UIView*)documentInteractionControllerViewForPreview:(UIDocumentInteractionController*)controller
{
    return self.view;
}
- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController*)controller
{
    
    return self.view.frame;
}
//点击预览窗口的“Done”(完成)按钮时调用

- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController*)_controller
{
    // [_controller autorelease];
    NSLog(@"------");
}



#pragma mark  --切换模式

-(void)showFlex
{
    //缓存目录
    NSString *docoumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/lyResource"];
    FLEXFileBrowserTableViewController * aa= [[FLEXFileBrowserTableViewController alloc] initWithPath:docoumentsPath];
    [self.navigationController pushViewController:aa animated:YES];

    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 40);
    [rightBtn setTitle:@"根目录" forState: UIControlStateNormal];
    rightBtn.titleLabel.font =[UIFont systemFontOfSize:14.0];
    [rightBtn addTarget:self action:@selector(showFlexRoot) forControlEvents: UIControlEventTouchUpInside];
    aa.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    
}
-(void)showFlexRoot{
    FLEXFileBrowserTableViewController * aa= [[FLEXFileBrowserTableViewController alloc] initWithPath:NSHomeDirectory()];
    [self.navigationController pushViewController:aa animated:YES];
}
#pragma mark  --懒加载
-(NSMutableArray *)dataArray{
    if(!_dataArray){
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
