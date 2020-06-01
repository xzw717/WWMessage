//
//  XDDetailViewModel.m
//  HQJBusiness
//
//  Created by 姚志中 on 2020/5/18.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDDetailViewModel.h"

@implementation XDDetailViewModel

+ (CGFloat)getStringHeight:(NSString *)text{
    CGFloat w = WIDTH - 156/3;
    CGSize labelsize  = [text
                         boundingRectWithSize:CGSizeMake(w, CGFLOAT_MAX)
                         options:NSStringDrawingUsesLineFragmentOrigin
                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:40/3]}
                         context:nil].size;
    return labelsize.height + 1;
}
+ (CGFloat)getSecCellHeight:(NSArray *)dataArray{
    CGFloat x = 50/3,y = 10,temp;
    for (int i = 0; i < dataArray.count; i ++) {
        NSString *result = dataArray[i];
        CGFloat width = [ManagerEngine setTextWidthStr:result andFont:[UIFont systemFontOfSize:40/3]] + 12;
        x = x + width + 100;
        if (i < dataArray.count - 1) {
            NSString *nextStr = dataArray[i+1] ;
            CGFloat nextWidth = [ManagerEngine setTextWidthStr:nextStr andFont:[UIFont systemFontOfSize:40/3]] + 12;
            temp = x + nextWidth;
            if (temp>WIDTH-50/3) {
                y+=24;
                x = 50/3;
            }
        }
    }
    return y + 32;
}

+ (void)getXDShopState:(NSString *)shopid andPeugeotid:(NSString *)peugeotid completion:(void(^)(id dict))completion{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBDomainName,HQJBXdFlowInterface];
    NSDictionary *dict = @{@"shopid":shopid,
                           @"peugeotid":peugeotid};
    
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        if ([dic[@"resultCode"] integerValue] == 1800) {
            if (completion) {
                completion(dic[@"resultMsg"]);
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"resultHint"]];
        }
        
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
}
+ (void)initiateESign:(NSString *)shopid andType:(NSString *)type andState:(NSString *)state andPeugeotid:(NSString *)peugeotid completion:(void(^)(id result))completion{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBDomainName,HQJBInitiateESignInterface];
    NSDictionary *dict = @{@"shopid":shopid,
                           @"type":type,
                           @"state":@"1",
                           @"peugeotid":peugeotid};
    
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        if ([dic[@"resultCode"] integerValue] == 1800) {
            if (completion) {
                completion(dic[@"resultMsg"]);
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"resultHint"]];
        }
        
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
}
+ (void)submitXDOrder:(NSString *)shopid andProid:(NSString *)proid andPrice:(NSString *)price completion:(void(^)(XDPayModel *model))completion{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBDomainName,HQJBXdorderInterface];
    NSDictionary *dict = @{@"shopid":shopid,
                           @"proid":proid,
                           @"price":price};
    
    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        if ([dic[@"resultCode"] integerValue] == 2000) {
            XDPayModel *model = [XDPayModel mj_objectWithKeyValues:dic[@"resultMsg"]];
            if (completion) {
                completion(model);
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:dic[@"resultHint"]];
        }
        
    } andError:^(NSError *error) {
        
    } ShowHUD:NO];
    
}
@end
