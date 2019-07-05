//
//  MessageViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/1.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageViewModel.h"
#import "MenuManager.h"
#import "MessageTopTAB.h"
@interface MessageViewModel ()
@property (nonatomic, assign) NSInteger topBtnTag;
@end

@implementation MessageViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        @weakify(self);
        self.dataAry = [NSMutableArray arrayWithArray:[self dataArray]];
        [self setTopViewSelectViewModle:^(NSInteger tag) {
            @strongify(self);
            self.topBtnTag = tag;
            if (tag == 0) {
                self.dataAry = [NSMutableArray arrayWithArray:[self dataArray]];
            } else {
                self.dataAry = [NSMutableArray array];
            }
            [self.vm_messageTableView reloadData];
        }];
        
    }
    return self;
}


- (void)messageMenu:(UIView *)view {
    [MenuManager menushowForSender:view withMenuArray:@[@"标记全部已读"]  imageArray:nil textAlignment:NSTextAlignmentCenter doneBlock:^(NSInteger selectedIndex) {
        [self.tabViwe addMessageNotice:self.topBtnTag messageCount:0];
    }];
  
}

- (NSMutableArray *)dataArray {
    NSMutableArray *ary = [NSMutableArray array];
    for (NSInteger i = 0; i < 1000; i++) {
        [ary addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    return ary;
}
@end
