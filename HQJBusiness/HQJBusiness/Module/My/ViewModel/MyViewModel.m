//
//  MyViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/13.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MyViewModel.h"
#import "MyModel.h"
#import "DealViewController.h"
#import "ConsumerCodeVerificationViewController.h"
#import "ToAuditViewController.h"
#import "SetViewController.h"
#import "MessageNotificationViewController.h"
#import "DeccaDownloadViewController.h"
#import "HQJWebViewController.h"
#import "CertificationViewController.h"
#import "StoreManagementViewController.h"
#import "XDShopViewController.h"
#import "UnionActivityViewController.h"
@implementation MyViewModel

- (void)myRequst {
    NSMutableDictionary *dict = @{@"memberid":MmberidStr,@"hash":HashCode}.mutableCopy;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBMerchantInterface,HQJBGetMerchantInfoInterface];

    HQJLog(@"地址：%@",urlStr);
    if (MmberidStr) {
        @weakify(self);
        [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
            @strongify(self);
            MyModel *model = [MyModel mj_objectWithKeyValues:dic[@"result"]];
            [NameSingle shareInstance].subCompanyName = dic[@"result"][@"subCompanyName"];// --- 单例存子公司名字
            [[NSUserDefaults standardUserDefaults]  setObject:dic[@"result"][@"mobile"] ? dic[@"result"][@"mobile"] : @"" forKey:@"mobile"];
            [[NSUserDefaults standardUserDefaults]  setInteger:[dic[@"result"][@"isComplete"]integerValue] forKey:@"isComplete"];
            [[NSUserDefaults standardUserDefaults]  setInteger:[dic[@"result"][@"typeid"]integerValue] forKey:@"typeid"];
            [[NSUserDefaults standardUserDefaults]  setInteger:[dic[@"result"][@"lockedDuration"]integerValue] forKey:@"lockedDuration"];
            [self getshopidWithMemberid:MmberidStr completion:^(NSString *shopid) {
                if (self.myrequstBlock) {
                    self.myrequstBlock(model);
                         
                }
            }];

            
           
        } andError:^(NSError *error) {
            if (self.myrequstErrorBlock) {
                self.myrequstErrorBlock();
            }
        } ShowHUD:YES];
   
        
        
    }
    
    
}
+ (void)getMerchantTotalAward:(void(^)(NSString *award))completion {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",HQJBBonusDomainName,HQJBXdMerchantProject,HQJBGetMerchantTotalAwardInterface];

    if (MmberidStr) {
        [RequestEngine HQJBusinessGETRequestDetailsUrl:urlStr parameters:@{@"myid":MmberidStr,
                                                                            @"id":MmberidStr,
                                                                            @"hash":HashCode
        } complete:^(NSDictionary *dic) {
            if ([dic[@"code"] integerValue] == 49000) {
                !completion ? :completion(dic[@"result"]);
            } else if ([dic[@"code"] integerValue] == 49126) {
                !completion ? :completion(@"0.00");
            } else {
                !completion ? :completion(@"0.00");
                [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
            }
           
        } andError:^(NSError *error) {
        
        } ShowHUD:NO];
}

}


- (void)getshopidWithMemberid:(NSString *)memberid completion:(void(^)(NSString *shopid))completion {
    NSString *shopidUrlStr = [NSString stringWithFormat:@"%@%@",HQJBFeedbackDomainName,HQJBRetrunShopIdInterface];
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:shopidUrlStr parameters:@{@"memberid":MmberidStr} complete:^(NSDictionary *dic) {
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"shopid"]) {
              [[NSUserDefaults standardUserDefaults]  setObject:dic[@"resultMsg"][@"shopid"] ? dic[@"resultMsg"][@"shopid"] : @"" forKey:@"shopid"];
        }
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"peugeotid"];
        [[NSUserDefaults standardUserDefaults]  setObject:dic[@"resultMsg"][@"peugeotid"] ? dic[@"resultMsg"][@"peugeotid"] : @"" forKey:@"peugeotid"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"classify"];
        [[NSUserDefaults standardUserDefaults]  setObject:dic[@"resultMsg"][@"classify"] ? dic[@"resultMsg"][@"classify"] : @"" forKey:@"classify"]; 
        !completion ? : completion(dic[@"resultMsg"][@"shopid"]);

    } andError:^(NSError *error) {
        if (self.myrequstErrorBlock) {
            self.myrequstErrorBlock();
        }
    } ShowHUD:NO];
}
+ (void)getUseBookingInfo{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBUseBookingInterface];
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:@{@"userid":MmberidStr,@"merchantId":MmberidStr,@"hash":HashCode} complete:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] == 49000) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"canUseBookScore"];
            [[NSUserDefaults standardUserDefaults]  setObject:@"YES" forKey:@"canUseBookScore"];
        } else {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"canUseBookScore"];
            [[NSUserDefaults standardUserDefaults]  setObject:@"NO" forKey:@"canUseBookScore"];
        }

    } andError:^(NSError *error) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"canUseBookScore"];
        [[NSUserDefaults standardUserDefaults]  setObject:@"NO" forKey:@"canUseBookScore"];
        
    } ShowHUD:NO];
}
-(void)jumpVc:(UIViewController *)xzw_self andIndexPath:(NSIndexPath *)xzw_indexPath { 
    if (xzw_indexPath.section == 1) {
        if (xzw_indexPath.row == 0) {
            XDShopViewController *XDVC = [[XDShopViewController alloc]init];
            [xzw_self.navigationController pushViewController:XDVC animated:YES];
            
        } else if (xzw_indexPath.row == 1) {
            StoreManagementViewController *SMVC = [[StoreManagementViewController alloc]init];
            [xzw_self.navigationController pushViewController:SMVC animated:YES];
        } else if (xzw_indexPath.row == 2) {
            // 交易
            DealViewController *DVC = [[DealViewController alloc]init];
            [xzw_self.navigationController pushViewController:DVC animated:YES];
            
        } else if (xzw_indexPath.row == 3) {
            //消费码核销
            ConsumerCodeVerificationViewController *ConsumerCodeVC =[[ConsumerCodeVerificationViewController alloc]init];
            [xzw_self.navigationController pushViewController:ConsumerCodeVC animated:YES];
            
        } else if (xzw_indexPath.row == 4){
            //待审核申请
            ToAuditViewController *toAuditVC = [[ToAuditViewController alloc]init];
            [xzw_self.navigationController pushViewController:toAuditVC animated:YES];
        } else if (xzw_indexPath.row == 5) {
            // 消息通知
            MessageNotificationViewController *mnVC =[[MessageNotificationViewController alloc]init];
            [xzw_self.navigationController pushViewController:mnVC animated:YES];
        }  else if (xzw_indexPath.row == 6){
            // 优惠券
            if ([[NameSingle shareInstance].role containsString:@"物联"] || [[NameSingle shareInstance].role containsString:@"联盟"] ) {
                [SVProgressHUD showErrorWithStatus:@"暂无权限"];
            } else {
                HQJWebViewController *webvc = [[HQJWebViewController alloc]init];
                webvc.zwNavView.hidden = YES;
                //            webvc.webTitleString = @"优惠券";
                //            webvc.webUrlStr = @"http://192.168.16.182:8080/wuwumapH5/index.html#/autonym?userid=23266&mobile=16621048929";
                webvc.webUrlStr = [NSString  stringWithFormat:@"%@shopappH5/index.html#/couponlist?id=%@&hash=%@",WWMCouponDomain
                                   ,MmberidStr,HashCode];
                webvc.fd_interactivePopDisabled = YES;
                [xzw_self.navigationController pushViewController:webvc animated:YES];
            }
            
            
        }else if (xzw_indexPath.row == 7){
            UnionActivityViewController *uaVC = [[UnionActivityViewController alloc]init];
            [xzw_self.navigationController pushViewController:uaVC animated:YES];
        }
        
    }
    if (xzw_indexPath.section  == 2 ) {
        if (xzw_indexPath.row == 0) {
//            if ([[NameSingle shareInstance].role containsString:@"物联"] || [[NameSingle shareInstance].role containsString:@"联盟"] ) {
//                          [SVProgressHUD showErrorWithStatus:@"暂无权限"];
//            } else {  商家入驻开放台卡权限
                DeccaDownloadViewController *deccaVC = [[DeccaDownloadViewController alloc]init];
                  [xzw_self.navigationController pushViewController:deccaVC animated:YES];
//            }
  
        }
        if (xzw_indexPath.row == 1) {
            SetViewController *setVC = [[SetViewController alloc]init];
            [xzw_self.navigationController pushViewController:setVC animated:YES];
        }
        
    }
    
}


