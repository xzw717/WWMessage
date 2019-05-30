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
    int audioIndex ;
    NSArray *audioFiles ;
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
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"];
    NSString *collectMoney =  [userDefaults objectForKey:@"CollectMoney"];
    NSString *newOrder =  [userDefaults objectForKey:@"newOrder"];
//    NSLog(@"collectMoney = %@ newOrder = %@",collectMoney,newOrder);
    
    if ([collectMoney isEqualToString:@"开"]&&(itype == 1||itype == 2)) {
        NSString *amount = [NSString stringWithFormat:@"%.2f", [[userInfo objectForKey:@"amount"] doubleValue]] ;
        audioFiles =  [self playMoneyReceived:amount];
    }
    if ([newOrder isEqualToString:@"开"] && itype == 3) {
        audioFiles = @[@"wwm_default"];
    }
    if (audioFiles.count>0) {
        audioIndex = 0 ;
        [self activePlayback] ;
        [self playAudioFiles] ;
    }
}

// 播放声音文件
- (void) playAudioFiles {
    // 1.获取要播放音频文件的URL
    NSString *fileName = [audioFiles objectAtIndex:audioIndex] ;
    NSString *path = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath], fileName] ;
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    
    // 2.创建 AVAudioPlayer 对象
    self.myPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileURL error:nil];
    // 4.设置循环播放
    self.myPlayer.numberOfLoops = 0 ;
    self.myPlayer.delegate = self;
    // 5.开始播放
    [self.myPlayer prepareToPlay] ;
    [self.myPlayer play];
}

// 播放完成回调
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    audioIndex += 1 ;
    if(audioIndex < audioFiles.count) {
        [self performSelectorOnMainThread:@selector(playAudioFiles) withObject:nil waitUntilDone:NO] ;
    }
    else {
        [self disactivePlayback] ;
        [self performSelectorOnMainThread:@selector(playCompleted) withObject:nil waitUntilDone:NO] ;
    }
}

// 播放完成
- (void) playCompleted {
    if(self.aVAudioPlayerFinshBlock) {
        self.aVAudioPlayerFinshBlock() ;
    }
}

- (void) activePlayback {
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:NULL];
    [[AVAudioSession sharedInstance] setActive:YES error:NULL];
}

- (void)disactivePlayback {
    [[AVAudioSession sharedInstance] setActive:NO error:NULL];
}

- (NSArray *) playMoneyReceived:(NSString *)moneyAmount{
    // 语音文件数组
    NSMutableArray *audioFiles = [[NSMutableArray alloc]init] ;
    if (itype == 2) {
        [audioFiles addObject:@"wwm_cash_pre.mp3"];
    }else if (itype == 1){
        [audioFiles addObject:@"wwm_score_pre.mp3"];
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
        [audioFiles addObject:[NSString stringWithFormat:@"wwm_%@.mp3", str]] ;
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
