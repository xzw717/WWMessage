//
//  ScoreGiftView.h
//  HQJBusiness
//
//  Created by 姚志中 on 2020/9/15.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScoreGiftView : UIView

@property(nonatomic,strong)  UITextField  * userNameTextfield;
@property(nonatomic,strong)  UITextField  * scoreNumTextfield;
@property(nonatomic,strong)  UITextField  * authCodeTextfield;
//@property(nonatomic,strong)  UIButton    * getCodeBtn;


@property(nonatomic,strong) UIButton      * submitButton;
@end

NS_ASSUME_NONNULL_END
