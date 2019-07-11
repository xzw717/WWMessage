//
//  GoodsManageCustomEmptyView.h
//  HQJBusiness
//
//  Created by mymac on 2019/7/11.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CustomEmptyViewDelegate <NSObject>

@optional

/**
 添加商品按钮点击方法
 */
- (void)clickEmptyViewbutton;
@end
@interface GoodsManageCustomEmptyView : UIView
@property (nonatomic, weak) id <CustomEmptyViewDelegate> customEmptyViewDelegate;
@end

NS_ASSUME_NONNULL_END
