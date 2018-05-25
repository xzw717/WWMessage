//
//  MessageNotificationViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2017/4/17.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageNotificationViewModel.h"
#import "MessageNotificationModel.h"

@implementation MessageNotificationViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.messageArray = [NSMutableArray array];

    }
    return self;
}
- (void)messageRequstpage:(NSInteger)pages state:(ReadingState)state complete:(void(^)(id x))complete error:(void(^)(NSError *error))errors{
    NSString *urlStr = [NSString stringWithFormat:@"%@shopmessage/findShopMessageList.action?memberid=%@&page=%ld&isread=%ld",OrderTest_URL,MmberidStr,(long)pages,(long)state];
    [RequestEngine HQJBusinessRequestDetailsUrl:urlStr complete:^(NSDictionary *dic) {
        NSArray *resultMsgArray = dic[@"resultMsg"];
       
        if (resultMsgArray.count == 0 && pages == 1) {
            self.messageArray = nil;
        }
        for (NSDictionary *resultMsgdic in resultMsgArray) {
            MessageNotificationModel *model = [MessageNotificationModel mj_objectWithKeyValues:resultMsgdic];
            [self.messageArray addObject:model];
        }
        if ( resultMsgArray.count == 0) {
            complete(@"nodata");
        } else {
            complete(@"data");
        }
        
    } andError:^(NSError *error) {
        errors(error);
    } ShowHUD:YES];
}

- (RACSignal *)loadMoreSignal {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        if (self.messagePage == 0) {
            self.messagePage = 1;
        }
        [self messageRequstpage:self.messagePage state:self.messageState complete:^(id x){
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

@end
