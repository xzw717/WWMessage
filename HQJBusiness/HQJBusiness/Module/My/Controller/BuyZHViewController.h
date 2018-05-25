//
//  BuyZHViewController.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/15.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_ViewController.h"
#import "NoticeView.h"
#import "BuyZHViewModel.h"
#import "BonusExchangeModel.h"

@interface BuyZHViewController : ZW_ViewController
@property (nonatomic,strong) NoticeView *titleView ;  // ---- 黄色广告条

@property (nonatomic,strong) BonusExchangeModel *model;  // ---- 商家信息模型

@property (nonatomic,strong) ZW_Label *payerLabel;  // ---- 支付方

@property (nonatomic,strong) ZW_Label *BonusNumerLabel;  // ---- 购买数量

@property (nonatomic,strong) ZW_Label *collectionLabel; // ---- 收款方

@property (nonatomic,strong) ZW_TextField *BonusNumerTextField;  // ---- 积分

@property (nonatomic,strong) UIButton *nextButton ;  // ---- 下一步按钮

-(void)nextBtn;

-(void)setViewframe;
@end
