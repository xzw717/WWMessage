//
//  HQJAlertView.h
//  HQJBusiness
//
//  Created by mymac on 2020/6/19.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^FirstBtnBlock)(void);
typedef void (^TwoBtnBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface HQJAlertView : UIView
@property (nonatomic, copy) FirstBtnBlock firstBlock;
@property (nonatomic, copy) TwoBtnBlock twoBlock;

@end

NS_ASSUME_NONNULL_END
