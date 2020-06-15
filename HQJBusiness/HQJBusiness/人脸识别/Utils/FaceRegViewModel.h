//
//  MyViewModel.h
//  WuWuMap
//
//  Created by mymac on 2017/3/9.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FaceRegViewModel : NSObject

+ (void)uploadImage:(NSString *)url body:(NSData *)body completion:(void(^)(id dict))completion;

+ (void)faceRegImage:(NSString *)url body:(NSData *)body completion:(void(^)(id dict))completion;
@end
