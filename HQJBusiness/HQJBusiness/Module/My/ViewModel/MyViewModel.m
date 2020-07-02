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

@implementation MyViewModel

- (void)myRequst {
    NSMutableDictionary *dict = @{@"memberid":MmberidStr}.mutableCopy;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBGetMerchantInfoInterface];
    HQJLog(@"地址：%@",urlStr);
    if (MmberidStr) {
        [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
            if ([dic[@"code"] integerValue] == 49000) {
                MyModel *model = [MyModel mj_objectWithKeyValues:dic[@"result"]];
                        [NameSingle shareInstance].subCompanyName = dic[@"result"][@"subCompanyName"];// --- 单例存子公司名字
                        if (self.myrequstBlock) {
                            self.myrequstBlock(model);
                        }
            } else {
                if (self.myrequstErrorBlock) {
                              self.myrequstErrorBlock();
                         
                }
            }
        
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
            StoreManagementViewController *SMVC = [[StoreManagementViewController alloc]init];
            [xzw_self.navigationController pushViewController:SMVC animated:YES];
        } else if (xzw_indexPath.row == 1) {
            // 交易
            DealViewController *DVC = [[DealViewController alloc]init];
            [xzw_self.navigationController pushViewController:DVC animated:YES];
            
            
        } else if (xzw_indexPath.row == 2) {
            //消费码核销
            ConsumerCodeVerificationViewController *ConsumerCodeVC =[[ConsumerCodeVerificationViewController alloc]init];
            [xzw_self.navigationController pushViewController:ConsumerCodeVC animated:YES];
            
            
        } else if (xzw_indexPath.row == 3){
           //待审核申请
            ToAuditViewController *toAuditVC = [[ToAuditViewController alloc]init];
            [xzw_self.navigationController pushViewController:toAuditVC animated:YES];
        } else if (xzw_indexPath.row == 4) {
            // 消息通知
            MessageNotificationViewController *mnVC =[[MessageNotificationViewController alloc]init];
            [xzw_self.navigationController pushViewController:mnVC animated:YES];
        } else if (xzw_indexPath.row == 5){
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



@end
