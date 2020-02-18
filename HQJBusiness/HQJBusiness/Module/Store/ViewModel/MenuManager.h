//
//  MenuManager.h
//  HQJBusiness
//
//  Created by mymac on 2019/6/30.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^MenuDoneBlock)(NSInteger selectedIndex);

@interface MenuManager : NSObject

+ (void)menushowForSender:(UIView *)view
            withMenuArray:(nullable NSArray *)menuaAry
               imageArray:(nullable NSArray *)imageAry
            textAlignment:(NSTextAlignment)textAlignmentType
                doneBlock:(MenuDoneBlock)block;
@end

NS_ASSUME_NONNULL_END
