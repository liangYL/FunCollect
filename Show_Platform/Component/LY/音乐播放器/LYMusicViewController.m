//
//  ViewController.m
//  MusicPlayerDemo
//
//  Created by mac on 14-1-12.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "LYMusicViewController.h"
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <MediaPlayer/MPMediaItem.h>


@interface LYMusicViewController ()
{
    NSString *singer;//歌手
    NSString *song;//歌曲名
    
    UIImage *image;//图片
    
    NSString *albumName;//专辑名
    NSString *fileSize;//文件大小
    NSString *voiceStyle;//音质类型
    NSString *fileStyle;//文件类型
    NSString *creatDate;//创建日期
    NSString *savePath; //存储路径
    
}
@end

@implementation LYMusicViewController
static int MusicNumber=0;
static int ShowListNumer=0;
static int PlayAndPause=1;
static int TimerValue=0;
static int mode=0;
//获取音频数据
-(void)MusicData
{
    NSFileManager *manager=[NSFileManager defaultManager];
    NSString *home=NSHomeDirectory();
    NSString *string=[[NSString alloc]initWithFormat:@"%@/Documents/Music",home,nil];
    NSLog(@"%@",string);
    NSArray *arr=[[NSArray alloc]init];
    arr=[manager contentsOfDirectoryAtPath:string error:nil];
    MusicListArray=[[NSMutableArray alloc]init];
    if (arr.count==0)
    {
        ;
    }
    else
    {
        for (int a=0; a<arr.count; a++)
        {
            NSString *str1=[[NSString alloc]init];
            str1=[arr objectAtIndex:a];
            if ([[str1 pathExtension]isEqualToString:@"mp3"])
            {
                NSUInteger a=str1.length-4;
                NSRange range={0,a};
                str1=[str1 substringWithRange:range];
                [MusicListArray addObject:str1];
            }
        }
    }
}
//音频文件列表
-(void)ShowList
{
    MusicNameListTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,100, 180, 300)];
    MusicNameListTableView.dataSource=self;
    MusicNameListTableView.delegate=self;
    //    分栏线颜色
    [MusicNameListTableView setSeparatorColor:[UIColor whiteColor]];
    [MusicNameListTableView setBackgroundColor:[UIColor colorWithWhite:0.800 alpha:1.000]];
}
//地址转换为URL
-(NSURL *)musicNamePath
{
    NSURL *url=nil;
    if (MusicNumber<MusicListArray.count)
    {
        NSString *home=NSHomeDirectory();
        NSString *musicPath=[[NSString alloc]initWithFormat:@"%@/Documents/Music/%@.mp3",home,[MusicListArray objectAtIndex:MusicNumber],nil];
        url=[[NSURL alloc]initFileURLWithPath:musicPath];
    }
    return url;
}
//初始化播放器
-(void)StartPlayer
{
    if ([self musicNamePath]!=nil)
    {
        Timer=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(process) userInfo:nil repeats:YES];
        TimerValue=0;
        NSError *error=nil;
        
        _player=[[AVAudioPlayer alloc]initWithContentsOfURL:[self musicNamePath] error:&error];
        if (error)
        {
            NSLog(@"%@",[error localizedDescription]);
        }
        [_player prepareToPlay];
        [_player play];
        _player.delegate=self;
        showMusicNumber.text=[NSString stringWithFormat:@"%d/%lu",MusicNumber+1,(unsigned long)MusicListArray.count,nil];
        int MIN=(_player.duration)/60;
        int sc=(int)(_player.duration)%60;
        DurTime.text=[NSString stringWithFormat:@"%02d:%02d",MIN,sc];
        MusicNameLabel.text=[MusicListArray objectAtIndex:MusicNumber];
        [self LrcListData];
        playButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"pause.png"]];
        PlayAndPause=1;
        [self MusicInforMation];
    }
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//视图加载
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg11.jpg"]];
    //图像圆角
    zhjiView.layer.masksToBounds = YES;
    zhjiView.layer.cornerRadius = 105;
    zhjiView.layer.borderWidth = 10;
    zhjiView.layer.borderColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000].CGColor;
    
    //播放模式(随机,单曲,等)
    playMode.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"all.png"]];
    [playMode setTitle:@"all" forState:UIControlStateNormal];
    playMode.tintColor=[UIColor clearColor];
    
    
    
    singer=@"";//歌手
    song=@"";//歌曲名
    image=[UIImage imageNamed:@""];//图片
    albumName=@"";//专辑名
    fileSize=@"";//文件大小
    voiceStyle=@"";//音质类型
    fileStyle=@"";//文件类型
    creatDate=@"";//创建日期
    savePath=@""; //存储路径
    
    //获取歌曲名称集
    [self MusicData];
    
    if (MusicListArray.count==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Mp3文件不存在，请在沙盒中添加Music文件夹及MP3文件后，运行程序" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    else
    {
        [self StartPlayer];
        [self ShowList];
    }
    
    //设置锁屏仍能继续播放
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    //以及设置app支持接受远程控制事件代码。设置app支持接受远程控制事件，
    //其实就是在dock中可以显示应用程序图标，同时点击该图片时，打开app。
    //或者锁屏时，双击home键，屏幕上方出现应用程序播放控制按钮。
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    [self configNowPlayingInfoCenter];
    
}


