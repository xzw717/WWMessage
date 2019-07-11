//
//  GoodsManageCell.h
//  HQJBusiness
//
//  Created by mymac on 2019/7/9.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TableViewCell.h"
@class GoodsManageModel;
NS_ASSUME_NONNULL_BEGIN
typedef void(^CellSelectButton)(BOOL isSelect);
typedef void(^CellEditorButton)(void);
typedef void(^CellShelvesButton)(void);
typedef void(^CellDeleteButton)(NSString *title);


@interface GoodsManageCell : ZW_TableViewCell
@property (nonatomic, strong) NSArray <NSString *>*buttonTitleArray;
@property (nonatomic, strong)  GoodsManageModel*model;
/// 选择小按钮点击回调
@property (nonatomic, copy) CellSelectButton cellSelect;
/// 编辑按钮
@property (nonatomic, copy) CellEditorButton cellEdit;
/// 上架按钮
@property (nonatomic, copy) CellShelvesButton cellShelve;
/// 删除按钮
@property (nonatomic, copy) CellDeleteButton cellDelete;

@end

NS_ASSUME_NONNULL_END
