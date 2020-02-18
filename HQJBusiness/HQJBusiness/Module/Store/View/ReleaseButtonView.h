//
//  ReleaseButtonView.h
//  HQJBusiness
//
//  Created by mymac on 2019/7/16.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReleaseButtonViewDelegate <NSObject>

@optional

/**
 发布按钮代理
 */
- (void)clickRealeaseBtn;

/**
 保存按钮代理
 */
- (void)clickSaveBtn;
@end

NS_ASSUME_NONNULL_BEGIN

/**
 按钮的风格
 */
typedef NS_ENUM(NSInteger,ReleaseButtonStyle) {
    /// 立即发布
    ReleaseButtonStylePublishNow ,
    /// 保存并提交
    ReleaseButtonStyleSaveSubmit ,
    /// 保存草稿和立即发布
    ReleaseButtonStyleSaveAndPublishNow
};
typedef void(^ClickRealeaseViewBtn)(void);
@interface ReleaseButtonView : UIView
@property (nonatomic, weak) id<ReleaseButtonViewDelegate> releaseButtonDelegate;
/// 发布按钮回调
@property (nonatomic, copy) ClickRealeaseViewBtn clickRealeaseBtnBlock;
/// 保存按钮回调
@property (nonatomic, copy) ClickRealeaseViewBtn clickSaveBtnBlock;

- (instancetype)initWithReleaseButtonStyle:(ReleaseButtonStyle)style;

@end

NS_ASSUME_NONNULL_END
