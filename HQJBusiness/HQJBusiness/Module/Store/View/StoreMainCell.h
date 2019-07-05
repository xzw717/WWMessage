//
//  StoreMainCell.h
//  HQJBusiness
//
//  Created by mymac on 2019/6/25.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//




#import "ZW_TableViewCell.h"

typedef NS_ENUM(NSInteger , ItemViewStyle) {
    /// 默认 上面数字，下面文字
    ItemViewStyleDefault = 0,
    /// 上面图片 下面文字
    ItemViewStyleTopImage,
    /// 上面加号按钮，下面文字
    ItemViewStyleAddImage,
     /// 只有加号按钮
    ItemViewStyleOnlyImage
};

@interface ItemView : UIView
@property (nonatomic, assign) ItemViewStyle style;
@end
NS_ASSUME_NONNULL_BEGIN

@interface StoreMainCell : ZW_TableViewCell
@property (nonatomic, strong) NSMutableArray *itemAry;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, assign) ItemViewStyle itemStyle;
@property (nonatomic, strong) void(^clickItemblock)(NSString *title);

- (CGFloat)cellHeight:(NSArray *)ary ;
@end

NS_ASSUME_NONNULL_END
