//
//  NotificationService.m
//  MyServiceExtension
//
//  Created by 姚 on 2019/5/22.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "NotificationService.h"

#import "ZGAudioManager.h"
#import "JWBluetoothPrinte/JWBluetoothManage.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@import AVFoundation ;
@import MediaPlayer ;

typedef void(^PlayVoiceBlock)(void);

@interface NotificationService ()<AVAudioPlayerDelegate>{
   
    NSInteger itype;
    JWBluetoothManage * manage;
    
    /**************** 打印内容*************/
    NSMutableArray *goodsArray;
    NSString *orderid;
    NSString *mobile;
    NSString *totalmoney;
    NSString *ordertime;
    NSString *totalquantity;
    /**************** 打印内容*************/

    
    
    
}
@property (nonatomic,assign)NSInteger time;
@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    NSDictionary * userInfo = self.bestAttemptContent.userInfo;
    NSLog(@"userInfo: %@", userInfo);
    itype = [[userInfo objectForKey:@"itype"] integerValue];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"];
    NSString *automaticallyPrintOrders = [userDefaults objectForKey:@"AutomaticallyPrintOrders"];

//    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@", self.bestAttemptContent.title];
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 12.1) {
        NSString *collectMoney =  [userDefaults objectForKey:@"CollectMoney"];
        NSString *newOrder =  [userDefaults objectForKey:@"newOrder"];
        NSLog(@"collectMoney = %@ newOrder = %@",collectMoney,newOrder);
        if (([collectMoney isEqualToString:@"开"]&&(itype == 1||itype == 2))||([newOrder isEqualToString:@"开"] && itype == 3)) {
            [self pushNotification];
        }
        self.contentHandler(self.bestAttemptContent);
    }else{
        [[ZGAudioManager sharedPlayer] playPushInfo:userInfo completed:^{
            self.contentHandler(self.bestAttemptContent);
        }];
    }
    
//    NSLog(@"打印的用户id是 %@", [userDefaults objectForKey:@"AutomaticallyPrintOrders"]);
    // Modify the notification content here...
    /*******************************推荐用法*******************************************/
    [self pushJson:userInfo];
    if ([automaticallyPrintOrders isEqualToString:@"开"] && itype == 3) {
        [self dayin];

    }
}

- (void)pushJson:(NSDictionary *)dict {
    if (dict [@"list"]) {
        goodsArray = dict [@"list"][@"list"];
 
    }
    orderid = dict[@"orderid"];;
    mobile = dict[@"mobile"];
    totalmoney = dict[@"totalmoney"];
    ordertime = dict[@"ordertime"];
    totalquantity = dict[@"totalquantity"];
}

- (void)pushNotification{
    NSDictionary * userInfo = self.bestAttemptContent.userInfo;
    NSArray *fileNameArray;
    if (itype == 1||itype == 2) {
        NSString *amount = [NSString stringWithFormat:@"%.2f", [[userInfo objectForKey:@"amount"] doubleValue]] ;
        fileNameArray =  [self playMoneyReceived:amount];
    }
    if (itype == 3) {
        fileNameArray = @[@"wwm_default"];
    }
    

    for (int i = 0; i <fileNameArray.count; i ++) {
        NSString *string = fileNameArray[i];
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        __weak __typeof(self)weakSelf = self;
        [self registerNotificationWithString:string completeHandler:^{
            if (i == 0) {
                weakSelf.time = 2.2;
            }else{
                weakSelf.time = 1.0;
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(weakSelf.time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                dispatch_semaphore_signal(semaphore);
            });
        }];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }

    self.contentHandler(self.bestAttemptContent);
}

- (void)registerNotificationWithString:(NSString *)string completeHandler:(dispatch_block_t)complete {
    
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
        if (granted) {
            
            UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
            content.title = @"";
            content.subtitle = @"";
            content.body = @"";
            content.sound = [UNNotificationSound soundNamed:[NSString stringWithFormat:@"%@.mp3",string]];
            
            content.categoryIdentifier = [NSString stringWithFormat:@"categoryIndentifier%@",string];
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.01 repeats:NO];
            
            UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:[NSString stringWithFormat:@"categoryIndentifier%@",string] content:content trigger:trigger];
            
            [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
                
                if (error == nil) {
                    
                    if (complete) {
                        complete();
                    }
                }
            }];
        }
    }];
}
- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

- (NSArray *) playMoneyReceived:(NSString *)moneyAmount{
    // 语音文件数组
    NSMutableArray *audioFiles = [[NSMutableArray alloc]init] ;
    // 将金额转换为对应的文字
    if (itype == 2) {
        [audioFiles addObject:@"wwm_cash_pre"];
    }else if (itype == 1){
        [audioFiles addObject:@"wwm_score_pre"];
    }
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
    
 
//    CBPeripheral *perpherals = [userDefaults objectForKey:@"printer"];

    
    
    [[JWBluetoothManage sharedInstance] autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
//        @strongify(self);
        if (!error) {
//            [ProgressShow alertView:self.view Message:@"打印机连接成功！" cb:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self printe];
            });
        }else{
//            [ProgressShow alertView:self.view Message:error.domain cb:nil];
        }
    }];
}
- (void)printe{
    if ([JWBluetoothManage sharedInstance].stage != JWScanStageCharacteristics) {
//        [SVProgressHUD showWithStatus:@"打印机正在准备中..."];
        return;
    }
    JWPrinter *printer = [[JWPrinter alloc] init];
    NSString *str1 = @"物物地图";
    NSString *str2 = @"Wuwu Map";
    NSString *str3 = @"订单详情";
    [printer appendText:str1 alignment:HLTextAlignmentCenter];
    [printer appendText:str2 alignment:HLTextAlignmentCenter];
    [printer appendText:str3 alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleMiddle];
    [printer appendSeperatorLine];
    
    [printer appendText:@"用户信息" alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    [printer appendText:[mobile  stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]  alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    [printer appendSeperatorLine];
    
    [printer appendText:@"订单详情" alignment:HLTextAlignmentLeft];
    for (NSInteger i = 0; i < goodsArray.count; i ++) {
        NSString *name = goodsArray[i][@"name"];
        NSString *num = goodsArray[i][@"num"];
        NSString *money = goodsArray[i][@"money"];
          [printer appendLeftText:name middleText:[NSString stringWithFormat:@"x%@",num] rightText:[NSString stringWithFormat:@"%.2f",[money floatValue]] isTitle:NO];

    }
    [printer appendSeperatorLine];
    
    [printer appendTitle:@"总计商品数" value:totalquantity];
    [printer appendTitle:@"金    额" value:totalmoney];
    
    [printer appendSeperatorLine];
    [printer appendTitle:@"订单编号" value:orderid];
    [printer appendTitle:@"下单时间" value:ordertime];
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
