//
//  CashDealVC.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/23.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashDealVC : UIViewController

- (void)setDataSource;
-(void)requstPage:(NSString *)page title:(NSString *)title complete:(void(^)(void))completeBlcok;
@end
