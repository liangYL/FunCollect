//
//  ViewController.m
//  JxbPlayerControl
//
//  Created by Peter on 15/6/16.
//  Copyright (c) 2015年 Peter. All rights reserved.
//

#import "JxbViewController.h"
#import "JxbPlayer.h"
#import <AVFoundation/AVFoundation.h>
@interface JxbViewController ()
@property(nonatomic,retain)UIScrollView *src;
@end

@implementation JxbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //系统所有音乐
    NSString *path = @"/Users/mingthink/Music/iTunes/iTunes Media/Music";
    NSFileManager *fiel = [NSFileManager defaultManager];
    NSArray *arr = [fiel subpathsAtPath:path];
    for(NSString *str in arr) {
        if([str hasSuffix:@".mp3"]){
            NSLog(@"音乐路径:%@",str);
        }
    }
    
    NSMutableArray *photoPaths = [[NSMutableArray alloc]init];
    NSString *path1 = [[NSBundle mainBundle] bundlePath];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *fileNames = [fm contentsOfDirectoryAtPath:path1 error:nil];
    for (NSString *fileName in fileNames ) {
        if ([fileName hasSuffix:@"MP3"] || [fileName hasSuffix:@"mp3"]) {
            NSString *photoPath = [path stringByAppendingPathComponent:fileName];
            [photoPaths addObject:photoPath];
        }
    }
    NSLog(@"路径=%@",photoPaths);
    
    
    
    JxbPlayer* jxb = [[JxbPlayer alloc] initWithMainColor:[UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000] frame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 100)];
    //jxb.itemUrl = @"http://stream.51voa.com/201506/se-health-south-korea-mers-15jun15.mp3";
    //jxb.itemUrl =@"http://tingge.5nd.com/20060919//2014/2014-11-29/64998/1.Mp3";
    //jxb.itemUrl = [[NSBundle mainBundle] pathForResource:@"喜欢你" ofType:@"mp3"];;
    jxb.itemUrl = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"Mp3"];;
    [self.view addSubview:jxb];
    NSLog(@"%@",NSHomeDirectory());
    
    
    NSString *songsDirectory=NSHomeDirectory();//沙盒地址
    NSBundle *songBundle=[NSBundle bundleWithPath:songsDirectory];
    NSString *bundlePath=[songBundle resourcePath];
    
    NSArray *arrMp3=[NSBundle pathsForResourcesOfType:@"mp3" inDirectory:bundlePath];
    for (NSString *filePath in arrMp3) {
        NSLog(@"--%@",filePath);
    }
    
    
    
    
    self.src = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 200, 300, 300)];
    [self.view addSubview:_src];
    
    
    
    
    [self mDefineUpControl:jxb.itemUrl];
    
    
    
}


