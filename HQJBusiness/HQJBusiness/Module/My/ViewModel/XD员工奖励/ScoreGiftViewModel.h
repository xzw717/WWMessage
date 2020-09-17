//
//  ScoreGiftViewModel.h
//  HQJBusiness
//
//  Created by 姚志中 on 2020/9/15.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScoreGiftViewModel : NSObject

@property (nonatomic,copy) NSString * phoneNumer;
@property (nonatomic,copy) NSString * authCode;
@property (nonatomic,copy) NSString * score;

@property (nonatomic, strong, readonly) RACSignal  *codeBtnEnable;
@property (nonatomic, strong, readonly) RACCommand *codeBtnCommand;

@property (nonatomic,strong,readonly) RACSignal  *summitBtnEnable;
@property (nonatomic,strong,readonly) RACCommand *summitBtnCommand;

@end

NS_ASSUME_NONNULL_END
