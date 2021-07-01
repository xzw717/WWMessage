//
//  OrderBaseVC.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/26.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderBaseVC.h"
#import "OrderViewModel.h"
#import "OrderOneCell.h"
#import "OrderModel.h"
#import "OrderTwoCell.h"
#import "OrderTableViewHeader.h"
#import "OrderTableViewCell.h"
#import "OrderTableViewFooterView.h"
#import "HQJBusinessAlertView.h"
#import "OrderListTableViewFootView.h"
@interface OrderBaseVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate>
@property (nonatomic, strong) OrderViewModel *viewModel;
@property (nonatomic, strong) NSString *typeStr;
@end

@implementation OrderBaseVC


- (void)requstType:(NSString *)type andPage:(NSString *)page {
    self.typeStr = type;
    [self.viewModel orderRequstWithPage:[page integerValue] andType: [type integerValue] andReturnBlock:^(NSArray *sender) {
        if (0 == [page integerValue]) {
            [self.listArray  removeAllObjects];
            [self.listArray addObjectsFromArray:sender];
            self.page  = self.listArray.count;

        } else {
            if (sender.count == 0 ) {
                
                [SVProgressHUD showErrorWithStatus:@"没有更多数据了"];
            } else {
                [self.listArray addObjectsFromArray:sender];
                self.page  = self.listArray.count;

            }
        }

        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];

    }];
    
    
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - NavigationControllerHeight - 44) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.rowHeight = S_RatioW(99.61);
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [_tableView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:NSStringFromClass([OrderTableViewCell class ])];
        [_tableView registerClass:[OrderTwoCell class] forCellReuseIdentifier:NSStringFromClass([OrderTwoCell class ])];

    }
    _tableView.contentInset = UIEdgeInsetsZero;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self requstType:_type andPage:@"0"];
        
        
    }];
    
    _tableView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requstType:_type andPage:[NSString stringWithFormat:@"%ld",(long)_page]];
    }];
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _page = 0;
    _listArray = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    @weakify(self);
    self.viewModel.ErrorBlock = ^(NSString *error) {
        @strongify(self);
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    };

}


- (CGFloat)orderNoteHeight:(NSString *)text {
//    CGFloat w = WIDTH - 15 * 2;
//    CGSize labelsize  = [text
//                         boundingRectWithSize:CGSizeMake(w, CGFLOAT_MAX)
//                         options:NSStringDrawingUsesLineFragmentOrigin
//                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.f weight:UIFontWeightMedium]}
//                         context:nil].size;
//    HQJLog(@"%f",labelsize.height + 11);
    

        CGFloat width = WIDTH - 15 * 2;
     
     
     
        NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineSpacing = 6.0;
        
        NSDictionary * dict = @{NSFontAttributeName:[UIFont systemFontOfSize:10.5],
                                NSParagraphStyleAttributeName:paragraph};
        
//        NSAttributedString * attribute = [[NSAttributedString alloc]
//                                          initWithString:text attributes:dict];
        //一定要先确定宽度，再根据宽度和字体计算size
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
  
    
    return ceil(size.height);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listArray.count;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    OrderModel *model = self.listArray[section];
  
    return 1 ;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"cellid";
    OrderTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
       cell = [[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    OrderModel *model = self.listArray[indexPath.section];
    cell.orderDate = [NSString stringWithFormat:@"%ld",(long)model.date];
//    if (model.type == 1) {
//        cell.orderGoodsModel = model.goodslist[indexPath.row];
//
//    } else {
        cell.orderModel = model;
//    }

    return cell;

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 53.f;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    OrderModel *model = self.listArray[section];
//    if ( model.remark && ![model.remark isEqualToString:@"(null)"]) {
//        return 65 + [self orderNoteHeight:model.remark] + 20 + 20;
//    } else if (model.usedate) {
//        return 65.f + 20 ;
//    } else {
        return 44.f + 20.f;
//    }
//    if (model.usedate) return 65.f +[self orderNoteHeight:@"备注：撒奇偶的分红阿斯顿发哈就开始对伐啦撒京东方了困就阿里斯顿会计分录静安寺大佛普恶趣味埃里克多少积分克拉斯酒店分类卡撒京东方拉开决胜巅峰"];
//
//    return 44.f;
//    return 65.f +[self orderNoteHeight:@"备注：撒奇偶的分红阿斯顿发哈就开始对伐啦撒京东方了困就阿里斯顿会计分录静安寺大佛普恶趣味埃里克多少积分克拉斯酒店分类卡撒京东方拉开决胜巅峰"];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *headerID = @"OrderTableViewHeader%ld";
    OrderModel *model = self.listArray[section];

    OrderTableViewHeader *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    if (!headerView) {
        headerView = [[OrderTableViewHeader alloc]initWithReuseIdentifier:headerID];
    }
    [headerView setState:model.state orderNumber:model.nid];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    static NSString *footerViewID = @"OrderTableViewFooterView%ld";
    OrderModel *model = self.listArray[section];
    
    OrderListTableViewFootView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerViewID];
    if (!footerView) {
        footerView = [[OrderListTableViewFootView alloc]initWithReuseIdentifier:footerViewID];
    }
//   __block NSInteger allCount = 0;
//    [model.goodslist enumerateObjectsUsingBlock:^(GoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        allCount = allCount + obj.goodscount;
//    }];
//    footerView.contactBuyerBlock = ^{
//        [OrderViewModel requestCustomerInformationWith:model.userid complete:^(NSString *mobile, NSString *realname) {
//            HQJBusinessAlertView * alertView = [[HQJBusinessAlertView alloc]initWithisWarning:NO];
//            //    [alertView zw_showAlertWithContent];
//            [alertView zw_showAlertWithName:realname mobile:mobile];
//        }];
//      
//       
//    };
//    [footerView setfootOrderModel:model count:allCount  isUseDate:model.usedate ? YES : NO];
//    [footerView setTimer:model.date usedate:model.usedate count:allCount allPrice:model.price];
    footerView.model = model;
    return footerView;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"brokenNetwork"];
}
//空白页点击事件
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    [self requstType:_type andPage:@"1"];
    
}

- (OrderViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[OrderViewModel alloc]init];
    }
    return _viewModel;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    OrderModel *model = self.listArray[indexPath.section];
//    if (model.type == 1) {
        !self.selectRowBlock ? : self.selectRowBlock(model);
//    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
