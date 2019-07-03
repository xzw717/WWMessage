//
//  MenuManager.m
//  HQJBusiness
//
//  Created by mymac on 2019/6/30.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MenuManager.h"
#import "HQJMenu.h"
#import "MenuModel.h"

#define StoreMenuWidth  130.f;
#define StoreMenuRowHeight  57.f;
#define StoreMenuIconMargin  16.4f;
#define StoreMenuTextMargin  10.f;
#define StoreMenuFont  [UIFont systemFontOfSize:16.f];
#define StoreMenuSeparatorInset  UIEdgeInsetsMake(0, 40, 0, 0);

@implementation MenuManager
+ (void)menushowForSender:(UIView *)view
            withMenuArray:(NSArray *)menuaAry
               imageArray:(NSArray *)imageAry
            textAlignment:(NSTextAlignment)textAlignmentType
                doneBlock:(MenuDoneBlock)block {
    HQJPopMenuConfiguration *configuration = [HQJPopMenuConfiguration defaultConfiguration];
    configuration.menuWidth = StoreMenuWidth;
    configuration.menuRowHeight = StoreMenuRowHeight;
    configuration.menuIconMargin = StoreMenuIconMargin;
    configuration.menuTextMargin = StoreMenuTextMargin;
    configuration.textFont = StoreMenuFont;
    configuration.separatorInset = StoreMenuSeparatorInset;
    configuration.textAlignment = textAlignmentType;
    [HQJMenu showForSender:view withMenuArray:menuaAry imageArray:imageAry configuration:configuration doneBlock:^(NSInteger selectedIndex) {
        !block ? : block(selectedIndex);
    } dismissBlock:^{
        
    }];
}
@end
