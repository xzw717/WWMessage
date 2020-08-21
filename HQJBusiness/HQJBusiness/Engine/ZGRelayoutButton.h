//
//  ZGRelayoutButton.h
//  HQJBusiness
//
//  Created by 姚 on 2019/6/26.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ZGRelayoutButtonType) {
    ZGRelayoutButtonTypeNomal  = 0,//默认
    ZGRelayoutButtonTypeLeft   = 1,//标题在左
    ZGRelayoutButtonTypeBottom = 2,//标题在下
};

@interface ZGRelayoutButton : UIButton

///图片大小 IBInspectable, 可在xib中设置该属性
@property (assign,nonatomic)IBInspectable CGSize imageSize;
///图片相对于 top/right 的 offset
@property (assign,nonatomic)IBInspectable CGFloat offset;

@property (assign,nonatomic)IBInspectable ZGRelayoutButtonType type;

/// 奖励设置界面使用
@property (nonatomic, strong) NSIndexPath *btnIndexPath;


@end

NS_ASSUME_NONNULL_END
