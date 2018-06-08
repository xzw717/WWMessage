//
//  DetailViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/23.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "DetailViewModel.h"

#import "NSDictionary+Preoperty.h"

@implementation DetailViewModel



+ (void)detailRequsttype:(NSString *)type types:(NSString *)types page:(NSString *)page listBlock:(void(^)(NSArray <DetailModel *>*sender))detailBlock {
    NSString *urlStr;
    NSMutableDictionary *dict;
    if (types) {
        dict = @{@"memberid":MmberidStr,@"page":page,@"type":[types isEqualToString:@"线下支付"] ? @"2" : @"1"}.mutableCopy;
//        urlStr = [NSString stringWithFormat:@"%@AppSel2/%@/memberid/%@/page/%@/type/%@",AppSel_URL,type,MmberidStr,page,[types isEqualToString:@"线下支付"] ? @"2" : @"1"] ;
        urlStr = [NSString stringWithFormat:@"%@%@?",HQJBBonusDomainName,type];
    } else {
        dict = @{@"memberid":MmberidStr,@"page":page}.mutableCopy;
        urlStr = [NSString stringWithFormat:@"%@%@?",HQJBBonusDomainName,type];
    }
    HQJLog(@"-%@",urlStr);
    [RequestEngine HQJBusinessRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        
        if ([dic[@"code"]integerValue] == 49000) {
            
            NSArray *resultArray = dic[@"result"];
            NSMutableArray *modelArray = [NSMutableArray array];
            modelArray =  [DetailModel mj_objectArrayWithKeyValuesArray:resultArray];
//            for (NSDictionary *dicOne in resultArray) {
//                DetailModel *model = [DetailModel mj_objectWithKeyValues:dicOne];
//                [modelArray addObject:model];
//            }
            if (detailBlock) {
                detailBlock(modelArray);
            }
            
            
        } else {
            [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
    
    
}
@end
