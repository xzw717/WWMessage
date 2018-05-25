//
//  ChangeTradePswViewController.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/22.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_ViewController.h"
#import "JKCountDownButton.h"
#import "NewTradePasswordViewController.h"

@interface ChangeTradePswViewController : ZW_ViewController

@property (nonatomic,strong)ZW_ChangeFigureColorLabel *mobileLabel;

@property (nonatomic,strong)ZW_TextField *verificationCodeTextField;

@property (nonatomic,strong)JKCountDownButton *getCodeButton;

@property (nonatomic,strong)UIButton *nextButton;

@property (nonatomic,strong)NSString *pswTypeStr;

-(void)initializeTheView;

-(void)getcodeRequst:(BOOL)isGet;
@end
