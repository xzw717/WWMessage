//
//  PersonInfoImageCell.h
//  HQJBusiness
//
//  Created by 姚 on 2019/7/5.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger , CellStyle) {
    CellStyleImage = 0,   /// 默认 小图
    CellStyleBigImage,      /// 大图
};
@interface PersonInfoImageCell : ZW_TableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, assign) CellStyle style;
@end

NS_ASSUME_NONNULL_END
