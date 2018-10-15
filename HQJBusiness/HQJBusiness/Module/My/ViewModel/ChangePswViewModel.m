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
    NSMutableDictionary *dict = @{@"memberid":MmberidStr,@"membertype":@1,@"pwdtype":@1,@"oldpwd":old,@"newpwd":new}.mutableCopy;
    NSString *urlStr =[NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBPasswordSaveActionInterface];
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict  complete:^(NSDictionary *dic) {
        if (sender) {
            sender(dic);
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
    
    
}
@end
