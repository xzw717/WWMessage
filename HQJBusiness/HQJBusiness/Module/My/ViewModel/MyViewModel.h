//
//  MyViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2016/12/13.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyViewModel : NSObject

@property (nonatomic,copy)void(^myrequstBlock)(id sender);
@property (nonatomic,copy)void(^myrequstErrorBlock)(void);

-(void)myRequst;

-(void)jumpVc:(UIViewController *)xzw_self andIndexPath:(NSIndexPath *)xzw_indexPath;

+(void)getHomeBannerBlock:(void(^)(id imageArray))sender;
@end
