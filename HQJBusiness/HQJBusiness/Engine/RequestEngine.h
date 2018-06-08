//
//  RequestEngine.h
//  HQJFacilitator
//
//  Created by mymac on 16/9/23.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestEngine : NSObject

/**
 POST  不可传参数

 @param urlStr 请求地址
 @param complete 请求成功后返回的内容
 @param errors 请求错误返回的内容
 @param show 是否显示加载框
 */
+(void)HQJBusinessPOSTRequestDetailsUrl:(NSString *)urlStr
                           complete:(void (^)(NSDictionary *dic))complete
                           andError:(void(^)(NSError *error))errors
                            ShowHUD:(BOOL)show;



/**
POST 可传参数

 @param urlStr 请求域名和接口
 @param parameters 参数
 @param complete 请求成功后返回的内容
 @param errors 请求错误返回的内容
 @param show 是否显示加载框
 */
+(void)HQJBusinessPOSTRequestDetailsUrl:(NSString *)urlStr
                         parameters:(id)parameters
                           complete:(void (^)(NSDictionary *dic))complete
                           andError:(void(^)(NSError *error))errors
                            ShowHUD:(BOOL)show;





/**
  GET  不可传参数

 @param urlStr 请求域名和接口
 @param complete  请求成功后返回的内容
 @param errors 请求错误返回的内容
 @param show 是否显示加载框
 */
+ (void)HQJBusinessGETRequestDetailsUrl:(NSString *)urlStr
                               complete:(void (^)(NSDictionary *dic))complete
                               andError:(void(^)(NSError *error))errors
                                ShowHUD:(BOOL)show;

/**
 GET 可传参数

 @param urlStr 请求域名和接口
 @param parameters 参数
 @param complete 请求成功后返回的内容
 @param errors 请求错误返回的内容
 @param show 是否显示加载框
 */
+ (void)HQJBusinessGETRequestDetailsUrl:(NSString *)urlStr
                             parameters:(id)parameters
                               complete:(void (^)(NSDictionary *dic))complete
                               andError:(void(^)(NSError *error))errors
                                ShowHUD:(BOOL)show;

@end
