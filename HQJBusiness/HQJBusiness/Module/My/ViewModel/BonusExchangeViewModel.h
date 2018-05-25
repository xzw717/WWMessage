//
//  BonusExchangeViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/14.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BonusExchangeViewModel : NSObject
+(void)bonusExchaneViewmodelRequstandViewControllerTitle:(NSString *)str AndBack:(void(^)(id sender))exchaneBlock;



+(void)bonusExchangSubmitRequstWithAmount:(NSString *)amount andPassword:(NSString *)psw andViewControllerTitle:(NSString *)str andcardId:(NSString *)accountid andbonusBlock:(void(^)(id sender))blocks ;
@end
