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
    NSMutableDictionary *dict;
    if (types) {
        if ([types isEqualToString:@"线上支付"]) {
            dict = @{@"memberid":MmberidStr,@"page":page,@"type":@2}.mutableCopy;
        }else{
            dict = @{@"memberid":MmberidStr,@"page":page,@"type":@1}.mutableCopy;
        }
    }else{
        dict = @{@"memberid":MmberidStr,@"page":page}.mutableCopy;
        
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@%@?",HQJBBonusDomainName,type];
    HQJLog(@"-%@ dict = %@",urlStr,dict);
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        
        if ([dic[@"code"]integerValue] == 49000 || [dic[@"code"]integerValue] == 49010 ) {
            
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
