//
//  ZGAudioManager.m
//  PushAudioDemo
//
//  Created by Winter on 2018/5/31.
//  Copyright © 2018年 www.bestpay.com.cn. All rights reserved.
//

#import "ZGAudioManager.h"

@import AVFoundation ;
@import MediaPlayer ;


@interface ZGAudioManager() <AVAudioPlayerDelegate>{
    NSInteger itype;
}

//声音文件的播放器
@property (nonatomic, strong)AVAudioPlayer *myPlayer;
//声音文件的路径
@property (nonatomic, strong) NSString *filePath;
// 语音合成完毕之后，使用 AVAudioPlayer 播放
@property (nonatomic, copy)PlayVoiceBlock aVAudioPlayerFinshBlock;
@end

@implementation ZGAudioManager

+ (instancetype)sharedPlayer {
    static ZGAudioManager *_instance = nil ;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[ZGAudioManager alloc] init] ;
    }) ;
    return _instance ;
}

- (void)playPushInfo:(NSDictionary *)userInfo completed:(PlayVoiceBlock )completed
{
    if (completed) {
        self.aVAudioPlayerFinshBlock = completed;
    }
    
    itype = [[userInfo objectForKey:@"itype"] integerValue];

    NSLog(@"userInfo: %@", userInfo);
    NSLog(@"collectMoney = %@ newOrder = %@",CollectMoney,NewOrder);
    NSArray *fileNameArray;
    if ([CollectMoney isEqualToString:@"开"]&&(itype == 1||itype == 2)) {
        NSString *amount = [NSString stringWithFormat:@"%.2f", [[userInfo objectForKey:@"amount"] doubleValue]] ;
        fileNameArray =  [self playMoneyReceived:amount];
    }
    if ([NewOrder isEqualToString:@"开"] && itype == 0) {
        fileNameArray = @[@"wwm_default"];
    }
    if (fileNameArray.count>0) {
        /************************合成音频并播放*****************************/
        
        AVMutableComposition *composition = [AVMutableComposition composition];
        
        CMTime allTime = kCMTimeZero;
        
        for (NSInteger i = 0; i < fileNameArray.count; i++) {
            NSString *auidoPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",fileNameArray[i]] ofType:@"m4a"];
            AVURLAsset *audioAsset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:auidoPath]];
            // 音频轨道
            AVMutableCompositionTrack *audioTrack = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:0];
            // 音频素材轨道
            AVAssetTrack *audioAssetTrack = [[audioAsset tracksWithMediaType:AVMediaTypeAudio] firstObject];
            // 音频合并 - 插入音轨文件
            [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset.duration) ofTrack:audioAssetTrack atTime:allTime error:nil];
            // 更新当前的位置
            allTime = CMTimeAdd(allTime, audioAsset.duration);
            
        }
        
        // 合并后的文件导出 - `presetName`要和之后的`session.outputFileType`相对应。
        AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:composition presetName:AVAssetExportPresetAppleM4A];
        NSString *outPutFilePath = [[self.filePath stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"xindong.m4a"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:outPutFilePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:outPutFilePath error:nil];
        }
        
        // 查看当前session支持的fileType类型
        NSLog(@"---%@",[session supportedFileTypes]);
        session.outputURL = [NSURL fileURLWithPath:outPutFilePath];
        session.outputFileType = AVFileTypeAppleM4A; //与上述的`present`相对应
        session.shouldOptimizeForNetworkUse = YES;   //优化网络
        
        [session exportAsynchronouslyWithCompletionHandler:^{
            NSLog(@"----%ld", session.status);
            if (session.status == AVAssetExportSessionStatusCompleted) {
                NSLog(@"合并成功----%@", outPutFilePath);
                
                NSURL *url = [NSURL fileURLWithPath:outPutFilePath];
                
                self.myPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
                
                self.myPlayer.delegate = self;
                [self.myPlayer play];
                
                
            } else {
                
                // 其他情况, 具体请看这里`AVAssetExportSessionStatus`.
                // 播放失败
                self.aVAudioPlayerFinshBlock();
            }
        }];
        
        /************************合成音频并播放*****************************/
    }
}
#pragma mark- AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self disactivePlayback] ;
    if (self.aVAudioPlayerFinshBlock) {
        self.aVAudioPlayerFinshBlock();
    }
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer*)player error:(NSError *)error{
    //解码错误执行的动作
}
- (void)audioPlayerBeginInteruption:(AVAudioPlayer*)player{
    //处理中断的代码
}
- (void)audioPlayerEndInteruption:(AVAudioPlayer*)player{
    //处理中断结束的代码
}
- (void) activePlayback {
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:NULL];
    [[AVAudioSession sharedInstance] setActive:YES error:NULL];
}

