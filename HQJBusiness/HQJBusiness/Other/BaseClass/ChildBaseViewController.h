//
//  ChildBaseViewController.h
//  WuWuMap
//
//  Created by mymac on 2017/2/27.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildNav.h"
typedef void(^BackButtonBlock)(void);

@interface ChildBaseViewController : UIViewController

@property (nonatomic,copy)BackButtonBlock back;


/**
 *标题
 */
@property (nonatomic,strong) NSString * titleString;

@property (nonatomic,assign) BOOL isNavBackgroundColorAlpha;
@property (nonatomic,assign) BOOL isBack;
@property (nonatomic,strong) ChildNav * navView;

@end
