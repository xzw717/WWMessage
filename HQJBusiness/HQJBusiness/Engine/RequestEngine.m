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
+(void)HQJBusinessRequestDetailsUrl:(NSString *)urlStr complete:(void (^)(NSDictionary *dic))complete andError:(void(^)(NSError *error))errors ShowHUD:(BOOL)show
{
    [self HQJBusinessRequestDetailsUrl:urlStr parameters:nil complete:complete andError:errors ShowHUD:show];
}

+(void)HQJBusinessRequestDetailsUrl:(NSString *)urlStr parameters:(id)parameters complete:(void (^)(NSDictionary *dic))complete andError:(void(^)(NSError *error))errors ShowHUD:(BOOL)show{
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
    NSString *url = [NSURL URLWithString:urlStr] ? urlStr : [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (complete)
        {
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
            [SVProgressHUD showErrorWithStatus:@"没有找到服务器,请稍候重试"];
            
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
