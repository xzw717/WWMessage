//
//  StoreViewModel.h
//  HQJBusiness
//
//  Created by mymac on 2019/6/25.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreViewModel : NSObject
@property (nonatomic, strong) NSMutableArray *modelAry;
@property (nonatomic, strong) NSMutableArray *titleAry;
@property (nonatomic, strong) UITableView *vm_storetableView;
/// 初始化方法
- (instancetype)initWithTargetObjct:(id)object;
/// 导航点击更多菜单
- (void)navMenu:(UIView *)view;
/// cell 的分离
- (UITableViewCell *)cellManageWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
/// cell 点击方法
- (void)selectCellForIndex:(NSIndexPath *)index ;
@end

NS_ASSUME_NONNULL_END
