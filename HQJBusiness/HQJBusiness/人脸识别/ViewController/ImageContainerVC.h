//
//  ImageContainerVC.h
//  WuWuMap
//
//  Created by 姚 on 2019/8/28.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//此回调为上传成功回调
typedef void (^buttonClickResult)(void);

@interface ImageContainerVC : UIViewController
@property (nonatomic, strong) UIImage *dataImage;
@property (nonatomic, readwrite, copy) buttonClickResult sureResult;

@end

NS_ASSUME_NONNULL_END
