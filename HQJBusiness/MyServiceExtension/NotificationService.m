//
//  NotificationService.m
//  MyServiceExtension
//
//  Created by 姚 on 2019/5/22.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "NotificationService.h"

@import AVFoundation ;
@import MediaPlayer ;
@interface NotificationService ()<AVAudioPlayerDelegate>{
    CGFloat userVolume ;
    int audioIndex ;
    NSMutableArray *audioFiles ;
}
@property(nonatomic, strong) AVAudioPlayer *audioPlayer ;
@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
//    NSDictionary *userInfo = @{@"aps":@{@"playaudio":@"1",@"amount":@"5000000"}};
    [self playPushInfo] ;
    self.contentHandler(self.bestAttemptContent);
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

- (void) playPushInfo {
    
    //step1:
//    NSDictionary *extras =  [userInfo objectForKey:@"aps"] ;
    
    //step2:处理并播放语音
//    BOOL playaudio =  [[extras objectForKey:@"playaudio"] boolValue] ;
//    if(playaudio) {
//        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            NSString *amount = [extras objectForKey:@"amount"] ;
//            amount = [NSString stringWithFormat:@"%.2f", (amount.doubleValue)] ;
//            [self playMoneyReceived:amount] ;
//        });
//    }
    NSString *amount = @"200.34";
    amount = [NSString stringWithFormat:@"%.2f", (amount.doubleValue)] ;
    [self playMoneyReceived:amount] ;
}


- (void) playMoneyReceived:(NSString *)moneyAmount{
    // 将金额转换为对应的文字
    NSString* string = [self digitUppercase:moneyAmount] ;
    
    // 分解成mp3数组
    audioFiles = [[NSMutableArray alloc]init] ;
    
    //积分还是现金
    //    if(){
    //
    //    }
    [audioFiles addObject:@"wwm_cash_pre.mp3"] ;
    
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
    
    audioIndex = 0 ;
    [self activePlayback] ;
    [self setHighVolume] ;
    [self playAudioFiles] ;
}



// 设置高音量
- (void) setHighVolume {
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    UISlider *volumeViewSlider = nil;
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            volumeViewSlider = (UISlider*)view;
            break;
        }
    }
    
    // 获取系统原来的音量，用于还原
    userVolume = volumeViewSlider.value;
    
    static float volume = 0.2f ;
    
    // 留点余地，设置0.9吧， 值在0.0～1.0之间
    if(userVolume < volume) {
        // 改变系统音量
        [volumeViewSlider setValue:volume animated:NO];
        // 发一个事件使之生效
        [volumeViewSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

// 设置回正常音量
- (void) setNormalVolume {
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    UISlider* volumeViewSlider = nil;
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            volumeViewSlider = (UISlider*)view;
            break;
        }
    }
    if(volumeViewSlider.value !=userVolume) {
        [volumeViewSlider setValue:userVolume animated:NO];
        [volumeViewSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}




// 播放声音文件
- (void) playAudioFiles {
    // 1.获取要播放音频文件的URL
    NSString *fileName = [audioFiles objectAtIndex:audioIndex] ;
    NSString *path = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath], fileName] ;
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    
    // 2.创建 AVAudioPlayer 对象
    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileURL error:nil];
    // 4.设置循环播放
    self.audioPlayer.numberOfLoops = 0 ;
    self.audioPlayer.delegate = self;
    // 5.开始播放
    [self.audioPlayer prepareToPlay] ;
    [self.audioPlayer play];
}

// 播放完成回调
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    audioIndex += 1 ;
    if(audioIndex < audioFiles.count) {
        [self performSelectorOnMainThread:@selector(playAudioFiles) withObject:nil waitUntilDone:NO] ;
    }
    else {
        [self setNormalVolume] ;
        [self disactivePlayback] ;
    }
}

- (void) activePlayback {
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:NULL];
    [[AVAudioSession sharedInstance] setActive:YES error:NULL];
}

- (void)disactivePlayback {
    [[AVAudioSession sharedInstance] setActive:NO error:NULL];
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
    if([foot isEqualToString:@"00"]) {
        prefix = [prefix stringByAppendingString:@"元"] ;
    }
    else {
        prefix = [prefix stringByAppendingString:[NSString stringWithFormat:@"点%@元", foot]] ;
    }
    
    //
    if([prefix hasPrefix:@"1十"]) {
        prefix = [prefix stringByReplacingOccurrencesOfString:@"1十" withString:@"十"] ;
    }
    
    return prefix ;
}


@end
