//
//  UMShareManager.m
//  WuWuMap
//
//  Created by MyMac on 2017/7/3.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "UMShareManager.h"
#import <UIImageView+WebCache.h>
#import "HQJShareView.h"
static  UMShareManager   *   _manager;

@implementation ShareMessage

-(instancetype)initWithShareKind:(ShareKind)shareKind{
    if ( self = [super init] ) {
        _shareKind = shareKind;
    }
    return self;
}

-(void)setThumbURL:(id)thumbURL{
    if ([[thumbURL class]isEqual:[UIImage class]]) {
        _thubImg =  thumbURL;
    } else {
        UIImageView * imageV = [[UIImageView alloc]init];
        [imageV sd_setImageWithURL:[NSURL URLWithString:thumbURL]];
        _thubImg = imageV.image;
    }
}

-(void)setObjectId:(NSString *)objectId{
    
    _objectId = objectId;
//    if ( _shareKind == ShareGood ) {
//        _webpageURL = [NSString stringWithFormat:@"%@share/goods.html?goodsid=%@",WWMDomainName,_objectId];
//    }else if (_shareKind == ShareShop ) {
//        _webpageURL = [NSString stringWithFormat:@"%@share/shop.html?shopid=%@",WWMDomainName,_objectId];
//    } else if (_shareKind == ShareRegistered ){
//        _webpageURL = [NSString stringWithFormat:@"%@%@?itype=1&role=2&fid=%@&reid=%@",WWMBonusDomain,WWMRegistrationInterface,T_USERFID,T_Memberid];
//    }else if (_shareKind == ShareMeeting) {
//        NSString *url = [NSString stringWithFormat:@"%@wuwuappH5/toconfigure?fid=%@&reid=%@&conferenceid=%@&url=%@ ",WWMMeetingShareDomain,T_USERFID,T_Memberid,self.objectId,self.otherField];
//        _webpageURL = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)url, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL,kCFStringEncodingUTF8));
//    } else { /// 分享京东商品
//        _webpageURL = _objectId;
//
//    }
    NSLog(@"_webpageURL = %@",_webpageURL);
    
}

@end


@implementation UMShareManager

+(instancetype)manager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc]init];
        [_manager registUM];
        [_manager registSharePlatform];
    });
    
    return _manager;
}
#pragma mark ==============================对外开放==========================================
/**
 展示分享界面
 @param message 分享信息内容的Model
 */
+(void)showSelectSharePlatformView:(id)message{
    
    NSURL * QQ_scheme = [NSURL URLWithString:@"mqq://"];
    NSURL * WX_scheme = [NSURL URLWithString:@"weixin://"];

    NSLog(@"qq open %d weixin open %d",[[UIApplication sharedApplication] canOpenURL:QQ_scheme],[[UIApplication sharedApplication] canOpenURL:WX_scheme]);
    if ( ![[UIApplication sharedApplication] canOpenURL:QQ_scheme] && ![[UIApplication sharedApplication] canOpenURL:WX_scheme] ) {
        
        UIWindow * window = [UIApplication sharedApplication].delegate.window;
//        [ToolManager alertViewWithTitle:@"提示" messaages:@"请您安装QQ或微信后再分享" preferredStyle:UIAlertControllerStyleAlert defaultAction:^{
//
//        } controller:window.rootViewController];
        
        return;
    }
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [_manager shareWebPageToPlatformType:platformType message:message];
    }];
}

+(void)showMeetingharePlatformView:(id)message{
    ShareMessage * shareMesg = message;
    NSURL * QQ_scheme = [NSURL URLWithString:@"mqq://"];
    NSURL * WX_scheme = [NSURL URLWithString:@"weixin://"];

    NSLog(@"qq open %d weixin open %d",[[UIApplication sharedApplication] canOpenURL:QQ_scheme],[[UIApplication sharedApplication] canOpenURL:WX_scheme]);
    if ( ![[UIApplication sharedApplication] canOpenURL:QQ_scheme] && ![[UIApplication sharedApplication] canOpenURL:WX_scheme] ) {

//        UIWindow * window = [UIApplication sharedApplication].delegate.window;
//        [ToolManager alertViewWithTitle:@"提示" messaages:@"请您安装QQ或微信后再分享" preferredStyle:UIAlertControllerStyleAlert defaultAction:^{
//
//        } controller:window.rootViewController];

        return;
    }
    NSArray *titleArr = @[@[@"微信",@"icon_share_wx"],@[@"朋友圈",@"icon_share_pyq"]];
    HQJShareView *shareView = [[HQJShareView alloc]initWithTitleArray:titleArr];
    shareView.clickItemblock = ^(NSString * _Nonnull title) {
        if ([title isEqualToString:@"微信"]) {
             [_manager runShareWithType:UMSocialPlatformType_WechatSession message:shareMesg];
        }else if ([title isEqualToString:@"朋友圈"]){
             [_manager runShareWithType:UMSocialPlatformType_WechatTimeLine message:shareMesg] ;
        }else if ([title isEqualToString:@"QQ"]){
             [_manager runShareWithType:UMSocialPlatformType_QQ message:shareMesg];
        }else{
//             UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//             pasteboard.string = shareMesg.webpageURL;
//             [MBProgressHUD showSuccess:@"链接复制成功"];
        }
    };
    [[[[UIApplication sharedApplication] delegate] window] addSubview:shareView];
}

