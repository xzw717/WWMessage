//
//  AddUnionImageCell.h
//  HQJBusiness
//
//  Created by 姚志中 on 2021/2/3.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^ UploadResultBlock) (id dict);
@interface AddUnionImageCell : ZW_TableViewCell<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, copy) UploadResultBlock uploadResultBlock;
@end

NS_ASSUME_NONNULL_END
