//
//  ChangePswViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/22.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ChangePswViewModel.h"

@implementation ChangePswViewModel
+(void)changePswWithOldpwd:(NSString *)old andNewpwd:(NSString *)new andBlock:(void(^)(id changepswBlock))sender{
    
    
    NSString *urlStr =[NSString stringWithFormat:@"%@passwordSaveAction/memberid/%@/membertype/seller/pwdtype/loginpwd/oldpwd/%@/newpwd/%@",Api_URL,MmberidStr,old,new];
    [RequestEngine HQJBusinessRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        if (sender) {
            sender(dic);
        }
                
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
    
    
}
@end