-(void)mDefineUpControl:(NSString *)filePath{
    
    //文件管理，取得文件属性
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *dictAtt = [fm attributesOfItemAtPath:filePath error:nil];
    
    
    //取得音频数据
    
    NSURL *fileURL=[NSURL fileURLWithPath:filePath];
    AVURLAsset *mp3Asset=[AVURLAsset URLAssetWithURL:fileURL options:nil];
    
    
    NSString *singer=@"";//歌手
    NSString *song=@"";//歌曲名
    
    UIImage *image=nil;//图片
    
    NSString *albumName=@"";//专辑名
    NSString *fileSize=@"";//文件大小
    NSString *voiceStyle=@"";//音质类型
    NSString *fileStyle=@"";//文件类型
    NSString *creatDate=@"";//创建日期
    NSString *savePath=@""; //存储路径
    
    for (NSString *format in [mp3Asset availableMetadataFormats]) {
        for (AVMetadataItem *metadataItem in [mp3Asset metadataForFormat:format]) {
            
            if([metadataItem.commonKey isEqualToString:@"title"]){
                song = (NSString *)metadataItem.value;//歌曲名
                
            }else if ([metadataItem.commonKey isEqualToString:@"artist"]){
                singer = (NSString *)metadataItem.value;//歌手
            }
            //            专辑名称
            else if ([metadataItem.commonKey isEqualToString:@"albumName"])
            {
                albumName = (NSString *)metadataItem.value;
            }else if ([metadataItem.commonKey isEqualToString:@"artwork"]) {
                //NSDictionary *dict=(NSDictionary *)metadataItem.value;
                //NSData *data=[dict objectForKey:@"data"];
                
                NSData *data = (NSData *)metadataItem.value;
                image=[UIImage imageWithData:data];//图片
                if (image) {
                    UIImageView * img = [[UIImageView alloc] initWithImage:image];
                    img.frame = CGRectMake(_src.frame.size.width-45, 5,40, 40);
                    [_src addSubview:img];
                }
                
                
            }
            
        }
    }
    savePath = filePath;
    float tempFlo = [[dictAtt objectForKey:@"NSFileSize"] floatValue]/(1024*1024);
    fileSize = [NSString stringWithFormat:@"%.2fMB",[[dictAtt objectForKey:@"NSFileSize"] floatValue]/(1024*1024)];
    NSString *tempStrr  = [NSString stringWithFormat:@"%@", [dictAtt objectForKey:@"NSFileCreationDate"]] ;
    if ([tempStrr isEqualToString:@"(null)"]) {
        
    }else{
        creatDate = [tempStrr substringToIndex:19];

    }
    
    fileStyle = [filePath substringFromIndex:[filePath length]-3];
    if(tempFlo <= 2){
        voiceStyle = @"普通";
    }else if(tempFlo > 2 && tempFlo <= 5){
        voiceStyle = @"良好";
    }else if(tempFlo > 5 && tempFlo < 10){
        voiceStyle = @"标准";
    }else if(tempFlo > 10){
        voiceStyle = @"高清";
    }
    
    
    NSArray *tempArr = [[NSArray alloc] initWithObjects:@"歌手:",@"歌曲名称:",@"专辑名称:",@"文件大小:",@"音质类型:",@"文件格式:",@"创建日期:",@"保存路径:", nil];
    NSArray *tempArrInfo = [[NSArray alloc] initWithObjects:singer,song,albumName,fileSize,voiceStyle,fileStyle,creatDate,savePath, nil];

    
    for(int i = 0;i < [tempArr count]; i ++){
        NSString *strTitle = [tempArr objectAtIndex:i];
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 5+i*30, 16*[strTitle length], 25)];
        [titleLab setText:strTitle];
        [titleLab setTextColor:[UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000]];
        [titleLab setFont:[UIFont systemFontOfSize:16]];
        [_src addSubview:titleLab];
        
        NSString *strInfo = [tempArrInfo objectAtIndex:i];
        UILabel *infoLab = [[UILabel alloc] initWithFrame:CGRectMake(titleLab.frame.origin.x+titleLab.bounds.size.width+5, 5+i*30, self.view.bounds.size.width-(titleLab.frame.origin.x+titleLab.bounds.size.width+5)-5, 25)];
        [infoLab setText:strInfo];
        [infoLab setTextColor:[UIColor grayColor]];
        [infoLab setFont:[UIFont systemFontOfSize:16]];
        [_src addSubview:infoLab];
        
        if(i == [tempArr count]-1){
            [infoLab setFrame:CGRectMake(titleLab.frame.origin.x+titleLab.bounds.size.width+5, 5+i*30, self.view.bounds.size.width-(titleLab.frame.origin.x+titleLab.bounds.size.width+5)-5, 30*4)];
            [infoLab setLineBreakMode:NSLineBreakByWordWrapping];
            [infoLab setFont:[UIFont systemFontOfSize:12]];
            [infoLab setNumberOfLines:0];
        }
        
        [_src setContentSize:CGSizeMake(self.view.bounds.size.width, i*45)];
        
    }
    
    
    
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
