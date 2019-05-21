//
//  NotificationService.m
//  NotificationServiceExtension
//
//  Created by 姚 on 2019/5/6.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "NotificationService.h"
#import "ZGAudioManager.h"
@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];

    //step1: 标记该推送已经在这里处理过了
    NSMutableDictionary *dict = [self.bestAttemptContent.userInfo mutableCopy] ;
    [dict setObject:[NSNumber numberWithBool:YES] forKey:@"hasHandled"] ;
    self.bestAttemptContent.userInfo = dict ;
    
    //step2: 忽略推送中的默认语音文件(有可能是那个recieved.mp3)
    self.bestAttemptContent.sound = [UNNotificationSound defaultSound] ;
    
    //step3: 处理推送信息，播放语音
    [[ZGAudioManager sharedPlayer] playPushInfo:self.bestAttemptContent.userInfo completed:^{
        // 播放完成后，通知系统
        self.contentHandler(self.bestAttemptContent);
    }] ;
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
