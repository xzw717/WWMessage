//
//  UMShareManager.h
//  WuWuMap
//
//  Created by MyMac on 2017/7/3.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>

typedef NS_ENUM(NSInteger, ShareKind){
    ShareGood                    = 1,
    ShareShop                    = 2,
    ShareRegistered              = 3,
    ShareMeeting                 = 4,
    ShareJDGoods                 = 5  /// 分享京东商品
    
};

@interface ShareMessage : NSObject

@property (nonatomic, copy) NSString            * objectId;
@property (nonatomic, assign) ShareKind         shareKind;
@property (nonatomic, copy) NSString            * name;
@property (nonatomic, strong) id                   thumbURL;
@property (nonatomic, copy) NSString            * descripText;
@property (nonatomic, copy) NSString            * webpageURL;
@property (nonatomic, strong) UIImage           * thubImg;
@property (nonatomic, strong) NSString           * imgUrl;

//备用
@property (nonatomic, strong) NSString           * otherField;


-(instancetype)initWithShareKind:(ShareKind)shareKind;

@end



@interface UMShareManager : UIViewController<UMSocialShareMenuViewDelegate>
@property (nonatomic, strong) NSString *doTask;
///需要分享的次数
@property (nonatomic, assign) NSInteger number;
/// 可得到的奖励
@property (nonatomic, assign) CGFloat rewards;

+(instancetype)manager;

+(void)showSelectSharePlatformView:(id)message;

+(void)showMeetingharePlatformView:(id)message;

+(void)shareImage;

- (void)clickShareViewWithTitle:(NSString *)title message:(id)message;
@end
