//
//  ToolViewModel.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/1.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ToolViewModel.h"
#import "ToolCell.h"
#import "MyViewController.h"
#define tableViewSectionHeight 40.f

#define tableViewSectionSpace 53/3.f

@interface ToolViewModel ()
@property (nonatomic,strong)UIViewController *superVC;
@end

@implementation ToolViewModel
- (instancetype)initWithViewContoller:(id)object
{
    self = [super init];
    if (self) {
        self.superVC = object;
    }
    return self;
    
    
}

- (UIView *)sectionViewForCell:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(tableViewSectionSpace, 0, 200, tableViewSectionHeight)];
    titleLabel.text = self.sectionArray[section];
    titleLabel.textColor = [ManagerEngine getColor:@"606266"];
    [view addSubview:titleLabel];
    return view;
}
#pragma mark --- 剥离控制器中的cell
- (UITableViewCell *)cellManageWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToolCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ToolCell class]) forIndexPath:indexPath];
    cell.itemAry = [self cellDataArray][indexPath.section];
    [cell setClickItemblock:^(NSString * _Nonnull title) {
        MyViewController *myVc = [[MyViewController alloc]init];
        [self.superVC.navigationController pushViewController:myVc animated:YES];
        NSLog(@"你点击了：%@",title);
    }];
    [cell setLongClickItemblock:^(NSArray * _Nonnull array) {
        NSMutableArray *itemArray = [NSMutableArray arrayWithArray:ToolItem];
        NSLog(@"你长按了：%@ itemArray = %@",array,itemArray);
        if ([itemArray containsObject:array]) {
            [itemArray removeObject:array];
        }else{
            [itemArray addObject:array];
        }
        [FileEngine storeToolArray:itemArray];
        
    }];
    return cell;
    
}

- (void)selectCellForIndex:(NSIndexPath *)index {
    MyViewController *myVc = [[MyViewController alloc]init];
    [self.superVC.navigationController pushViewController:myVc animated:YES];
    
//    NSArray *ary = self.sectionArray[index.section];
//    UIViewController *viewController;
//    if ([ary.lastObject isEqualToString:@"交易数据"]) {
//        viewController = [[DetailViewController alloc]init];
//    } else if ([ary.lastObject isEqualToString:@"订单管理"]) {
//        viewController = [[OrderManageVC alloc]init];
//    } else if ([ary.lastObject isEqualToString:@"商品管理"]) {
//        viewController = [[GoodsManageVC alloc]init];
//    }
//    [self.storeViewModel_self.navigationController pushViewController:viewController animated:YES];
}

- (NSArray *)cellDataArray {
    if (!_cellDataArray) {
        _cellDataArray =@[@[@[@"商品评价",@"tool_icon_evaluate"],@[@"商品置顶",@"tool_icon_top"],@[@"店铺推荐",@"tool_icon_top"],@[@"收银系统",@"tool_icon_recommend"]],
                     @[@[@"优惠券",@"tool_icon_coupon"],@[@"红包",@"tool_icon_redenvelopes"]],
                     @[@[@"经营有道",@"tool_icon_manage"],@[@"流量手册",@"tool_icon_flow"],@[@"电子发票",@"tool_icon_invoice"],@[@"智能客服",@"tool_icon_service"]]];
    }
    return _cellDataArray;
}

- (NSArray *)sectionArray {
    if (!_sectionArray) {
        _sectionArray = @[@"商品",@"营销推广",@"开店宝典"];
    }
    return _sectionArray;
}

@end
