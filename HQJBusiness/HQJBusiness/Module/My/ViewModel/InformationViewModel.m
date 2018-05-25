//
//  InformationViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/22.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "InformationViewModel.h"
#import "informationModel.h"

@implementation InformationViewModel

+ (void)informationRequstBlock:(void(^)(id infoBlock))sender {
    
    NSString *urlStr =[NSString stringWithFormat:@"%@AppSel2/myInforModify/memberid/%@",AppSel_URL,MmberidStr];
    
    [RequestEngine HQJBusinessRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        if ([dic[@"error"]integerValue] == 0) {
            informationModel *model = [informationModel mj_objectWithKeyValues:dic[@"result"]];
            if (sender) {
                sender(model);
            }
        }
       
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}




@end