- (void)clickShareViewWithTitle:(NSString *)title message:(id)message {
    ShareMessage * shareMesg = message;
    if ([title isEqualToString:@"微信"]) {
        [_manager runShareWithType:UMSocialPlatformType_WechatSession message:shareMesg];
    }else if ([title isEqualToString:@"朋友圈"]){
        [_manager runShareWithType:UMSocialPlatformType_WechatTimeLine message:shareMesg] ;
    }else if ([title isEqualToString:@"QQ"]){
        [_manager runShareWithType:UMSocialPlatformType_QQ message:shareMesg];
    }else{
        
    }
}
- (void)runShareWithType:(UMSocialPlatformType)type message:(ShareMessage *)message{
      UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
      //创建图片内容对象
      UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
      //如果有缩略图，则设置缩略图
      shareObject.thumbImage = message.thubImg;
    [shareObject setShareImage:message.thubImg];
      //分享消息对象设置分享内容对象
      messageObject.shareObject = shareObject;

    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
                            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                                UMSocialShareResponse *resp = data;
                                //分享结果消息
                                UMSocialLogInfo(@"response message is %@",resp.message);
                                //第三方原始返回的数据
                                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
        
                            }else{
                                UMSocialLogInfo(@"response data is %@",data);
                            }
        }
                                
      }];

                 
            
}

#pragma mark =============================不对外开放==========================================
/*注册友盟*/
-(void)registUM{
    [[UMSocialManager defaultManager] openLog:YES];//打开调试日志
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5f237473d30932215473a0ff"];
    [UMSocialUIManager setShareMenuViewDelegate:self];
    
}

/*组册分享平台*/
-(void)registSharePlatform{
    
    //微信
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxbaea3263c2c6bbe6" appSecret:@"c11612aad04a5379cc2432448676c3cd" redirectURL:@""];

    //QQ
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_APP_ID  appSecret:nil redirectURL:@""];
}

/*网页分享*/
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType message:(id)message
{
    ShareMessage * shareMesg = message;
        //分享数据
            /*创建网页内容对象*/
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:shareMesg.name descr:shareMesg.descripText thumImage:shareMesg.thubImg];
            //设置网页地址
            shareObject.webpageUrl = shareMesg.webpageURL;
            NSLog(@"qw:%@",shareObject.webpageUrl);
            
            /*创建分享消息对象*/
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
            
            
            
            
            //调用分享接口
            [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                if (error) {
                    UMSocialLogInfo(@"************Share fail with error %@*********",error);
                }else{
                    if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                        UMSocialShareResponse *resp = data;
                        //分享结果消息
                        UMSocialLogInfo(@"response message is %@",resp.message);
                        //第三方原始返回的数据
                        UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                        
                    }else{
                        UMSocialLogInfo(@"response data is %@",data);
                    }
                }
