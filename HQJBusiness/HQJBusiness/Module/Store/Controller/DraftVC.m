//
//  DraftVC.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/9.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "DraftVC.h"
#import "GoodsManageBottomView.h"
@interface DraftVC ()
@property (nonatomic, strong) GoodsManageBottomView *selectBottomView;
@end

@implementation DraftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewModel setButtonTitle:@[@"编辑",@"删除"]];
    [self.viewModel setType:3];
//    self.selectBottomView = [[GoodsManageBottomView alloc]init];
//    self.selectBottomView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.selectBottomView];
//    [self.selectBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(ToolBarHeight);
//    }];
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
//
//    }];
//    [self.selectBottomView setOperationBlock:^{
//        @strongify(self);
//        NSMutableArray *ary = [NSMutableArray arrayWithArray:self.viewModel.dataArray];
//        for (GoodsManageModel *model in ary) {
//            if (model.isSelect == YES) {
//                [self.viewModel.dataArray removeObject:model];
//            }
//        }
//        [self.goodsTableView reloadData];
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
@end
