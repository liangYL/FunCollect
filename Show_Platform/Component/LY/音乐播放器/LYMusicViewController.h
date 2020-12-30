//
//  LYMusicViewController.h
//  Show_Platform
//
//  Created by liang on 15/6/25.
//  Copyright (c) 2015年 liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface LYMusicViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,AVAudioPlayerDelegate>
{
    AVAudioPlayer *_player;//播放器
    NSTimer *Timer;//计时器
    NSMutableArray *MusicListArray;//歌曲名称数组
    UITableView *MusicNameListTableView;//歌曲名称列表
   
    IBOutlet UILabel *MusicNameLabel;//歌曲名称
    IBOutlet UILabel *showMusicNumber;//当前位置/总数
    IBOutlet UILabel *currTime;//当前播放时间
    IBOutlet UILabel *DurTime;//总时间
    IBOutlet UISlider *TimeSlider;//进度条
    IBOutlet UIButton *playButton;//播放按钮
    
    IBOutlet UIButton *backBtn;
    
    IBOutlet UIButton *nextBtn;
    
    //歌词列表
    IBOutlet UILabel *lrcLabel;
    IBOutlet UIImageView *zhjiView;
    IBOutlet UIView *vie;//歌曲专辑图片
    IBOutlet UIButton *playMode;//播放模式
}

@property(nonatomic,retain) NSArray *lrcData;//歌词数据;



- (IBAction)ShowMusicList:(UIButton *)sender;//
- (IBAction)MusicTimeSlider:(UISlider *)sender;//
- (IBAction)back:(UIButton *)sender;//
- (IBAction)play:(UIButton *)sender;//
- (IBAction)stop:(UIButton *)sender;//
- (IBAction)next:(UIButton *)sender;//
- (IBAction)Volume:(UISlider *)sender;//
- (IBAction)OFF:(id)sender;//
- (IBAction)ChangeMode:(UIButton *)sender;
@end
