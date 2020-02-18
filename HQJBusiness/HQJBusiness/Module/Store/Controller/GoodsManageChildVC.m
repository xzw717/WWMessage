//
//  GoodsManageChildVC.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/9.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "GoodsManageChildVC.h"
#import "GoodsManageCell.h"
#import "GoodsManageBottomView.h"
#import "GoodsManageAlertView.h"

@interface GoodsManageChildVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,CustomEmptyViewDelegate>
@property (nonatomic, strong) NSMutableArray <GoodsManageModel *>*dataArray;
@property (nonatomic, strong) GoodsManageBottomView *selectBottomView;

@end

@implementation GoodsManageChildVC
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArray = [NSMutableArray array];
        self.selectArray = [NSMutableArray array];
     

    }
    return self;
}

- (void)selectNotifion:(NSNotification *)noti {
    if (noti.userInfo) { /// 点个点击选中
        NSIndexPath *index  = noti.userInfo[@"select"];
        if ([self.selectArray containsObject:index]) {
            [self.selectArray removeObject:index];
        } else {
            [self.selectArray addObject:index];
        }
    } else { /// 全选按钮选中
        for (NSInteger i = 0; i < self.dataArray.count; i ++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:i];
            if (![self.selectArray containsObject:index]) {
                [self.selectArray addObject:index];
            }
        }
    }
   
}

- (void)operationNotifion:(NSNotification *)noti {
    NSLog(@"%@",self.selectArray);
}

//- (void)setButtonTitle:(NSArray<NSString *> *)buttonTitle {
//    _buttonTitle = buttonTitle;
//    [self.goodsTableView reloadData];
//}
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}
//- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
//    return [UIImage imageNamed:@"news-NullState"];
//}
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    GoodsManageCustomEmptyView *view = [[GoodsManageCustomEmptyView alloc]init];
    view.customEmptyViewDelegate = self.viewModel;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.goodsTableView.mj_h);
    }];
    return view;

}



//- (void)setGoodsType:(NSInteger)type {
//    [self.viewModel requstGoodsStateWithType:type scomplete:^(NSArray<GoodsManageModel *> * _Nonnull modelArray) {
//        self.dataArray = [modelArray mutableCopy];
//        [self.goodsTableView reloadData];
//        NSDictionary *dict = @{@"type":[NSNumber numberWithInteger:type],
//                               @"count":[NSNumber numberWithInteger:modelArray.count]};
//    }];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.goodsTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataArray = self.viewModel.dataArray;
    self.selectBottomView = [[GoodsManageBottomView alloc]init];
    self.selectBottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.selectBottomView];
    [self.selectBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(ToolBarHeight);
    }];
    [self.viewModel bottomBlock:self.selectBottomView];

    /// 监听数组内容变化
