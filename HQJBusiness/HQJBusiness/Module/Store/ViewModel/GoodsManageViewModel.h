//
//  GoodsManageViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2019/7/10.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsManageModel.h"
#import "GoodsManageCustomEmptyView.h"
@class GoodsManageBottomView;
//@class GoodsManageCustomEmptyView;


NS_ASSUME_NONNULL_BEGIN
typedef void(^CellBridgesSelectBlock)(BOOL isSelect);

@interface GoodsManageViewModel : NSObject <CustomEmptyViewDelegate>
/// 出售中等。。。  种类 eg：1，2，3
@property (nonatomic, assign) NSInteger type;
/// 编辑  上架   删除  等功能按钮标题s
@property (nonatomic, strong) NSArray <NSString *>*buttonTitle;

@property (nonatomic, copy) CellBridgesSelectBlock bridgeBlock;

@property (nonatomic, strong) NSMutableArray *dataArray;

- (instancetype)initWithView:(UITableView *)tableView;

- (void)requstGoodsStateWithType:(NSInteger)type scomplete:(void(^)(NSMutableArray <GoodsManageModel *>*modelArray))complete ;

- (UITableViewCell *)tableView:(UITableView *)view index:(NSIndexPath *)indx ;

- (void)bottomBlock:(GoodsManageBottomView *)selectBottomView ;
@end

NS_ASSUME_NONNULL_END
