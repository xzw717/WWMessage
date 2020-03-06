//
//  MineViewModel.h
//  HQJBusiness
//
//  Created by 姚 on 2019/7/2.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ UploadRequestMgrUploadResultBlock) (NSInteger successNum , NSInteger failNum);

@interface UploadImageViewModel : NSObject<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/// 返回图片，未上传
- (void)uploadImageWithImageType:(UIViewController *)vc completion:(void (^)(UIImage *))completion;
/// 直接上传图片
- (void)uploadImageWithImageType:(UIViewController *)vc andImageType:(NSInteger)type completion:(void (^)(NSString *))completion;


@property (nonatomic , strong) UploadRequestMgrUploadResultBlock uploadResultBlock;

/**
 *  上传附件，model中的imagedata必需有值
 *
 *  @param images NSArray< UIImage *>
 *  @param uploadResultBlock 执行队列结束后的结果统计
 */
- (void)uploadImages:(NSArray *)images andImageType:(NSInteger)type uploadResultBlock:(UploadRequestMgrUploadResultBlock)uploadResultBlock;

@end

NS_ASSUME_NONNULL_END