//    @weakify(self);
//    [RACObserve(self.viewModel, dataArray) subscribeNext:^(NSArray  *x) {
//        @strongify(self);
//        if (x.count > 0) {
//            self.selectBottomView.hidden = NO;
//        } else {
//            self.selectBottomView.hidden = YES;
//            
//        }
//    }];
//    [self.selectBottomView setAllSelect:^(BOOL isAllSelect) {
//        @strongify(self);
//        [self.viewModel.dataArray enumerateObjectsUsingBlock:^(GoodsManageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            obj.isSelect = isAllSelect;
//        }];
//        [self.goodsTableView reloadData];
//        NSLog(@"%ld",self.viewModel.dataArray.count);
//    }];
//
//    [self.selectBottomView setOperationBlock:^{
//        @strongify(self);
//        [GoodsManageAlertView alertViewInitWithTitle:@"是否删除选中的商品" Complete:^{
//            NSMutableArray *ary = [NSMutableArray arrayWithArray:self.viewModel.dataArray];
//            for (GoodsManageModel *model in ary) {
//                if (model.isSelect == YES) {
//                    [[self.viewModel mutableArrayValueForKey:@"dataArray"] removeObject:model];
//                }
//            }
//            [self.goodsTableView reloadData];
//        }];
//
//    }];
//    [self.viewModel setBridgeBlock:^(BOOL isSelect) {
//        @strongify(self);
//        [self.viewModel.dataArray enumerateObjectsUsingBlock:^(GoodsManageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if (obj.isSelect == YES) {
//                if (idx == self.viewModel.dataArray.count - 1) {
//                    [self.selectBottomView setIsMAllSelect:YES];
//                }
//            } else {
//                [self.selectBottomView setIsMAllSelect:NO];
//                *stop = YES;
//            }
//        }];
//
//    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return 1;
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    GoodsManageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GoodsManageCell class]) forIndexPath:indexPath];
//    [cell setButtonTitleArray:self.buttonTitle];
//    GoodsManageModel *model = self.dataArray[indexPath.section];
//    @weakify(self);
//    [cell setCellSelect:^(BOOL isSelect) {
//        @strongify(self);
//        model.isSelect = isSelect;
//        !self.bridgeBlock ? :self.bridgeBlock(isSelect);
//    }];
//    [cell setModel:model];
//    [cell setCellEdit:^{
//        
//    }];
//    [cell setCellDelete:^(NSString * _Nonnull title) {
//        
//    }];
//    [cell setCellShelve:^{
//        
//    }];
//    if (indexPath.section == self.dataArray.count - 1) {
//        CellLine(cell);
//    }
//    return cell;
    return [self.viewModel tableView:tableView index:indexPath];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40/3.f;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //圆率
    CGFloat cornerRadius = 10.0;
    //大小
    CGRect bounds = cell.bounds;
    //行数
    NSInteger numberOfRows = [tableView numberOfRowsInSection:indexPath.section];
    
    //绘制曲线
    UIBezierPath *bezierPath = nil;
    
    if (indexPath.row == 0 && numberOfRows == 1) {
        //一个为一组时，四个角都为圆角
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    } else if (indexPath.row == 0) {
        //为组的第一行时，左上、右上角为圆角
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    } else if (indexPath.row == numberOfRows - 1) {
        //为组的最后一行，左下、右下角为圆角
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    } else {
        //中间的都为矩形
        bezierPath = [UIBezierPath bezierPathWithRect:bounds];
    }
    //cell的背景色透明
    cell.backgroundColor = [UIColor clearColor];
    //新建一个图层
    CAShapeLayer *layer = [CAShapeLayer layer];
    //图层边框路径
    layer.path = bezierPath.CGPath;
    //图层填充色，也就是cell的底色
    layer.fillColor = [UIColor whiteColor].CGColor;
    //图层边框线条颜色
    /*
     如果self.tableView.style = UITableViewStyleGrouped时，每一组的首尾都会有一根分割线，目前我还没找到去掉每组首尾分割线，保留cell分割线的办法。
     所以这里取巧，用带颜色的图层边框替代分割线。
     这里为了美观，最好设为和tableView的底色一致。
     设为透明，好像不起作用。
     */
    layer.strokeColor = [UIColor whiteColor].CGColor;
    //将图层添加到cell的图层中，并插到最底层
    [cell.layer insertSublayer:layer atIndex:0];
}
- (UITableView *)goodsTableView {
    if (!_goodsTableView) {
        _goodsTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 44, WIDTH - 20, HEIGHT - 44 - NavigationControllerHeight - ToolBarHeight) style:UITableViewStylePlain];
        _goodsTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _goodsTableView.showsVerticalScrollIndicator = NO;
        _goodsTableView.rowHeight = 530 / 3.f;
        _goodsTableView.delegate = self;
        _goodsTableView.dataSource = self;
        [_goodsTableView registerClass:[GoodsManageCell class] forCellReuseIdentifier:NSStringFromClass([GoodsManageCell class])];
        _goodsTableView.tableFooterView = [UIView new];
        _goodsTableView.emptyDataSetSource = self;
        _goodsTableView.emptyDataSetDelegate = self;
    }
    return _goodsTableView;
}
- (GoodsManageViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[GoodsManageViewModel alloc]initWithView:self.goodsTableView];
    }
    return _viewModel;
}
//- (GoodsManageBottomView *)selectBottomView {
//    
//}
- (GoodsManageBottomView *)selectBottomView {
//    if (!_selectBottomView) {
//        _selectBottomView = [[GoodsManageBottomView alloc]init];
//        _selectBottomView.backgroundColor = [UIColor whiteColor];
//    }
    return _selectBottomView;
}
@end
