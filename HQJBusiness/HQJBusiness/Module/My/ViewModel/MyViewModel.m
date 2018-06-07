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
@implementation MyViewModel

- (void)myRequst {
    NSMutableDictionary *dict = @{@"memberid":MmberidStr}.mutableCopy;
//    NSString *urlStr = [NSString stringWithFormat:@"%@AppSel2/myInfor/id/%@",AppSel_URL,MmberidStr];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBGetMerchantInfoInterface];
    HQJLog(@"地址：%@",urlStr);
    if (MmberidStr) {
        [RequestEngine HQJBusinessRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
            MyModel *model = [MyModel mj_objectWithKeyValues:dic[@"result"]];
            if (self.myrequstBlock) {
                self.myrequstBlock(model);
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
            // 交易
            DealViewController *DVC = [[DealViewController alloc]init];
            [xzw_self.navigationController pushViewController:DVC animated:YES];
            
            
        } else if (xzw_indexPath.row == 1) {
            //消费码核销
            ConsumerCodeVerificationViewController *ConsumerCodeVC =[[ConsumerCodeVerificationViewController alloc]init];
            [xzw_self.navigationController pushViewController:ConsumerCodeVC animated:YES];
            
            
        } else if (xzw_indexPath.row == 2){
           //待审核申请
            ToAuditViewController *toAuditVC = [[ToAuditViewController alloc]init];
            [xzw_self.navigationController pushViewController:toAuditVC animated:YES];
        } else {
            MessageNotificationViewController *mnVC =[[MessageNotificationViewController alloc]init];
            [xzw_self.navigationController pushViewController:mnVC animated:YES];
        }
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
    
    
    [RequestEngine HQJBusinessRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        if ([dic[@"error"]integerValue] == 0) {
            if (sender) {
                sender(dic[@"result"]);
            }
        }
    
    
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
    
    
}



@end
