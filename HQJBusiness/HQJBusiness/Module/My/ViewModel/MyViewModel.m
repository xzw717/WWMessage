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
#import "XDShopViewController.h"

@implementation MyViewModel

- (void)myRequst {
    NSMutableDictionary *dict = @{@"memberid":MmberidStr}.mutableCopy;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBGetMerchantInfoInterface];
    NSString *shopidUrlStr = [NSString stringWithFormat:@"%@%@",HQJBFeedbackDomainName,HQJBRetrunShopIdInterface];

    HQJLog(@"地址：%@",urlStr);
    if (MmberidStr) {
        [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
            MyModel *model = [MyModel mj_objectWithKeyValues:dic[@"result"]];
            [NameSingle shareInstance].subCompanyName = dic[@"result"][@"subCompanyName"];// --- 单例存子公司名字
            if (self.myrequstBlock) {
                self.myrequstBlock(model);
            }
        } andError:^(NSError *error) {
            if (self.myrequstErrorBlock) {
                self.myrequstErrorBlock();
            }
        } ShowHUD:YES];
        [RequestEngine HQJBusinessPOSTRequestDetailsUrl:shopidUrlStr parameters:dict complete:^(NSDictionary *dic) {
            [[NSUserDefaults standardUserDefaults]  setObject:dic[@"resultMsg"][@"shopid"] ? dic[@"resultMsg"][@"shopid"] : @"" forKey:@"shopid"];
            [[NSUserDefaults standardUserDefaults]  setObject:dic[@"resultMsg"][@"peugeotid"] ? dic[@"resultMsg"][@"peugeotid"] : @"" forKey:@"peugeotid"];

//            [FileEngine filePathNameCreateandNameMutablefilePatch:fileLoginStyle Dictionary:@{@"shopid":dic[@"resultMsg"][@"shopId"] ? dic[@"resultMsg"][@"shopId"] : @""}.mutableCopy];

          } andError:^(NSError *error) {
              if (self.myrequstErrorBlock) {
                  self.myrequstErrorBlock();
              }
          } ShowHUD:YES];
        
        
        
    }
    
    
}



-(void)jumpVc:(UIViewController *)xzw_self andIndexPath:(NSIndexPath *)xzw_indexPath { 
    if (xzw_indexPath.section == 1) {
        if (xzw_indexPath.row == 0) {
            XDShopViewController *XDVC = [[XDShopViewController alloc]init];
            [xzw_self.navigationController pushViewController:XDVC animated:YES];
        } else if (xzw_indexPath.row == 1)  {
            [SVProgressHUD showErrorWithStatus:@"暂未开放"];
        }  else if (xzw_indexPath.row == 2) {
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
        } else if (xzw_indexPath.row == 6){
            // 优惠券
            HQJWebViewController *webvc = [[HQJWebViewController alloc]init];
//            webvc.webTitleString = @"优惠券";
//            webvc.webUrlStr = @"http://192.168.16.182:8080/wuwumapH5/index.html#/autonym?userid=23266&mobile=16621048929";
            webvc.webUrlStr = [NSString  stringWithFormat:@"%@shopappH5/index.html#/couponlist?id=%@&hash=%@",WWMCouponDomain
                               ,MmberidStr,HashCode];
            webvc.fd_interactivePopDisabled = YES;
            [xzw_self.navigationController pushViewController:webvc animated:YES];
            
        }
//        else {
//            CertificationViewController *cvc =[[CertificationViewController alloc]init];
//            [xzw_self.navigationController pushViewController:cvc animated:YES];
//        }
    }
    if (xzw_indexPath.section  == 2 ) {
        if (xzw_indexPath.row == 0) {
            
            DeccaDownloadViewController *deccaVC = [[DeccaDownloadViewController alloc]init];
            [xzw_self.navigationController pushViewController:deccaVC animated:YES];
        }
        if (xzw_indexPath.row == 1) {
            SetViewController *setVC = [[SetViewController alloc]init];
            [xzw_self.navigationController pushViewController:setVC animated:YES];
        }
        
    }
    
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
        _titleLabelArray = @[@[],
                             @[@"XD商家",
                               @"店铺管理",
                               @"交易",
                               @"消费码核销",
                               @"待审核申请",
                               @"消息通知",
                               @"优惠券"],/*,
                               */
                             @[@"台卡下载",
                               @"设置"]];
    }
    return _titleLabelArray;
}

-(NSArray *)titleImageViewArray {
    if ( _titleImageViewArray == nil ) {
        _titleImageViewArray = @[@[],
                                 @[@"icon_my_XD",
                                   @"icon_my_storemanagement",
                                   @"icon_transaction",
                                   @"icon_xfm",
                                   @"icon_unverify",
                                   @"icon_notice",
                                   @"icon_my_coupon"],/*,
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
                                   @"icon_XD_coupon"],/*,
                                   */
                                 @[@"icon_XD_download",
                                   @"icon_XD_set"]];
    }
    
    return _xdTitleImageViewArray;
}

@end
