//
//  GoodsManageBottomView.h
//  HQJBusiness
//
//  Created by mymac on 2019/7/10.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^clickSelectBottonView)(BOOL isAllSelect);
typedef void(^clickOperationBottonView)(void);

@interface GoodsManageBottomView : UIView
@property (nonatomic, copy) clickSelectBottonView allSelect;
@property (nonatomic, copy) clickOperationBottonView operationBlock;
@property (nonatomic, assign) BOOL isMAllSelect;
@end

NS_ASSUME_NONNULL_END
