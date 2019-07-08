//
//  NewMessageImageView.h
//  HQJBusiness
//
//  Created by mymac on 2019/6/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM (NSInteger , redViewStyle){
   /// 默认小红点
    redViewStyleDefault ,
    /// 有数字的小红点
    redViewStyleNumber,
    /// 有数字的更小的小红点
    redViewStyleSmallNumber
};
typedef void(^ClickCustomImage)(void);
@interface NewMessageImageView : UIImageView
@property (nonatomic, copy) ClickCustomImage tapImage;
- (instancetype)initWithHintStyle:(redViewStyle)style;
- (void)setNumbaer:(NSInteger)count;
- (void)hiddeRedView;
@end

NS_ASSUME_NONNULL_END