//歌曲文件列表展示
- (IBAction)ShowMusicList:(UIButton *)sender
{
    if (ShowListNumer==0)
    {
        [self.view addSubview:MusicNameListTableView];
        ShowListNumer=1;
    }
    else
    {
        [MusicNameListTableView removeFromSuperview];
        ShowListNumer=0;
    }
}
//歌曲播放进度
- (IBAction)MusicTimeSlider:(UISlider *)sender
{
    _player.currentTime=(sender.value)*(_player.duration);
    int MIN=(_player.currentTime)/60;
    int sc=(int)(_player.currentTime)%60;
    currTime.text=[NSString stringWithFormat:@"%02d:%02d",MIN,sc];
}
//上一曲
- (IBAction)back:(UIButton *)sender
{
    [Timer invalidate];
    NSLog(@"number=============%d",MusicNumber);
    if (MusicNumber==0)
    {
        MusicNumber=MusicListArray.count-1;
        [self StartPlayer];
        NSLog(@"number=============%d",MusicNumber);
    }
    else
    {
        MusicNumber-=1;
        [self StartPlayer];
    }
    
}
//播放或暂停
- (IBAction)play:(UIButton *)sender
{
    if ([DurTime.text isEqualToString:@""])
    {
        int MIN=(_player.duration)/60;
        int sc=(int)(_player.duration)%60;
        DurTime.text=[NSString stringWithFormat:@"%02d:%02d",MIN,sc];
        
    }
    if (PlayAndPause==0)
    {
        [_player play];
        Timer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(process) userInfo:nil repeats:YES];
        TimerValue=0;
        playButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"pause.png"]];
        PlayAndPause=1;
    }
    else
    {
        [_player pause];
        playButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"play.png"]];
        PlayAndPause=0;
        [Timer invalidate];
        TimerValue=1;
    }
}
//停止
- (IBAction)stop:(UIButton *)sender
{
    NSLog(@"stop======%d",TimerValue);
    if (TimerValue==0)
    {
        [Timer invalidate];
    }
    [_player stop];
    playButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"play.png"]];
    PlayAndPause=0;
    currTime.text=@"00:00";
    DurTime.text=@"";
    TimeSlider.value=0;
    if (_player.currentTime!=0)
    {
        _player.currentTime=0;
    }
}
//下一曲
- (IBAction)next:(UIButton *)sender
{
    if (MusicNumber==MusicListArray.count-1)
    {
        MusicNumber=0;
        [self StartPlayer];
    }
    else
    {
        MusicNumber++;
        [self StartPlayer];
    }
}
//声音调节
- (IBAction)Volume:(UISlider *)sender
{
    _player.volume=sender.value;
}
//关闭程序
- (IBAction)OFF:(id)sender
{
    exit(5);
}
//播放模式
- (IBAction)ChangeMode:(UIButton *)sender
{
    //    NSLog(@"jinglai=%@,%d",sender.currentTitle,mode);
    if ([sender.currentTitle isEqualToString:@"all"])
    {
        [playMode setTitle:@"single" forState:UIControlStateNormal];
        playMode.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"single.png"]];
        mode=1;
    }
    else if ([sender.currentTitle isEqualToString:@"single"])
    {
        [playMode setTitle:@"random" forState:UIControlStateNormal];
        playMode.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"random.png"]];
        mode=2;
    }
    else
    {
        [playMode setTitle:@"all" forState:UIControlStateNormal];
        playMode.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"all.png"]];
        mode=0;
    }
    //    NSLog(@"chuqu===%@,%d",sender.currentTitle,mode);
}


