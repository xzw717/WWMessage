//
//  MessageViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2019/7/1.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MessageTopTAB;
NS_ASSUME_NONNULL_BEGIN

@interface MessageViewModel : NSObject
@property (nonatomic, copy) void (^topViewSelectViewModle)(NSInteger tag);
@property (nonatomic, strong) NSMutableArray  *dataAry;
@property (nonatomic, strong) UITableView *vm_messageTableView;
@property (nonatomic, strong) MessageTopTAB *tabViwe;
- (void)messageMenu:(UIView *)view ;
@end

NS_ASSUME_NONNULL_END
