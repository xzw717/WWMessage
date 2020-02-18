//
//  ZW_TZImagePickerController.h
//  WuWuMap
//
//  Created by mymac on 2017/8/25.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <TZImagePickerController/TZImagePickerController.h>

@interface HQJTZImagePickerController : TZImagePickerController
@property (nonatomic, copy) void(^cancelButtonClickBlock)();

@end
