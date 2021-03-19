//
//  RequestEngine.m
//  HQJFacilitator
//
//  Created by mymac on 16/9/23.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "RequestEngine.h"
#import "AFNetworkActivityIndicatorManager.h"

static AFHTTPSessionManager *httpManager = nil;

@implementation RequestEngine

+ (void)HQJBusinessPOSTRequestDetailsUrl:(NSString *)urlStr complete:(void (^)(NSDictionary *dic))complete andError:(void(^)(NSError *error))errors ShowHUD:(BOOL)show {
    [self HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:nil complete:complete andError:errors ShowHUD:show];
}

+ (void)HQJBusinessPOSTRequestDetailsUrl:(NSString *)urlStr parameters:(id)parameters complete:(void (^)(NSDictionary *dic))complete andError:(void(^)(NSError *error))errors ShowHUD:(BOOL)show {
    if (show == YES) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showWithStatus:@"加载中..."];
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[AFHTTPSessionManager manager].operationQueue cancelAllOperations];
    AFHTTPSessionManager *manager = [self getAFManager];
    manager.requestSerializer.timeoutInterval = 30.f;
    //    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    //检查地址中是否有中文
//    NSString *url = [NSURL URLWithString:urlStr] ? urlStr : [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:parameters];
    HQJLog(@"hashCode\n%@",HashCode);
    if(parameters) if([ManagerEngine isHash:urlStr parameters:parameters]) [parameter setValue:[ManagerEngine hashCodeStr] forKey:@"hash"];
//    NSLog(@"HashCode = %@ parameter = %@ parameters = %@",HashCode,parameter,parameters);
    [manager POST:urlStr parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (complete) {
            if (show == YES) {
                [SVProgressHUD dismiss];
            }
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            complete(responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (errors) {
            errors (error);
        }
        if ([error.userInfo[@"NSLocalizedDescription"]isEqualToString:@"似乎已断开与互联网的连接。"]) {
            [SVProgressHUD showErrorWithStatus:@"没网了，请检查网络连接后重试"];
            
        } else  if([error.userInfo[@"NSLocalizedDescription"]isEqualToString:@"The request timed out."]) {
            [SVProgressHUD showErrorWithStatus:@"请求超时,请稍候重试"];
            
        } else if ([error.userInfo[@"NSLocalizedDescription"]isEqualToString:@"JSON text did not start with array or object and option to allow fragments not set."]){
            //            [SVProgressHUD showErrorWithStatus:@""];
            
        } else {
            
        }
        
        HQJLog(@"Error:%@",error);
        
    }];
}

+ (void)HQJBusinessGETRequestDetailsUrl:(NSString *)urlStr complete:(void (^)(NSDictionary *dic))complete andError:(void(^)(NSError *error))errors ShowHUD:(BOOL)show {
    [self HQJBusinessGETRequestDetailsUrl:urlStr parameters:nil complete:complete andError:errors ShowHUD:show];
}


+ (void)HQJBusinessGETRequestUrl:(NSString *)urlStr parameters:(id)parameters complete:(void (^)(NSDictionary *))complete andError:(void (^)(NSError *))errors ShowHUD:(BOOL)show {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:parameters];
        NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        if (show == YES) {
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];

                [SVProgressHUD showWithStatus:@"加载中..."];
            }
        NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer]requestWithMethod:@"POST" URLString:urlStr parameters:nil error:nil];
        [request addValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
        request.timeoutInterval= 30;
        [request setHTTPBody:data];
        HQJLog(@"HTTPBody:%@",request.HTTPBody);

        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                          @"text/html",
                                                                          @"text/json",
                                                                          @"text/plain",
                                                                          @"text/javascript",
                                                                          @"text/xml",
                                                                          @"image/jpeg",
                                                                          @"image/png",
                                                                          @"application/octet-stream"]];
        manager.responseSerializer = responseSerializer;


        [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
           if (responseObject)  {
               if (show == YES) {
                   [SVProgressHUD dismiss];
               }
               [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
               NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
               NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
               NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];

               !complete?:complete(jsonDict);
                  
           }
            if (error) {
                !errors ?:errors(error);
            }
        }] resume];
    
}
+ (void)HQJBusinessGETRequestDetailsUrl:(NSString *)urlStr parameters:(id)parameters complete:(void (^)(NSDictionary *dic))complete andError:(void(^)(NSError *error))errors ShowHUD:(BOOL)show {
    if (show == YES) {
//        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];

        [SVProgressHUD showWithStatus:@"加载中..."];
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[AFHTTPSessionManager manager].operationQueue cancelAllOperations];
    AFHTTPSessionManager *manager = [self getAFManager];
    manager.requestSerializer.timeoutInterval = 180;
    //    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    //检查地址中是否有中文
    //    NSString *url = [NSURL URLWithString:urlStr] ? urlStr : [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:parameters];
    HQJLog(@"hashCode\n%@",HashCode);
    if(parameters) if([ManagerEngine isHash:urlStr parameters:parameters]) [parameter setValue:[ManagerEngine hashCodeStr] forKey:@"hash"];
//    NSLog(@"HashCode = %@ parameter = %@ parameters = %@",[ManagerEngine hashCodeStr],parameter,parameters);
    [manager GET:urlStr parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (complete)  {
            if (show == YES) {
                [SVProgressHUD dismiss];
            }
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            complete(responseObject);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (errors) {
            errors (error);
        }
        if ([error.userInfo[@"NSLocalizedDescription"]isEqualToString:@"似乎已断开与互联网的连接。"]) {
            [SVProgressHUD showErrorWithStatus:@"没网了，请检查网络连接后重试"];
            
        } else  if([error.userInfo[@"NSLocalizedDescription"]isEqualToString:@"The request timed out."]) {
            [SVProgressHUD showErrorWithStatus:@"请求超时,请稍候重试"];
            
        } else if ([error.userInfo[@"NSLocalizedDescription"]isEqualToString:@"JSON text did not start with array or object and option to allow fragments not set."]){
            //            [SVProgressHUD showErrorWithStatus:@""];
            
        } else {
            
        }
        
        HQJLog(@"Error:%@",error);
    }];
  
}



+ (AFHTTPSessionManager *)getAFManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        httpManager = [AFHTTPSessionManager manager];
        httpManager.responseSerializer = [AFJSONResponseSerializer serializer];//设置返回数据为json
        httpManager.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
        //httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];//设置返回NSData 数据
        httpManager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        httpManager.requestSerializer.timeoutInterval= 30;
        httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                                      @"text/html",
                                                                                      @"text/json",
                                                                                      @"text/plain",
                                                                                      @"text/javascript",
                                                                                      @"text/xml",
                                                                                      @"image/jpeg",
                                                                                      @"image/png",
                                                                                      @"application/octet-stream",
                                                                                      @"image/*"]];
    });
    
    return httpManager;
}

@end
