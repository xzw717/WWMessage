//
//  ContactManagerViewModel.m
//  HQJBusiness
//
//  Created by 姚志中 on 2020/5/21.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ContactManagerViewModel.h"

@implementation ContactManagerViewModel
+ (void)getContactManagerList:(NSString *)shopid andSignResul:(NSInteger)signResul completion:(void(^)(NSArray <ContactModel *>*list))completion{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBDomainName,HQJBshopAllESignListInterface];
    NSDictionary *dict = @{@"shopid":shopid,
                           @"signResul":[NSString stringWithFormat:@"%ld",signResul]};
    
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        if ([dic[@"resultCode"] integerValue] == 2000) {
            NSArray *resultMsgArray = dic[@"resultMsg"];
            NSMutableArray *resultArray = [NSMutableArray array];
             if (resultMsgArray.count > 0) {
                 for (NSDictionary *resultDic in resultMsgArray) {
                     ContactModel *model = [ContactModel mj_objectWithKeyValues:resultDic];
                     [resultArray addObject:model];
                 }
             }
            if (completion) {
                completion(resultArray);
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"resultHint"]];
        }
        
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
    
}
@end
