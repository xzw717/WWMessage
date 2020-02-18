//
//  GoodsManageViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/10.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "GoodsManageViewModel.h"
#import "GoodsManageCell.h"
#import "GoodsManageBottomView.h"
#import "GoodsManageAlertView.h"
#import "GoodsReleaseVC.h"
#import "ReleaseRulesVC.h"

@interface GoodsManageViewModel ()<CustomEmptyViewDelegate>
@property (nonatomic, strong) UITableView *vm_tableView;
//@property (nonatomic, assign) BOOL isContains;
@end
@implementation GoodsManageViewModel
- (instancetype)initWithView:(UITableView *)tableView
{
    self = [super init];
    if (self) {
        self.dataArray = [NSMutableArray array];
        self.vm_tableView = tableView;
    }
    return self;
}

- (void)bottomBlock:(GoodsManageBottomView *)selectBottomView {
    @weakify(self);
    [RACObserve(self, dataArray) subscribeNext:^(NSArray  *x) {
        if (x.count > 0) {
            selectBottomView.hidden = NO;
        } else {
            selectBottomView.hidden = YES;
            
        }
    }];
    [selectBottomView setAllSelect:^(BOOL isAllSelect) {
        @strongify(self);
        [self.dataArray enumerateObjectsUsingBlock:^(GoodsManageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isSelect = isAllSelect;
        }];
        [self.vm_tableView reloadData];
        NSLog(@"%ld",self.dataArray.count);
    }];
    
    [selectBottomView setOperationBlock:^{
        @strongify(self);
    
        if ([self isContains] == YES) {
            
            [GoodsManageAlertView alertViewInitWithTitle:@"是否删除选中的商品" Complete:^{
                NSMutableArray *ary = [NSMutableArray arrayWithArray:self.dataArray];
                for (GoodsManageModel *model in ary) {
                    if (model.isSelect == YES) {
                        [[self mutableArrayValueForKey:@"dataArray"] removeObject:model];
                    }
                }
                RemoveHaveAgreed;
                [self.vm_tableView reloadData];
            }];
        }
      
        
    }];
    [self setBridgeBlock:^(BOOL isSelect) {
        @strongify(self);
        [self.dataArray enumerateObjectsUsingBlock:^(GoodsManageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.isSelect == YES) {
                if (idx == self.dataArray.count - 1) {
                    [selectBottomView setIsMAllSelect:YES];
                }
            } else {
                [selectBottomView setIsMAllSelect:NO];
                *stop = YES;
            }
        }];
        
    }];

}
- (BOOL)isContains {
    __block BOOL isok = NO;
    [self.dataArray enumerateObjectsUsingBlock:^(GoodsManageModel   *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelect == YES) {
            isok = YES;
            *stop = YES;
        }
        if (idx == self.dataArray.count - 1) {
            isok = NO;
        }
    }];
    return isok;
}
- (void)setType:(NSInteger)type {
    _type = type;
    @weakify(self);
    [self requstGoodsStateWithType:type scomplete:^(NSMutableArray<GoodsManageModel *> * _Nonnull modelArray) {
        @strongify(self);
        [[self mutableArrayValueForKey:@"dataArray"] addObjectsFromArray:modelArray];
//        self.dataArray = modelArray;
        [self.vm_tableView reloadData];
    }];
}

- (void)requstGoodsStateWithType:(NSInteger)type scomplete:(void(^)(NSMutableArray <GoodsManageModel *>*modelArray))complete {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableArray *array1 = [NSMutableArray array];

        for (NSInteger i = 0; i < (type * 10); i ++) {
            GoodsManageModel *model= [[GoodsManageModel alloc]init];
            model.titleStr = [NSString stringWithFormat:@"我是第%ld个x商品的名字",i];
//            model.imageUrl = [NSString stringWithFormat:@"%ld",i]
            model.inventory = [NSString stringWithFormat:@"%ld",i];
            model.priceStr = [NSString stringWithFormat:@"%ld.25",i];
            model.sales = [NSString stringWithFormat:@"%ld",i];
            model.isSelect = NO;
            [array1 addObject:model];
            
        }
        !complete ?:complete(array1);
    });
}
- (UITableViewCell *)tableView:(UITableView *)view index:(NSIndexPath *)indx {
    GoodsManageCell *cell = [view dequeueReusableCellWithIdentifier:NSStringFromClass([GoodsManageCell class]) forIndexPath:indx];
    [cell setButtonTitleArray:self.buttonTitle];
    GoodsManageModel *model = self.dataArray[indx.section];
    @weakify(self);
    [cell setCellSelect:^(BOOL isSelect) {
        @strongify(self);
        model.isSelect = isSelect;
        !self.bridgeBlock ? :self.bridgeBlock(isSelect);
    }];
    [cell setModel:model];
    [cell setCellEdit:^{
        GoodsReleaseVC * vc;
        if (self.type == 1) {
            vc = [[GoodsReleaseVC alloc]initWithNavType:HQJNavigationBarWhite buttonStyle:ReleaseButtonStyleSaveAndPublishNow controllerTitle:@"商品编辑"];
        }
        if (self.type == 2 || self.type == 3) {
            vc = [[GoodsReleaseVC alloc]initWithNavType:HQJNavigationBarWhite buttonStyle:ReleaseButtonStyleSaveSubmit controllerTitle:@"商品编辑"];

        }

        [[ManagerEngine currentViewControll].navigationController pushViewController:vc animated:YES];
    }];
    [cell setCellDelete:^(NSString * _Nonnull title) {
        [GoodsManageAlertView alertViewInitWithTitle:[NSString stringWithFormat:@"是否%@选中的商品",title] Complete:^{
            if ([title isEqualToString:@"下架"]) {
                
            } else {
                NSMutableArray *ary = [NSMutableArray arrayWithArray:self.dataArray];
                for (GoodsManageModel *model in ary) {
                    if (model.isSelect == YES) {
                        [[self mutableArrayValueForKey:@"dataArray"] removeObject:model];
                    }
                }
            }
           
            [self.vm_tableView reloadData];
        }];
    }];
    [cell setCellShelve:^{
        
    }];
    if (indx.section == self.dataArray.count - 1) {
        CellLine(cell);
    }
    return cell;
}
- (void)clickEmptyViewbutton {
    [ManagerEngine goodsRelease];

}
@end
