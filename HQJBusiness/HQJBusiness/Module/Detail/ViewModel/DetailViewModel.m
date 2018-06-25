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
    NSMutableDictionary *dict = @{@"memberid":MmberidStr,@"page":page}.mutableCopy;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@?",HQJBBonusDomainName,type];
    HQJLog(@"-%@ dict = %@",urlStr,dict);
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        
        if ([dic[@"code"]integerValue] == 49000) {
            
            NSArray *resultArray = dic[@"result"];
            NSMutableArray *modelArray = [NSMutableArray array];
            modelArray =  [DetailModel mj_objectArrayWithKeyValuesArray:resultArray];
            NSMutableArray *resluts = @[].mutableCopy;
            if(types){
                for (DetailModel *model in modelArray) {
                    if ([types isEqualToString:@"线下支付"]) {
                        if (model.tradetype.integerValue == 1||model.tradetype.integerValue == 10) {
                            [resluts addObject:model];
                        }
                    }else{
                        if (model.tradetype.integerValue == 12||model.tradetype.integerValue == 13||model.tradetype.integerValue == 14) {
                            [resluts addObject:model];
                        }
                    }
                }
                
            }else{
                resluts = modelArray;
            }
//            for (NSDictionary *dicOne in resultArray) {
//                DetailModel *model = [DetailModel mj_objectWithKeyValues:dicOne];
//                [modelArray addObject:model];
//            }
            if (detailBlock) {
                detailBlock(resluts);
            }
            
            
        } else {
            [SVProgressHUD showErrorWithStatus:dic[@"msg"]];
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
    
    
}
@end
