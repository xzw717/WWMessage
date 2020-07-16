//
//  ChangePswViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/22.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ChangePswViewModel.h"

@implementation ChangePswViewModel
+ (void)changePswWithOldpwd:(NSString *)old andNewpwd:(NSString *)new andBlock:(void(^)(id changepswBlock))sender{
    NSLog(@"ssss:%@,%@,%@,%@,%@",MmberidStr,old,new,@1,@1);
    if (old) {
        NSMutableDictionary *dict = @{@"memberid":MmberidStr,@"membertype":@1,@"pwdtype":@1,@"oldpwd":old,@"newpwd":new}.mutableCopy;
           
           NSString *urlStr =[NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBPasswordSaveActionInterface];
           [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict  complete:^(NSDictionary *dic) {
               if (sender) {
                   sender(dic);
               }
           } andError:^(NSError *error) {
               
           } ShowHUD:NO];
    } else {
//        NSMutableDictionary *dict = @{@"memberid":MmberidStr,@"membertype":@1,@"pwdtype":@1,@"oldpwd":old,@"newpwd":new}.mutableCopy;
//
//           NSString *urlStr =[NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBPasswordSaveActionInterface];
//           [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict  complete:^(NSDictionary *dic) {
//               if (sender) {
//                   sender(dic);
//               }
//           } andError:^(NSError *error) {
//
//           } ShowHUD:NO];
//          NSMutableDictionary *dict = @{@"newpwd":new,
//                         @"pwdtype":@1,
//                         @"mobile":self.mobileText.text,
//                         @"inputcode":self.authCodeText.text}.mutableCopy;
//
//            NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBInputNewpwdActionInterface];
//
//            [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
//                if ([dic[@"code"]integerValue] == 49000) {
//                    [SVProgressHUD showSuccessWithStatus:@"修改成功"];
//                    [ManagerEngine SVPAfter:@"修改成功" complete:^{
//                        [self.navigationController popViewControllerAnimated:YES];
//                    }];
//                }else{
//                    [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
//        //            [ManagerEngine dimssLoadView:self.confirmBtn andtitle:@"确认"];
//                }
//
//            } andError:^(NSError *error) {
//        //        [ManagerEngine dimssLoadView:self.confirmBtn andtitle:@"确认"];
//
//            } ShowHUD:YES];
    }
   
    
    
}
@end
