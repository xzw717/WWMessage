//
//  HintView.h
//  HQJBusiness
//
//  Created by 姚 on 2019/6/25.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HintView : UIView

@property (nonatomic,strong)UIButton *sureButton;

-(instancetype)initWithFrame:(CGRect)frame withTopic:(NSString *)topic andSureTitle:(NSString *)sureTitle cancelTitle:(NSString *)cancelTitle;

/**
 删除子视图移除本视图
 */
-(void)dismssView;

@end

NS_ASSUME_NONNULL_END