+ (void)getXdShopAuditWithCompletion:(void(^)(NSDictionary *dict))completion {
    NSString *url = [NSString stringWithFormat:@"%@%@",HQJBFeedbackDomainName,HQJBXdShopAuditInterface];
    
     [RequestEngine HQJBusinessPOSTRequestDetailsUrl:url parameters:@{@"id":Shopid ? Shopid :@""} complete:^(NSDictionary *dic) {
         if ([dic[@"resultCode"] integerValue] == 2100  ) {
             !completion? : completion(dic[@"resultMsg"]);
         } else {
//             [SVProgressHUD showErrorWithStatus:@"获取状态失败，请稍候重试"];
         }
     } andError:^(NSError *error) {
         
     } ShowHUD:NO];
}


+(void)getHomeBannerBlock:(void (^)(id))sender {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@AppSel2/homeIBanner",AppSel_URL];
    
    
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        if ([dic[@"error"]integerValue] == 0) {
            if (sender) {
                sender(dic[@"result"]);
            }
        }
    
    
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
    
    
}

-(NSArray *)titleLabelArray {
    if ( _titleLabelArray == nil ) {
        _titleLabelArray = @[@[@""],
                             @[@"XD商家",
                               @"店铺管理",
                               @"交易",
                               @"消费码核销",
                               @"待审核申请",
                               @"消息通知",
                               @"优惠券",
                               @"联盟活动"],/*,
                               */
                             @[@"台卡下载",
                               @"设置"]];
    }
    return _titleLabelArray;
}

-(NSArray *)titleImageViewArray {
    if ( _titleImageViewArray == nil ) {
        _titleImageViewArray = @[@[@""],
                                 @[@"icon_my_XD",
                                   @"icon_my_storemanagement",
                                   @"icon_transaction",
                                   @"icon_xfm",
                                   @"icon_unverify",
                                   @"icon_notice",
                                   @"icon_my_coupon",
                                 @"icon_allianceactivities"],/*,
                                   */
                                 @[@"mine_icon_download",
                                   @"icon_setting"]];
    }
    
    return _titleImageViewArray;
}
-(NSArray *)xdTitleImageViewArray {
    if ( _xdTitleImageViewArray == nil ) {
        _xdTitleImageViewArray = @[@[],
                                 @[@"icon_XD_XD",
                                   @"icon_XD_storemanagement",
                                   @"icon_XD_transaction",
                                   @"icon_XD_xfm",
                                   @"icon_XD_unverify",
                                   @"icon_XD_notice",
                                   @"icon_XD_coupon",
                                 @"icon_XD_allianceactivities"],/*,
                                   */
                                 @[@"icon_XD_download",
                                   @"icon_XD_set"]];
    }
    
    return _xdTitleImageViewArray;
}

@end
