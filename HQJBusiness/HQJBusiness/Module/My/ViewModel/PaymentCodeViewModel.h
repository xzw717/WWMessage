//
//  PaymentCodeViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2017/10/20.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaymentCodeViewModel : NSObject

/**
 查询 码

 @param codelist 码的模型数组 
 */
- (void)paymentCodeRequstList:(void(^)(NSArray *models))codelist codelistNull:(void(^)(void))isNull;


/**
 删除 码

 @param codeid 删除 码的id
 @param complete 删除完成
 */
- (void)paymentCodeDeletList:(NSString *)codeid complete:(void(^)(void))complete;

/**
 添加 码

 @param codeurl 码的连接
 @param type 码的种类
 @param complete 添加完成
 */
- (void)paymentCodeAddList:(NSString *)codeurl codetype:(NSString *)type complete:(void (^)(NSString *str))complete ;

@end