//                if([self.doTask isEqualToString:@"做任务"] ) {
//                    /// 微信聊天已经分享的次数
//                    NSInteger wechatSessionNumbers = [[ToolManager getDataKey:WWMWechatSessionKey] integerValue];
//
//                    /// 微信聊天已经分享的次数
//                    NSInteger wechatTimeLineNumbers = [[ToolManager getDataKey:WWMWechatTimeLineKey] integerValue];
//                    if (platformType == UMSocialPlatformType_WechatSession) {
//                        if (wechatSessionNumbers && wechatSessionNumbers >= 0) {
//                            if (wechatSessionNumbers < 3) {
//                                wechatSessionNumbers ++;
//                                [ToolManager setDataObject:[NSString stringWithFormat:@"%ld",wechatSessionNumbers] key:WWMWechatSessionKey];
//                            }
//                        } else {
//                            [ToolManager setDataObject:@"1" key:WWMWechatSessionKey];
//
//                        }
//                    }
//                    if (platformType == UMSocialPlatformType_WechatTimeLine) {
//                        if (!wechatTimeLineNumbers ){
//                            [ToolManager setDataObject:@"1" key:WWMWechatTimeLineKey];
//
//                        }
//                    }
//
//                    NSString *alert ;
//                    NSString *btnTitle;
//                    NSInteger residueDegree = [[ToolManager getDataKey:WWMWechatSessionKey] integerValue] + [[ToolManager getDataKey:WWMWechatTimeLineKey] integerValue];
//        //           void(^successBlcok)(void);
//                    if (residueDegree == 4 &&
//                        [[ToolManager getDataKey:WWMWechatSessionKey] integerValue] == 3 &&
//                        [[ToolManager getDataKey:WWMWechatTimeLineKey] integerValue] == 1) {
//                        alert = @"已完成任务";
//                        btnTitle = @"好的";
//                        [[RequstManager getAFManager] HQJWuWuMapRequestDetailsUrl:[NSString stringWithFormat:@"%@%@",WWMBonusDomainName,WWMSharedAwardInterface] parameters:@{@"mobile":T_MOBILE,@"hash":T_HASHCODE} complete:^(id dic) {
//                            if ([dic[@"msg"] isEqualToString:@"操作成功"]) {
////                                [JDStatusBarNotification showWithStatus:@"领取成功" dismissAfter:1.5 styleName:@"JDStatusBarStyleSuccess"] ;
//                                [ToolManager showCenterToastWithTitle:@"领取成功"];
//
//
//                            } else {
////                                [JDStatusBarNotification showWithStatus:dic[@"msg"] dismissAfter:1.5 styleName:@"JDStatusBarStyleWarning"] ;
//                                [ToolManager showCenterToastWithTitle:dic[@"msg"]];
//
//
//                            }
//                        } andError:nil showHUD:RequstAlertNotShowDefault alertText:nil];
//        //                successBlcok = nil;
//                    } else {
//                        NSInteger replace = 4 - [[ToolManager getDataKey:WWMWechatSessionKey] integerValue] - [[ToolManager getDataKey:WWMWechatTimeLineKey] integerValue];
//                        alert = [NSString stringWithFormat:@"再分享%ld次，即可获得%.f积分",(long)replace,self.rewards];
//                        btnTitle = @"继续分享";
//        //                successBlcok = nil;
//                    }
//                    PerfectView *pview = [[PerfectView alloc]initWithTitle:alert andSubTitle:@"分享成功" andImageName:@"img_successsmile" andImageSize:CGSizeMake(NewProportion(459), NewProportion(571)) andSureTitle:btnTitle];
//                    pview.contentLabel.textAlignment = NSTextAlignmentCenter;
//                    pview.contentLabel.font = [UIFont boldSystemFontOfSize:18];
//        //            pview.sureResult = successBlcok;
//                    [[UIApplication sharedApplication].delegate.window addSubview:pview];
//                } else {
                     [_manager alertWithError:error];
//                }
            }];
    
    
}
     
/*设置分享面板父视图*/
-(UIView*)UMSocialParentView:(UIView *)defaultSuperView{
    
    return [[[UIApplication sharedApplication] delegate] window];
}

- (void)alertWithError:(NSError *)error{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"分享成功"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"分享失败"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享"
                                                    message:result
                                                    delegate:nil
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil];
    [alert show];
}
+(void)shareImage{
    NSURL * QQ_scheme = [NSURL URLWithString:@"mqq://"];
    NSURL * WX_scheme = [NSURL URLWithString:@"weixin://"];
    
    //    [[UIApplication sharedApplication] openURL:QQ_scheme options:nil completionHandler:nil];
    
    if ( ![[UIApplication sharedApplication] canOpenURL:QQ_scheme] && ![[UIApplication sharedApplication] canOpenURL:WX_scheme] ) {
        
        UIWindow * window = [UIApplication sharedApplication].delegate.window;
//        [ToolManager alertViewWithTitle:@"提示" messaages:@"请您安装QQ或微信后再分享" preferredStyle:UIAlertControllerStyleAlert defaultAction:^{
//
//        } controller:window.rootViewController];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请您安装QQ或微信后再分享"
                                                        delegate:nil
                                                cancelButtonTitle:@"确定"
                                                otherButtonTitles:nil];
        [alert show];
        return;
    }
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//        [_manager shareImageToPlatformType:platformType];
    }];
}

//- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
//{
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//
//    //创建图片内容对象
//    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
//    //生成二维码海报图片
//    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 360, 640)];
//    iv.image = [UIImage imageNamed:@"icon_register_poster.jpg"];
//    UIImageView *codeImagView = [[UIImageView alloc]initWithFrame:CGRectMake(360 - NewProportion(59) - NewProportion(249), 640 - NewProportion(89)- NewProportion(249), NewProportion(249), NewProportion(249))];
////    NSString *url = [NSString stringWithFormat:@"%@%@?itype=1&role=2&fid=%@&reid=%@",WWMBonusDomain,WWMWeChatregisterInterface,T_USERFID,T_Memberid];
////    codeImagView.image = [ToolManager createNonInterpolatedUIImageFormCIImage:[ToolManager outputImageStr:url] withSize:NewProportion(249)];
////    [iv addSubview:codeImagView];
////    UIImage *shareImage =  [ToolManager yzz_convertCreateImageWithUIView:iv];
//
//    [shareObject setShareImage:shareImage];
//    //分享消息对象设置分享内容对象
//    messageObject.shareObject = shareObject;
//
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        if (error) {
//            NSLog(@"************Share fail with error %@*********",error);
//        }else{
//            NSLog(@"response data is %@",data);
//        }
//    }];
//}
@end