//计时器方法
-(void)process
{
    TimeSlider.value=((_player.currentTime)/(_player.duration));
    int MIN=(_player.currentTime)/60;
    int sc=(int)(_player.currentTime)%60;
    currTime.text=[NSString stringWithFormat:@"%02d:%02d",MIN,sc];
    int aa=(_player.currentTime-MIN*60-sc)*100;
    NSString *stringg=[NSString stringWithFormat:@"[%02d:%02d.%02d]",MIN,sc,aa,nil];
    NSString *str1=[[NSString alloc]init];
    for (int i=0; i<self.lrcData.count; i++)
    {
        str1=[self.lrcData objectAtIndex:i];
        if ([str1 hasPrefix:stringg])
        {
            //            NSLog(@"%@,%d",str1,str1.length);
            if (str1.length>10)
            {
                lrcLabel.text=[str1 substringWithRange:NSMakeRange(10, str1.length-10)];
                lrcLabel.textColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
            }
            else
            {
                lrcLabel.text=@"。。。";
            }
        }
    }
}
//播放结束时执行的动作
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (mode==0)
    {
        if (MusicNumber==MusicListArray.count-1)
        {
            sleep(5);
            exit(0);
        }
        else
        {
            [Timer invalidate];
            MusicNumber++;
            [self StartPlayer];
            NSLog(@"number====%d",MusicNumber);
        }
    }
    else if (mode==1)
    {
        [Timer invalidate];
        [self StartPlayer];
    }
    else
    {
        MusicNumber=rand()%(MusicListArray.count);
        //        NSLog(@"随机%d",MusicNumber);
        [Timer invalidate];
        [self StartPlayer];
    }
    
    
}
//-------------------------音频文件列表--------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation

