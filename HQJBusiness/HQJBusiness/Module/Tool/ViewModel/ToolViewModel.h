//
//  ToolViewModel.h
//  HQJBusiness
//
//  Created by 姚 on 2019/7/1.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToolViewModel : NSObject
@property (nonatomic, strong) NSArray *cellDataArray;
@property (nonatomic, strong) NSArray *sectionArray;
/// 初始化方法
- (instancetype)initWithViewContoller:(id)object;
/// cell section view
- (UIView *)sectionViewForCell:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
/// cell 的分离
- (UITableViewCell *)cellManageWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
