//
//  MenuModel.h
//  HQJBusiness
//
//  Created by mymac on 2019/6/30.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuModel : NSObject
@property (nonatomic, strong)NSArray <NSString *>*selectClassName;
@property (nonatomic, strong)NSArray <NSString *>*menuTitleName;
@property (nonatomic, strong)NSArray <NSString *>*menuImageName;
@property (nonatomic, strong) UIViewController *menuSelf;
@property (nonatomic, strong) UIView *menuSelectView;
@property (nonatomic, assign) BOOL isPush;
@end

NS_ASSUME_NONNULL_END
