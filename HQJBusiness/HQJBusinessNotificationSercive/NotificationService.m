//
//  NotificationService.m
//  MyServiceExtension
//
//  Created by 姚 on 2019/5/22.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "NotificationService.h"

#import "ZGAudioManager.h"
#import "JWBluetoothManage.h"

@import AVFoundation ;
@import MediaPlayer ;

typedef void(^PlayVoiceBlock)(void);

@interface NotificationService ()<AVAudioPlayerDelegate>{
<<<<<<< HEAD
    NSInteger itype;
=======
    JWBluetoothManage * manage;
>>>>>>> 0eaff95c4064b5c5a92aab058f78fda9027b479c
}
//声音文件的播放器
@property (nonatomic, strong)AVAudioPlayer *myPlayer;
//声音文件的路径
@property (nonatomic, strong) NSString *filePath;
// 语音合成完毕之后，使用 AVAudioPlayer 播放
@property (nonatomic, copy)PlayVoiceBlock aVAudioPlayerFinshBlock;

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
<<<<<<< HEAD
    NSDictionary * userInfo = self.bestAttemptContent.userInfo;
    NSLog(@"userInfo: %@", userInfo);
    itype = [[userInfo objectForKey:@"itype"] integerValue];
    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"];
    BOOL collectMoney =  [[userDefaults objectForKey:@"CollectMoney"] boolValue];
    BOOL newOrder =  [[userDefaults objectForKey:@"newOrder"]boolValue];
    NSLog(@"collectMoney = %d newOrder = %d",collectMoney,newOrder);
    if ((collectMoney&&(itype == 1||itype == 2))||(newOrder && itype == 0)) {
        __weak __typeof(self)weakSelf = self;
        
        [self hechengVoiceAVAudioPlayerWithFinshBlock:^{
            weakSelf.contentHandler(weakSelf.bestAttemptContent);
        }];
    }
=======

    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"];

    NSLog(@"打印的用户id是 %@", [userDefaults objectForKey:@"AutomaticallyPrintOrders"]);

  
    // Modify the notification content here...
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    __weak __typeof(self)weakSelf = self;
    /*******************************推荐用法*******************************************/
    
    // 语音合成，使用AVAudioPlayer播放,成功
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"CollectMoney"]) {
//
//    }
    [self hechengVoiceAVAudioPlayerWithFinshBlock:^{
        weakSelf.contentHandler(weakSelf.bestAttemptContent);
    }];
    
    [self dayin];
>>>>>>> 0eaff95c4064b5c5a92aab058f78fda9027b479c
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}
#pragma mark- 合成音频使用 AVAudioPlayer 播放
- (void)hechengVoiceAVAudioPlayerWithFinshBlock:(PlayVoiceBlock )block
{
    if (block) {
        self.aVAudioPlayerFinshBlock = block;
    }
    NSDictionary * userInfo = self.bestAttemptContent.userInfo;
    itype = [[userInfo objectForKey:@"itype"] integerValue];
    NSArray *fileNameArray;
    if (itype == 1||itype == 2) {
        NSString *amount = [NSString stringWithFormat:@"%.2f", [[userInfo objectForKey:@"amount"] doubleValue]] ;
        fileNameArray =  [self playMoneyReceived:amount];
    }
    if (itype == 0) {
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

- (void)dayin {
    manage = [JWBluetoothManage sharedInstance];
    //    WeakSelf
    [manage beginScanPerpheralSuccess:^(NSArray<CBPeripheral *> *peripherals, NSArray<NSNumber *> *rssis) {
        //        weakSelf.dataSource = [NSMutableArray arrayWithArray:peripherals];
        //        weakSelf.rssisArray = [NSMutableArray arrayWithArray:rssis];
        //        [weakSelf.tableView reloadData];
    } failure:^(CBManagerState status) {
//        [ProgressShow alertView:self.view Message:[ProgressShow getBluetoothErrorInfo:status] cb:nil];
    }];
    manage.disConnectBlock = ^(CBPeripheral *perpheral, NSError *error) {
        NSLog(@"设备已经断开连接！");
        //        weakSelf.title = @"蓝牙列表";
    };
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"Printer"];
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePatch];
    CBPeripheral *perpherals;
    if (dataDictionary)
    {
       perpherals = [dataDictionary objectForKey:@"peripheral"];
    }
    [manage connectPeripheral:perpherals completion:^(CBPeripheral *perpheral, NSError *error) {
        if (!error) {
         
        }else{
        }
    }];
    
    
    [manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
//        @strongify(self);
        if (!error) {
//            [ProgressShow alertView:self.view Message:@"打印机连接成功！" cb:nil];
            //            weakSelf.title = [NSString stringWithFormat:@"已连接-%@",perpheral.name];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self printe];
            });
            dispatch_async(dispatch_get_main_queue(), ^{
                //                [weakSelf.tableView reloadData];
            });
        }else{
//            [ProgressShow alertView:self.view Message:error.domain cb:nil];
        }
    }];
}
- (void)printe{
    if (manage.stage != JWScanStageCharacteristics) {
//        [SVProgressHUD showWithStatus:@"打印机正在准备中..."];
        return;
    }
    JWPrinter *printer = [[JWPrinter alloc] init];
    NSString *str1 = @"物物地图";
    NSString *str2 = @"Wuwu Map";
    NSString *str3 = @"订单详情";
    [printer appendText:str1 alignment:HLTextAlignmentCenter];
    [printer appendText:str2 alignment:HLTextAlignmentCenter];
    [printer appendText:str3 alignment:HLTextAlignmentCenter];
    [printer appendSeperatorLine];
    
    [printer appendText:@"用户信息" alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    [printer appendText:@"130******890" alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    [printer appendSeperatorLine];
    
    [printer appendText:@"订单详情" alignment:HLTextAlignmentLeft];
    [printer appendLeftText:@"假装我是一个方便面" middleText:@"x109" rightText:@"99999.99" isTitle:NO];
    //    [printer appendNewLine];
    
    [printer appendLeftText:@"飞流直下三千尺，疑似银河落九天999999999999999999999999999999999999" middleText:@"x109" rightText:@"889.99" isTitle:NO];
    //    [printer appendNewLine];
    
    [printer appendLeftText:@"上海许氏专用订单一条" middleText:@"x109" rightText:@"9.09" isTitle:NO];
    //    [printer appendNewLine];
    
    [printer appendLeftText:@"许某人爱喝的可口可乐" middleText:@"x109" rightText:@"9999.99" isTitle:NO];
    
    [printer appendSeperatorLine];
    
    [printer appendTitle:@"总计商品数" value:@"2"];
    [printer appendTitle:@"金    额" value:@"￥1000"];
    
    [printer appendSeperatorLine];
    [printer appendTitle:@"订单编号" value:@"MS1234567890"];
    [printer appendTitle:@"下单时间" value:@"2017-06-14"];
    [printer appendFooter:@"感谢您选择【物物地图】，欢迎您再次光临!"];
    [printer appendNewLine];
    [printer appendNewLine];
    [printer appendNewLine];
    NSData *mainData = [printer getFinalData];
    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        if (completion) {
            NSLog(@"打印成功");
        }else{
            NSLog(@"写入错误---:%@",error);
        }
    }];
}


@end
