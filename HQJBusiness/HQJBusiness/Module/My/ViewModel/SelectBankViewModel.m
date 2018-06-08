//
//  SelectBankViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/27.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "SelectBankViewModel.h"
#import "SelectBankModel.h"

@implementation SelectBankViewModel
+ (void)selectBankBLock:(void (^)(id sender))select {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBAccountListInterface];
    HQJLog(@"%@",MmberidStr);
    [RequestEngine HQJBusinessGETRequestDetailsUrl:urlStr parameters:@{@"memberid":MmberidStr} complete:^(NSDictionary *dic) {
        if ([dic[@"code"] integerValue] == 49000) {
            NSArray *resultAry = dic[@"result"];
            NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:resultAry.count];
            for (NSDictionary *dicOne in resultAry) {
                SelectBankModel *model = [SelectBankModel mj_objectWithKeyValues:dicOne];
                [modelArray addObject:model];
            }
            if (select) {
                select(modelArray);
            }
            
        }
        
        
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
  
}
@end
