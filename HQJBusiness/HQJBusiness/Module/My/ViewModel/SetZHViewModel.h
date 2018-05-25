//
//  SetZHViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/19.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetZHViewModel : NSObject




/**
 获取原来的比例

 @param proportion 比例
 */
+(void)getBonusZHCashZHWithBlock:(void(^)(id sender))proportion;





/**
 更新刚设置的比例

 @param bonus 积分
 @param cash 现金
 @param zw_self 所在的控制器对象
 */
+(void)setBonusZH:(NSString *)bonus andCashZH:(NSString *)cash andViewController:(UIViewController *)zw_self;
@end
