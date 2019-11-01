//
//  OrderDetailsViewController.m
//  HQJBusiness
//
//  Created by mymac on 2019/5/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderDetailsViewController.h"
#import "OrderDetailsPrintHeaderView.h"
#import "OrderDetailsOneCell.h"
#import "OrderDetailsTwoCell.h"
#import "OrderDetailsThreeCell.h"
#import "OrderDetailsFourCell.h"
#import "OrderDetailsFiveCell.h"
#import "OrderDetailsSixCell.h"
#import "OrderViewModel.h"
#import "HQJBusinessAlertView.h"
#import "OrderModel.h"
#import "GoodsModel.h"
#import "BlueToothVC.h"
#import "JWBluetoothManage.h"
#import "OrderNoteCell.h"
@interface OrderDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>{
    JWBluetoothManage * manage;
}
@property (nonatomic, strong) UITableView *orderDetailsTableView;
@property (nonatomic, strong) OrderDetailsPrintHeaderView *headerView;
@property (nonatomic, strong) OrderModel *dataModel;
@property (nonatomic, strong) NSString *mobileStr;
@property (nonatomic, strong) NSString *nameStr;

@end

@implementation OrderDetailsViewController
- (instancetype)initWithModel:(OrderModel *)model {
    self = [super init];
    if (self) {
        self.dataModel = model;
        manage = [JWBluetoothManage sharedInstance];

    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    @weakify(self);
    [super viewWillAppear:animated];
   
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"订单详情";
    [OrderViewModel requestCustomerInformationWith:self.dataModel.userid complete:^(NSString *mobile, NSString *realname) {
        self.mobileStr = mobile;
        self.nameStr = realname;
        [self.orderDetailsTableView reloadData];
    }];
    [self.view addSubview:self.orderDetailsTableView];
}
- (CGFloat)orderNoteHeight {
    CGFloat w = WIDTH - (15  + 12) * 2;
    CGSize labelsize  = [self.note
                         boundingRectWithSize:CGSizeMake(w, CGFLOAT_MAX)
                         options:NSStringDrawingUsesLineFragmentOrigin
                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f weight:UIFontWeightMedium]}
                         context:nil].size;
    return labelsize.height + 15 + 18 +1 ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.note && ![self.note isEqualToString:@"(null)"] && ![self.note isEqualToString:@""] ) {
        return 4;
    } else {
      return  3;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row != 0) {
        return 65.f;
    } else if (indexPath.section == 3 && indexPath.row != 0) {
        return [self orderNoteHeight];
    } else {
        return 44;

    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 2 ||section == 3) {
        return 2;
    } else {
        
        return self.dataModel.goodslist.count + 2;
        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15.f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 ) {
        if (indexPath.row == 0) {
            OrderDetailsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailsOneCell class])];
            cell.statess = @"用户信息";
            return cell;
        }else {
            
            OrderDetailsTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailsTwoCell class])];
            cell.number = self.mobileStr;
            [cell hiddenLiane:YES];
            @weakify(self);
            [cell setCilckPhone:^{
                @strongify(self);
                HQJBusinessAlertView * alertView = [[HQJBusinessAlertView alloc]initWithisWarning:NO];
                [alertView zw_showAlertWithName:self.nameStr mobile:self.mobileStr];
            }];
            return cell;
        }
        
    } else if (indexPath.section == 1 ) {
        if (indexPath.row == 0) {
            OrderDetailsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailsOneCell class])];
            cell.statess = @"订单信息";
            return cell;
        } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1) {
            OrderDetailsFourCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailsFourCell class])];
            cell.priceStr = self.dataModel.price;
            return cell;
        } else {
            
            OrderDetailsThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailsThreeCell class])];
            GoodsModel *d_mdoel = self.dataModel.goodslist [indexPath.row - 1];
            
            [cell goodsImage:d_mdoel.mainpicture goodsName:d_mdoel.goodsname goodsCount:d_mdoel.goodscount goodsPrice:d_mdoel.goodsprice * d_mdoel.goodscount];
            if (indexPath.row != [tableView numberOfRowsInSection:indexPath.section] - 2) {
                [cell hiddenLiane:YES];
            } else {
                [cell hiddenLiane:NO];
                
            }
            return cell;
        }
    } else if (indexPath.section == 2 ) {
        if (indexPath.row == 0) {
            OrderDetailsFiveCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailsFiveCell class])];
            cell.orderNumberStr = self.dataModel.nid;
            return cell;
        } else {
            OrderDetailsSixCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailsSixCell class])];
            cell.timerStr = self.dataModel.date;
            return cell;
            
        }
        
    } else {
        if (indexPath.row == 0) {
            OrderDetailsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailsOneCell class])];
            cell.statess = @"订单备注";
            return cell;
        }else {
            OrderNoteCell *cell =  [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderNoteCell class])];
            cell.noteLabel.text = [NSString stringWithFormat:@"备注：%@",self.note];
            return cell;
        }
        
    }
    
    
    
    //    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
