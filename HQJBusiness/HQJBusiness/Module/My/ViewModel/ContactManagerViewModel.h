//
//  ContactManagerViewModel.h
//  HQJBusiness
//
//  Created by 姚志中 on 2020/5/21.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ContactManagerViewModel : NSObject
+ (void)getContactManagerList:(NSString *)shopid andSignResul:(NSInteger)signResul completion:(void(^)(NSArray <ContactModel *>*list))completion;
@end

NS_ASSUME_NONNULL_END

