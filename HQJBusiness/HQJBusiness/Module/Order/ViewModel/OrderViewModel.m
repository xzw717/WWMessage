//
//  OrderViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/26.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderViewModel.h"
#import "OrderModel.h"

@implementation OrderViewModel
- (void)orderRequstWithPage:(NSInteger)page andType:(NSInteger)type andReturnBlock:(void(^)(id sender))output {
    
    
    NSString *urlStr ;
    if (type != 10086) {
        urlStr = [NSString stringWithFormat:@"%@order/shopfindorderlist.action?memberid=%@&start=%ld&pageSize=15&type=%ld",OrderTest_URL,MmberidStr,(long)page,(long)type] ;
    } else {
      urlStr  = [NSString stringWithFormat:@"%@order/shopfindConsumableOrderList.action?memberid=%@&start=%ld&pageSize=15",OrderTest_URL,MmberidStr,(long)page] ;
    }
    
    
    HQJLog(@"-%@",urlStr);
    [RequestEngine HQJBusinessRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        if([dic[@"resultCode"]integerValue] == 2700 ) {
            
            NSArray *resultArray = (NSArray *)dic[@"resultMsg"][@"orderList"];
            
            NSMutableArray *modelAry = [NSMutableArray arrayWithCapacity:resultArray.count];
            for (NSDictionary *dict in resultArray) {
                OrderModel *model = [OrderModel mj_objectWithKeyValues:dict];
                [modelAry addObject:model];
            
           
            }
            
            if (output) {
                output (modelAry);
            }
            
        }
       
    } andError:^(NSError *error) {
        !self.ErrorBlock ? : self.ErrorBlock(error.localizedDescription);
    } ShowHUD:YES];

}

+ (void)requestCustomerInformationWith:(NSString *)customerID
                              complete:(void(^)(NSString *mobile,NSString *realname))complete {
    NSString *strUrl = [NSString stringWithFormat:@"%@index.php?m=HQJ&c=Api&a=getMemberInfo&mobile=%@&membertype=customer",AppSel_URL,customerID];
    [RequestEngine HQJBusinessRequestDetailsUrl:strUrl complete:^(NSDictionary *dic) {
        if ([dic[@"error"]integerValue] == 0) {
            if (complete) {
                complete(dic[@"result"][@"mobile"],dic[@"result"][@"realname"]);
            }
        } else {
            
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}

@end