- (void)disactivePlayback {
    [[AVAudioSession sharedInstance] setActive:NO error:NULL];
}


- (NSString *)filePath {
    if (!_filePath) {
        _filePath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
        NSString *folderName = [_filePath stringByAppendingPathComponent:@"MergeAudio"];
        BOOL isCreateSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:folderName withIntermediateDirectories:YES attributes:nil error:nil];
        if (isCreateSuccess) _filePath = [folderName stringByAppendingPathComponent:@"xindong.m4a"];
    }
    return _filePath;
}
- (NSArray *) playMoneyReceived:(NSString *)moneyAmount{
    // 语音文件数组
    NSMutableArray *audioFiles = [[NSMutableArray alloc]init] ;
    if (itype == 1) {
        [audioFiles addObject:@"wwm_cash_pre"];
    }else if (itype == 2){
        [audioFiles addObject:@"wwm_score_pre"];
    }
    // 将金额转换为对应的文字
    NSString* string = [self digitUppercase:moneyAmount] ;
    for (int i = 0; i < string.length; i++) {
        NSString * str = [string substringWithRange:NSMakeRange(i, 1)] ;
        
        if([str isEqualToString:@"零"]) {
            str = @"0" ;
        }
        else if([str isEqualToString:@"十"]) {
            str = @"ten" ;
        }
        else if([str isEqualToString:@"百"]) {
            str = @"hundred" ;
        }
        else if([str isEqualToString:@"千"]) {
            str = @"thousand" ;
        }
        else if([str isEqualToString:@"万"]) {
            str = @"ten_thousand" ;
        }
        else if([str isEqualToString:@"点"]) {
            str = @"dot" ;
        }
        else if([str isEqualToString:@"元"]) {
            str = @"yuan" ;
        }
        [audioFiles addObject:[NSString stringWithFormat:@"wwm_%@", str]] ;
    }
    return audioFiles;
}
-(NSString *)digitUppercase:(NSString *)numstr {
    NSArray *numberchar = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    NSArray *inunitchar = @[@"",@"十",@"百",@"千"];
    NSArray *unitname   = @[@"",@"万",@"亿"];
    
    NSString *valstr =[NSString stringWithFormat:@"%.2f",numstr.doubleValue] ;
    NSString *prefix = @"" ;
    
    // 将金额分为整数部分和小数部分
    NSString *head = [valstr substringToIndex:valstr.length - 2 - 1] ;
    NSString *foot = [valstr substringFromIndex:valstr.length - 2] ;
    if (head.length>8) {
        return nil ;//只支持到千万
    }
    
    // 处理整数部分
    if([head isEqualToString:@"0"]) {
        prefix = @"0" ;
    }
    else {
        NSMutableArray *ch = [[NSMutableArray alloc]init] ;
        for (int i = 0; i < head.length; i++) {
            NSString * str = [NSString stringWithFormat:@"%x",[head characterAtIndex:i]-'0'] ;
            [ch addObject:str] ;
        }
        
        int zeronum = 0 ;
        for (int i = 0; i < ch.count; i++) {
            NSInteger index = (ch.count-1 - i)%4 ;       //取段内位置
            NSInteger indexloc = (ch.count-1 - i)/4 ;    //取段位置
            
            if ([[ch objectAtIndex:i]isEqualToString:@"0"]) {
                zeronum ++ ;
            }
            else {
                if (zeronum != 0) {
                    if (index != 3) {
                        prefix=[prefix stringByAppendingString:@"零"];
                    }
                    zeronum = 0;
                }
                prefix = [prefix stringByAppendingString:[numberchar objectAtIndex:[[ch objectAtIndex:i]intValue]]] ;
                prefix = [prefix stringByAppendingString:[inunitchar objectAtIndex:index]] ;
            }
            if (index == 0 && zeronum < 4) {
                prefix = [prefix stringByAppendingString:[unitname objectAtIndex:indexloc]] ;
            }
        }
    }
    
    
    //处理小数部分
    if([foot isEqualToString:@"00"]){
        prefix = [prefix stringByAppendingString:@"元"] ;
    }else {
        prefix = [prefix stringByAppendingString:[NSString stringWithFormat:@"点%@元",foot]];
    }

    if([prefix hasPrefix:@"1十"]) {
        prefix = [prefix stringByReplacingOccurrencesOfString:@"1十" withString:@"十"] ;
    }
    
    return prefix ;
}


@end