//    OrderHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([OrderHeaderFooterView class])];
//        if (section == 0) {
//            header.statess = @"用户信息";
//        } else if (section == 1) {
//            header.statess = @"订单信息";
//
//        }
    
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 14, 70, 17)];
//    titleLabel.textColor = [ManagerEngine getColor:@"323232"];
//    titleLabel.font = [UIFont systemFontOfSize:17.f weight:UIFontWeightBold];
//    if (section == 0) {
//        titleLabel.text = @"用户信息";
//    } else if (section == 1) {
//        titleLabel.text = @"用户信息";
//
//    }
    return [UIView new];
}


- (UITableView *)orderDetailsTableView {
    if (!_orderDetailsTableView) {
        _orderDetailsTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, NavigationControllerHeight, WIDTH - 20, HEIGHT - NavigationControllerHeight) style:UITableViewStyleGrouped];
        _orderDetailsTableView.delegate = self;
        _orderDetailsTableView.dataSource = self;
//        _orderDetailsTableView.rowHeight = 44;
        _orderDetailsTableView.showsVerticalScrollIndicator = NO;
        _orderDetailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _orderDetailsTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _orderDetailsTableView.tableHeaderView = self.headerView;
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _orderDetailsTableView.tableFooterView = view;
        [_orderDetailsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [_orderDetailsTableView registerClass:[OrderDetailsOneCell class] forCellReuseIdentifier:NSStringFromClass([OrderDetailsOneCell class])];
        [_orderDetailsTableView registerClass:[OrderDetailsTwoCell class] forCellReuseIdentifier:NSStringFromClass([OrderDetailsTwoCell class])];
        [_orderDetailsTableView registerClass:[OrderDetailsThreeCell class] forCellReuseIdentifier:NSStringFromClass([OrderDetailsThreeCell class])];
        [_orderDetailsTableView registerClass:[OrderDetailsFourCell class] forCellReuseIdentifier:NSStringFromClass([OrderDetailsFourCell class])];
        [_orderDetailsTableView registerClass:[OrderDetailsFiveCell class] forCellReuseIdentifier:NSStringFromClass([OrderDetailsFiveCell class])];
        [_orderDetailsTableView registerClass:[OrderDetailsSixCell class] forCellReuseIdentifier:NSStringFromClass([OrderDetailsSixCell class])];

        [_orderDetailsTableView registerClass:[OrderNoteCell class] forCellReuseIdentifier:NSStringFromClass([OrderNoteCell class])];


    }
    return _orderDetailsTableView;
}
- (OrderDetailsPrintHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[OrderDetailsPrintHeaderView alloc]init];
        _headerView.frame =CGRectMake(0, 0, WIDTH, 54);
        _headerView.states = self.dataModel.state;
        @weakify(self);
        [_headerView setClickPrint:^{
            @strongify(self);
            [self printe];
//                BlueToothVC *vc = [[BlueToothVC alloc]initWithPrintModel:self.dataModel userMobile:self.mobileStr];
//
//                [self.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _headerView;
}

- (void)printe {
    if (manage.stage != JWScanStageCharacteristics) {
        [ProgressShow alertView:self.view Message:@"打印机正在准备中..." cb:nil];
        return;
    }
    JWPrinter *printer = [[JWPrinter alloc] init];
    NSString *str1 = @"物物地图";
    NSString *str2 = @"Wuwu Map";
    NSString *str3 = @"订单详情";
    [printer appendText:str1 alignment:HLTextAlignmentCenter];
    [printer appendText:str2 alignment:HLTextAlignmentCenter];
    [printer appendText:str3 alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleMiddle];
    [printer appendSeperatorLine];
    
    [printer appendText:@"用户信息" alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    [printer appendText:[self.mobileStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]  alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    [printer appendSeperatorLine];
    
    [printer appendText:@"订单详情" alignment:HLTextAlignmentLeft];
    NSInteger icount = 0 ;
    for (GoodsModel *goodsmdoel in self.dataModel.goodslist) {
        [printer appendLeftText:goodsmdoel.goodsname middleText:[NSString stringWithFormat:@"x%ld",(long)goodsmdoel.goodscount] rightText:[NSString stringWithFormat:@"%.2f",goodsmdoel.goodsprice * goodsmdoel.goodscount] isTitle:NO];
        icount = icount + goodsmdoel.goodscount;
        
    }
    
    [printer appendSeperatorLine];
    
    [printer appendTitle:@"总计商品数" value:[NSString stringWithFormat:@"%ld",icount]];
    [printer appendTitle:@"金    额" value:[NSString stringWithFormat:@"%.2f",self.dataModel.price]];
    
    [printer appendSeperatorLine];
    [printer appendTitle:@"订单编号" value:[NSString stringWithFormat:@"%@",self.dataModel.nid]];
    [printer appendTitle:@"下单时间" value:[ManagerEngine reverseSwitchTimer:[NSString stringWithFormat:@"%ld",self.dataModel.date]]];
     if (self.note && ![self.note isEqualToString:@"(null)"] && ![self.note isEqualToString:@""] ) {
         [printer appendText:[NSString stringWithFormat:@"备注：%@",self.note]  alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    }
    [printer appendFooter:@"感谢您选择【物物地图】，欢迎您再次光临!"];
    [printer appendNewLine];
    [printer appendNewLine];
    [printer appendNewLine];
    NSData *mainData = [printer getFinalData];
    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        if (completion) {
            NSLog(@"打印成功");
        }else{
            NSLog(@"写入错误---:%@",error);
        }
    }];
}


@end
