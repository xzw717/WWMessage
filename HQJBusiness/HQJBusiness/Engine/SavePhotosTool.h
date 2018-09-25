//
//  SavePhotosTool.h
//  保存图片到自定义相簿中
//
//  Created by 徐流洋 on 2017/6/21.
//  Copyright © 2017年 南京南达尚诚软件科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface SavePhotosTool : NSObject

/** 单例模式 */
+ (instancetype)shareManager;

/** 判断授权状态 */
+ (void)judgePHAuthorizationStatus:(UIImage *)image;

@end
