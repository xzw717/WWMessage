//
//  XDDetailViewModel.h
//  HQJBusiness
//
//  Created by 姚志中 on 2020/5/18.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XDDetailViewModel : NSObject
+ (NSArray *)firDataArray;
+ (NSArray *)secDataArray;
+ (NSArray *)tempArray;
+ (NSArray *)priceArray;
+ (CGFloat)getStringHeight:(NSString *)text;
+ (CGFloat)getSecCellHeight:(NSArray *)dataArray;
@end

NS_ASSUME_NONNULL_END