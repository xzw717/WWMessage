//
//  BookScoreViewModel.h
//  HQJBusiness
//
//  Created by 姚志中 on 2020/12/16.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BooKScoreModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BookScoreViewModel : NSObject
+ (void)requsetBookScoreList:(NSInteger)page andSize:(NSInteger)size completion:(void (^)(NSString *totalScore, NSArray <BooKScoreModel *> *array))completion;
@end

NS_ASSUME_NONNULL_END
