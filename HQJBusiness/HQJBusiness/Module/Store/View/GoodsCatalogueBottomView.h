//
//  GoodsCatalogueBottomView.h
//  HQJBusiness
//
//  Created by mymac on 2019/7/17.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol GoodsCatalogueBottomViewDelegate <NSObject>

@optional
///  输入框中的目录
- (void)bootomViewWithText:(NSString *)text;
@end
typedef void(^ClickAddButton)(NSString *text);

@interface GoodsCatalogueBottomView : UIView
@property (nonatomic, copy) ClickAddButton textBlock;
@property (nonatomic, weak) id<GoodsCatalogueBottomViewDelegate> bottomDelegate;
@end

NS_ASSUME_NONNULL_END