{
    
    // Return YES for supported orientations
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [MusicListArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [MusicListArray objectAtIndex:row];
    cell.textLabel.textColor=[UIColor blackColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    playButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"pause.png"]];
    PlayAndPause=1;
    NSLog(@"%@,%d",[MusicListArray objectAtIndex:[indexPath row]],[indexPath row]);
    MusicNumber=[indexPath row];
    [self StartPlayer];
    [MusicNameListTableView removeFromSuperview];
    ShowListNumer=0;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    exit(0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-------------------------歌词显示--------------------
-(void)LrcListData
{
    NSString *LrcPath=[[NSString alloc]initWithFormat:@"%@/Documents/Music/%@.lrc",NSHomeDirectory(),[MusicListArray objectAtIndex:MusicNumber],nil];
    NSString *string=[NSString stringWithContentsOfFile:LrcPath encoding:NSUTF8StringEncoding error:nil];
    self.lrcData=[string componentsSeparatedByString:@"\n"];
    if (self.lrcData.count==0)
    {
        NSLog(@"没有歌词");
        lrcLabel.text=@"亲！没得歌词，赶快添加吧!";
    }
    else
    {
        lrcLabel.text=@"";
    }
}

//--------------------------获取歌曲信息--------------------------
//歌曲信息获取
-(void)MusicInforMation
{
    NSString *filepath1=[[NSString alloc]initWithFormat:@"%@/Documents/Music/%@.mp3",NSHomeDirectory(),[MusicListArray objectAtIndex:MusicNumber],nil];
    NSURL *fileUrl=[NSURL fileURLWithPath:filepath1];
    AVURLAsset *mp3Asset=[AVURLAsset URLAssetWithURL:fileUrl options:nil];
    
    for (NSString *format in [mp3Asset availableMetadataFormats])
    {
        //        NSLog(@"format type=%@",format);
        for (AVMetadataItem *metadataItem in [mp3Asset metadataForFormat:format]) {
            if(metadataItem.commonKey)
                NSLog(@"共有多少属性 %@\n",metadataItem.commonKey);
        }
        
        if ([[mp3Asset metadataForFormat:format]indexOfObject:@"artwork"]==NSNotFound)
        {
            zhjiView.image=[UIImage imageNamed:@"touming.png"];
        }
        for (AVMetadataItem *metadataItem in [mp3Asset metadataForFormat:format])
        {
            //            NSLog(@"commonKey = %@",metadataItem.commonKey);
            //artwork这个key对应的value里面存的就是封面缩略图，其它key可以取出其它摘要信息，例如title - 标题
            //            歌曲图片
            if ([metadataItem.commonKey isEqualToString:@"artwork"])
            {
                //NSData *data = [(NSDictionary*)metadataItem.value objectForKey:@"data"];
                NSData * data = (NSData *)metadataItem.value;
                image=[UIImage imageWithData:data];
                zhjiView.image = image;
            }
            /* //            艺术家？神马东东
             if ([metadataItem.commonKey isEqualToString:@"artist"])
             {
             NSLog(@"artist====%@",(NSDictionary *)metadataItem.value);
             }
             //            专辑名称
             if ([metadataItem.commonKey isEqualToString:@"albumName"])
             {
             NSLog(@"albumName====%@",(NSDictionary *)metadataItem.value);
             }
             //            标题
             if ([metadataItem.commonKey isEqualToString:@"title"])
             {
             NSLog(@"title====%@",(NSDictionary *)metadataItem.value);
             }*/
            if([metadataItem.commonKey isEqualToString:@"title"]){
                song = (NSString *)metadataItem.value;//歌曲名
                
            }else if ([metadataItem.commonKey isEqualToString:@"artist"]){
                singer = (NSString *)metadataItem.value;//歌手
            }else if ([metadataItem.commonKey isEqualToString:@"albumName"])
            {
                albumName = (NSString *)metadataItem.value;
            }
            
            
            
            
        }
    }
    
}



//锁屏控件
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}


- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent {
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        
        switch (receivedEvent.subtype) {
                
            case UIEventSubtypeRemoteControlTogglePlayPause:
                [self play:playButton];
                NSLog(@"=======");
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack:
                [self back:backBtn];
                break;
                
            case UIEventSubtypeRemoteControlNextTrack:
                [self next:nextBtn];
                break;
                
            default:
                break;
        }
    }
}


//设置锁屏状态，显示的歌曲信息
-(void)configNowPlayingInfoCenter{
    
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        
        [dict setObject:song forKey:MPMediaItemPropertyTitle];
        
        [dict setObject:singer forKey:MPMediaItemPropertyArtist];
        
        [dict setObject:albumName forKey:MPMediaItemPropertyAlbumTitle];
        //这条有问题
        [dict setObject:currTime.text  forKey:MPMediaItemPropertyPlaybackDuration];
        //[dict setObject:currTime forKey:MPMediaItemPropertyPlaybackDuration];
        [dict setObject:lrcLabel.text  forKey:MPMediaItemPropertyLyrics];
                
        if(image){
            MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:image];
            [dict setObject:artwork forKey:MPMediaItemPropertyArtwork];
        }
        
        
        
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
        
    }
}



-(NSArray *)lrcData{
    if (!_lrcData) {
        self.lrcData = [NSArray array];
    }
    return _lrcData;
}














@end
