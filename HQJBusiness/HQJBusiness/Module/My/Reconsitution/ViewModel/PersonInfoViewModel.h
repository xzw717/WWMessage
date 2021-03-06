//
//  PersonInfoViewModel.h
//  HQJBusiness
//
//  Created by 姚 on 2019/7/4.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonInfoViewModel : NSObject
@property (nonatomic, strong) NSArray *cellDataArray;
/// 初始化方法
- (instancetype)initWithViewContoller:(id)object;
/// cell 的分离
- (UITableViewCell *)cellManageWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
/// cell 点击方法
- (void)selectCellForIndex:(NSIndexPath *)index;
@end

NS_ASSUME_NONNULL_END
