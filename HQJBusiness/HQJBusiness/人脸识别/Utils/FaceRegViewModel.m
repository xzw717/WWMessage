//
//  MyViewModel.m
//  WuWuMap
//
//  Created by mymac on 2017/3/9.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "FaceRegViewModel.h"

@implementation FaceRegViewModel

+ (void)uploadImage:(NSString *)url body:(NSData *)body completion:(void(^)(id dict))completion{

    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer]requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    [request addValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 90;
    [request setHTTPBody:body];
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

        if (!error) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                NSData *resData = (NSData *)responseObject;
                NSDictionary * dic =[NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:&error];
                ! completion ? : completion(dic);
            } else {

            }
        }else{
            NSLog(@"error = %@",error);
        }
        
    }] resume];
}
+ (void)faceRegImage:(NSString *)url body:(NSData *)body completion:(void(^)(id dict))completion{

    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer]requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    [request addValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 90;
    [request setHTTPBody:body];
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
        if (!error) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                NSData *resData = (NSData *)responseObject;
                NSDictionary * dic =[NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:&error];
                ! completion ? : completion(dic);
            } else {
                
            }
        }else{
            NSLog(@"error = %@",error);
        }
        
    }] resume];
}
@end
