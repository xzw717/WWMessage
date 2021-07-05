//
//  OrderDetailPageViewController.m
//  WuWuMap
//
//  Created by Ethan on 2021/6/21.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderDetailPageViewController.h"
#import "OrderDeatilBigTitleCell.h"
#import "OrderDetailDefaultCell.h"
//#import "OrderListShopModel.h"
#import "OrderDetailGoodsCell.h"
#import "OrderModel.h"
#import "HQJBusinessAlertView.h"
#import "OrderViewModel.h"
#import "JWBluetoothManage.h"
#import "OrderDetailsPrintHeaderView.h"
#import "OrderViewModel.h"
@interface OrderDetailPageViewController () <UITableViewDelegate,UITableViewDataSource>{
    JWBluetoothManage * manage;
}
@property (nonatomic, strong) UITableView *orderDetailTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *mobileStr;
@property (nonatomic, strong) NSString *nameStr;
@property (nonatomic, strong)  NSString *couponTypeNam;
@property (nonatomic, strong) OrderDetailsPrintHeaderView *headerView;
@end

@implementation OrderDetailPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ManagerEngine getColor:@"f2f2f2"];
    //    [self setNavStyle];
    [self.view addSubview:self.orderDetailTableView];
    self.zw_title = @"订单详情";
    @weakify(self);
    [OrderViewModel requestCustomerInformationWith:self.orderDetailModel.userid complete:^(NSString *mobile, NSString *realname) {
        @strongify(self)
        self.mobileStr = mobile;
        self.nameStr = realname;
        NSMutableArray *aryMobile =  [NSMutableArray arrayWithArray:self.dataArray[0]];
        [aryMobile replaceObjectAtIndex:1 withObject:@{mobile:@"联系买家"}];
        [self.dataArray replaceObjectAtIndex:0 withObject:aryMobile];
        [self.orderDetailTableView reloadData];
    }];
    if (self.orderDetailModel.couponsid) {
        [OrderViewModel requestCouponTypeWithid:self.orderDetailModel.couponsid complete:^(NSString *couponType) {
            @strongify(self)
            self.couponTypeNam = couponType;
            [self.orderDetailTableView reloadData];
            
        }];
    }
    
}

//- (void)setNavStyle {
//    @weakify(self);
//    [self.navView.backButton mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15.f);
//    }];
//    self.navView.backButton.titleLabel.font = [UIFont systemFontOfSize:NewProportion(48.f)];
//    [self.navView.backButton setTitle:@"关闭" forState:UIControlStateNormal];
//    [self.navView.backButton setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
//    [self.navView.backButton setImage:nil forState:UIControlStateNormal];
//    [self setBack:^{
//        @strongify(self);
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }];
//    self.titleString = @"订单详情";
//
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.orderDetailModel.goodslist || self.orderDetailModel.goodslist.count == 0) {
        return [self.dataArray[section] count];
        
    } else {
        if (section == 1) {
            return self.orderDetailModel.goodslist.count + 1;
            
        } else {
            return [self.dataArray[section] count];
        }
    }
    
    //    if (section == 0) {
    //        return 2;
    //    } else if (section == 1) {
    //    } else if (section == 2) {
    //        return 6;
    //    } else if (section == 3) {
    //        return 1;
    //    } else  {
    //        return 6;
    //    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (!self.orderDetailModel.goodslist || self.orderDetailModel.goodslist.count == 0) {
        return 60.f;
        
    } else {
        if (indexPath.section == 1) {
            if (indexPath.row == 0 ) {
                return 60.f;
            } else {
                return NewProportion(283.f);
                
            }
        } else if (indexPath.section == self.dataArray.count - 1) {
            if (indexPath.row == [self.dataArray[indexPath.section] count] - 1) {
                if (self.orderDetailModel.remark && ![self.orderDetailModel.remark isEqualToString:@""]) {
                    return 60.f + [self orderNoteHeight:self.orderDetailModel.remark];
                    
                } else {
                    return 60.f;

                }
            } else {
                return 60.f;

            }
        } else {
            return 60.f;
            
        }
    }
    
}
- (CGFloat)orderNoteHeight:(NSString *)text {
    
    CGFloat width = WIDTH / 2;
    
    
    
    NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 6.0;
    
    NSDictionary * dict = @{NSFontAttributeName:[UIFont systemFontOfSize:10.5],
                            NSParagraphStyleAttributeName:paragraph};
    
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    
    return ceil(size.height);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.orderDetailModel.goodslist || self.orderDetailModel.goodslist.count == 0) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                OrderDeatilBigTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDeatilBigTitleCell class]) forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.titleStr = @"商家信息";
                
                return cell;
            } else {
                OrderDetailDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailDefaultCell class]) forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell cellWithtype:isCallShop];
                [cell dataWithDictionary:self.dataArray[indexPath.section][indexPath.row]];
                
                return cell;
            }
        } else if (indexPath.section == self.dataArray.count - 3){
            OrderDetailDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailDefaultCell class]) forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell dataWithDictionary:self.dataArray[indexPath.section][indexPath.row]];
            
            if (indexPath.row == [self.dataArray[indexPath.section] count] - 1) {
                [cell cellWithtype:isPrice];
                
            } else {
                [cell cellWithtype:isDefault];
                
            }
            return cell;
            
        } else if (indexPath.section == self.dataArray.count - 1) {
            OrderDetailDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailDefaultCell class]) forIndexPath:indexPath];
            
            NSLog(@"%@---%ld",self.dataArray[indexPath.section],indexPath.row);
            [cell dataWithDictionary:self.dataArray[indexPath.section][indexPath.row]];
            [cell setOrderCopy:^{
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = self.orderDetailModel.nid;
                [SVProgressHUD showSuccessWithStatus:@"复制成功"];
            }];
            if (indexPath.row == 0) {
                [cell cellWithtype:isOrderid];
                
            } else {
                [cell cellWithtype:isDefault];
                
            }
            
            return cell;
        } else  if (indexPath.section == self.dataArray.count - 2){
            OrderDetailDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailDefaultCell class]) forIndexPath:indexPath];
            
            [cell dataWithDictionary:self.dataArray[indexPath.section][indexPath.row]];
            if (indexPath.row == 1) {
                [cell cellWithtype:isPrice];
                
            } else {
                [cell cellWithtype:isDefault];
                
            }
            return cell;
        } else {
            OrderDetailDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailDefaultCell class]) forIndexPath:indexPath];
            
            [cell cellWithtype:isDefault];
            [cell dataWithDictionary:self.dataArray[indexPath.section][indexPath.row]];
            
            return cell;
        }
    } else {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                OrderDeatilBigTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDeatilBigTitleCell class]) forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.titleStr = @"商家信息";
                
                return cell;
            } else {
                OrderDetailDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailDefaultCell class]) forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell cellWithtype:isCallShop];
                [cell dataWithDictionary:self.dataArray[indexPath.section][indexPath.row]];
                
                return cell;
            }
        } else if (indexPath.section == 1) {
            
            if (indexPath.row == 0) {
                OrderDeatilBigTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDeatilBigTitleCell class]) forIndexPath:indexPath];
                cell.titleStr = @"订单信息";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            } else {
                OrderDetailGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailGoodsCell class]) forIndexPath:indexPath];
                cell.orderGoodsModel = self.orderDetailModel.goodslist[indexPath.row - 1];
                return cell;
            }
        } else if (indexPath.section == self.dataArray.count - 3){
            OrderDetailDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailDefaultCell class]) forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell dataWithDictionary:self.dataArray[indexPath.section][indexPath.row]];
            
            if (indexPath.row == [self.dataArray[indexPath.section] count] - 1) {
                [cell cellWithtype:isPrice];
                
            } else {
                [cell cellWithtype:isDefault];
                
            }
            return cell;
            
        } else if (indexPath.section == self.dataArray.count - 1) {
            OrderDetailDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailDefaultCell class]) forIndexPath:indexPath];
            
            [cell dataWithDictionary:self.dataArray[indexPath.section][indexPath.row]];
            [cell setOrderCopy:^{
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = self.orderDetailModel.nid;
                [SVProgressHUD showSuccessWithStatus:@"复制成功"];
            }];
            if (indexPath.row == 0) {
                [cell cellWithtype:isOrderid];
                
            } else {
                [cell cellWithtype:isDefault];
                
            }
            
            return cell;
        }  else  if (indexPath.section == self.dataArray.count - 2){
            OrderDetailDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailDefaultCell class]) forIndexPath:indexPath];
            
            [cell dataWithDictionary:self.dataArray[indexPath.section][indexPath.row]];
            if (indexPath.row == 1) {
                [cell cellWithtype:isPrice];
                
            } else {
                [cell cellWithtype:isDefault];
                
            }
            return cell;
        } else  {
            OrderDetailDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailDefaultCell class]) forIndexPath:indexPath];
            
            [cell cellWithtype:isDefault];
            [cell dataWithDictionary:self.dataArray[indexPath.section][indexPath.row]];
            
            return cell;
        }
    }
    
    
    
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
        if (!self.mobileStr) {
            [SVProgressHUD showErrorWithStatus:@"没有可拨打的电话"];
        } else {
            HQJBusinessAlertView * alertView = [[HQJBusinessAlertView alloc]initWithisWarning:NO];
            [alertView zw_showAlertWithName:self.nameStr mobile:self.mobileStr];
            
        }
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return NewProportion(40.f);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, NewProportion(40.f))];
    headerView.backgroundColor = [ManagerEngine getColor:@"f2f2f2"];
    return headerView;
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
    if (self.orderDetailModel.tables && ![self.orderDetailModel.tables isEqualToString:@""]) {
        [printer appendTitle:@"桌号:" value:[NSString stringWithFormat:@"%ld",(long)self.orderDetailModel.tables]];
        [printer appendTitle:@"人数:" value:[NSString stringWithFormat:@"%ld",(long)self.orderDetailModel.people]];
    }
    
    [printer appendText:@"用户信息" alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    [printer appendText:[self.mobileStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]  alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
    [printer appendSeperatorLine];
    
    [printer appendText:@"订单详情" alignment:HLTextAlignmentLeft];
    NSInteger icount = 0 ;
    for (GoodsModel *goodsmdoel in self.orderDetailModel.goodslist) {
        [printer appendLeftText:goodsmdoel.goodsname middleText:[NSString stringWithFormat:@"x%ld",(long)goodsmdoel.goodscount] rightText:[NSString stringWithFormat:@"%.2f",goodsmdoel.goodsprice * goodsmdoel.goodscount] isTitle:NO];
        icount = icount + goodsmdoel.goodscount;
        
    }
    
    [printer appendSeperatorLine];
    
    [printer appendTitle:@"总计商品数" value:[NSString stringWithFormat:@"%ld",icount]];
    [printer appendTitle:@"订单金额" value:[NSString stringWithFormat:@"%.2f",self.orderDetailModel.price]];
    [printer appendTitle:@"应付金额" value:[NSString stringWithFormat:@"%.2f",self.orderDetailModel.actualpayment]];
    [printer appendSeperatorLine];
    [printer appendTitle:@"订单编号" value:[NSString stringWithFormat:@"%@",self.orderDetailModel.nid]];
    [printer appendTitle:@"下单时间" value:[ManagerEngine reverseSwitchTimer:[NSString stringWithFormat:@"%ld",self.orderDetailModel.date]]];
    if (self.orderDetailModel.remark && ![self.orderDetailModel.remark isEqualToString:@"(null)"] && ![self.orderDetailModel.remark isEqualToString:@""] ) {
        [printer appendText:[NSString stringWithFormat:@"备注：%@",self.orderDetailModel.remark]  alignment:HLTextAlignmentLeft fontSize:HLFontSizeTitleSmalle];
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

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
       
        
        double changeTime = self.orderDetailModel.date  / 1000;
        NSString *payType ;
        if (self.orderDetailModel.payway == 1) {
            payType = @"积分兑换";
        } else if (self.orderDetailModel.payway == 2) {
            payType = @"支付宝支付";
            
        } else if (self.orderDetailModel.payway == 3) {
            payType = @"微信支付";
            
        } else if (self.orderDetailModel.payway == 4){
            payType = @"银联支付";
            
        }
        double ryValue = self.orderDetailModel.zhValue * 2.f ;
     
        _dataArray = [NSMutableArray arrayWithArray:@[@[@{},
                                                        @{self.orderDetailModel.shopname ? self.orderDetailModel.shopname : @"" :@"联系买家"}],
                                                      @[@{}],
                                                      @[@{@"商品数量":[NSString stringWithFormat:@"%ld份",(long)self.orderDetailModel.count]},
                                                        @{@"商品总额":[NSString stringWithFormat:@"￥%.2f",self.orderDetailModel.price]},
                                                        @{@"商家折扣":[NSString stringWithFormat:@"%.1f折(-￥%.2f)",self.orderDetailModel.saleoff * 10.f,self.orderDetailModel.saleoff == 0 ? 0.f : self.orderDetailModel.price *(1.f - self.orderDetailModel.saleoff)]},
                                                        @{@"应收金额":[NSString stringWithFormat:@"￥%.2f", self.orderDetailModel.price * self.orderDetailModel.saleoff]}],
                                                      @[@{@"赠送RY值":[NSString stringWithFormat:@"%.f%%(-￥%.2f)",self.orderDetailModel.ratiory * 100,ryValue]},
                                                        @{@"商家实收":[NSString stringWithFormat:@"￥%.2f",self.orderDetailModel.shoppaidin - ryValue]}],
                                                      @[@{@"订单号":self.orderDetailModel.nid},
                                                        @{@"下单时间":[NSString stringWithFormat:@"%@",[ManagerEngine switchTimer:changeTime]]},
                                                        @{@"支付方式":payType},
                                                        @{@"订单备注":self.orderDetailModel.remark ?  self.orderDetailModel.remark : @""}]]];
        NSInteger minusIndex;
        if (!payType) {
            NSMutableArray *aryPayType =  [NSMutableArray arrayWithArray:_dataArray[_dataArray.count - 1]];
            [aryPayType removeObjectAtIndex:2];
            [_dataArray replaceObjectAtIndex:_dataArray.count - 1 withObject:aryPayType];
        }
        if (!self.orderDetailModel.goodslist || self.orderDetailModel.goodslist.count == 0) {
            [_dataArray removeObjectAtIndex:1];
            minusIndex = 1;
        } else {
            minusIndex = 0;
        }
        
        if ([self.orderDetailModel.state isEqualToString:@"待付款"]) {
            NSMutableArray *aryStateOne =  [NSMutableArray arrayWithArray:_dataArray[2 - minusIndex]];
            [aryStateOne replaceObjectAtIndex:aryStateOne.count - 1 withObject:@{@"应收金额":@""}];
            [_dataArray replaceObjectAtIndex:2 - minusIndex withObject:aryStateOne];

            NSMutableArray *aryStateTwo =  [NSMutableArray arrayWithArray:_dataArray[3 - minusIndex]];
            [aryStateTwo replaceObjectAtIndex:0 withObject:@{@"赠送RY值":@""}];
            [aryStateTwo replaceObjectAtIndex:1 withObject:@{@"商家实收":@""}];
            [_dataArray replaceObjectAtIndex:3 - minusIndex withObject:aryStateTwo];

        }
        
        if (self.orderDetailModel.couponsid) {
            NSString *couponDiscount   = [NSString stringWithFormat:@"-￥%.2f",self.orderDetailModel.couponsprice];
            NSMutableArray *aryCoupon =  [NSMutableArray arrayWithArray:_dataArray[2 - minusIndex]];
            [aryCoupon insertObject:@{self.orderDetailModel.couponname :couponDiscount}atIndex:2];
            [aryCoupon replaceObjectAtIndex:aryCoupon.count - 1 withObject:@{@"应收金额":[NSString stringWithFormat:@"%.2f",self.orderDetailModel.actualpayment]}];

            [aryCoupon removeObjectAtIndex:3];
           [_dataArray replaceObjectAtIndex:2 - minusIndex withObject:aryCoupon];
        }
        NSString *orderType ;
        NSMutableArray *arypeople = [NSMutableArray arrayWithArray:_dataArray[4 - minusIndex]];
        
        if (self.orderDetailModel.people) {
            orderType = @"扫码点餐";
            [arypeople insertObject: @{@"用餐人数": [NSString stringWithFormat:@"%ld人",(long)self.orderDetailModel.people]}atIndex:4];
            [arypeople insertObject: @{@"用餐桌号":self.orderDetailModel.tables}atIndex:5];
            [arypeople insertObject: @{@"订单类型":orderType}atIndex:payType ? 3 : 3 - 1];
            
            [_dataArray replaceObjectAtIndex:4 - minusIndex withObject:arypeople];
        } else if (self.orderDetailModel.type == 1) {
            orderType = @"购物车订单";
            [arypeople insertObject: @{@"订单类型":orderType}atIndex:payType ? 3 : 3 - 1];
            [_dataArray replaceObjectAtIndex:4 - minusIndex withObject:arypeople];
            
        } else if (self.orderDetailModel.type == 2) {
            orderType = @"付款订单";
            [arypeople insertObject: @{@"订单类型":orderType}atIndex:payType ? 3 : 3 - 1];
            [_dataArray replaceObjectAtIndex:4 - minusIndex withObject:arypeople];
            
        } else {
            orderType = @"其他订单";
            [arypeople insertObject: @{@"订单类型":orderType}atIndex:payType ? 3 : 3 - 1];
            [_dataArray replaceObjectAtIndex:4 - minusIndex withObject:arypeople];
            
        }
    }
    return _dataArray;
}
- (OrderDetailsPrintHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[OrderDetailsPrintHeaderView alloc]init];
        _headerView.frame =CGRectMake(0, 0, WIDTH, 54);
        _headerView.states = self.orderDetailModel.state;
        @weakify(self);
        [_headerView setClickPrint:^{
            @strongify(self);
            [self printe];
        }];
    }
    return _headerView;
}
- (UITableView *)orderDetailTableView {
    if (!_orderDetailTableView) {
        _orderDetailTableView = [[UITableView alloc]init];
        _orderDetailTableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight);
        _orderDetailTableView.delegate = self;
        _orderDetailTableView.dataSource = self;
        _orderDetailTableView.backgroundColor = [ManagerEngine getColor:@"f2f2f2"];
        [_orderDetailTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [_orderDetailTableView registerClass:[OrderDeatilBigTitleCell class] forCellReuseIdentifier:NSStringFromClass([OrderDeatilBigTitleCell class])];
        [_orderDetailTableView registerClass:[OrderDetailDefaultCell class] forCellReuseIdentifier:NSStringFromClass([OrderDetailDefaultCell class])];
        [_orderDetailTableView registerClass:[OrderDetailGoodsCell class] forCellReuseIdentifier:NSStringFromClass([OrderDetailGoodsCell class])];
        _orderDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(NewProportion(60.f), NewProportion(42.f), WIDTH - NewProportion(60.f) , NewProportion(54.f))];
//        headLabel.backgroundColor = [ManagerEngine getColor:@"f2f2f2"];
//        headLabel.textColor = DefaultAPPColor;
//        headLabel.font = [UIFont systemFontOfSize:NewProportion(54.f) weight:UIFontWeightBold];
//        headLabel.text = self.orderDetailModel.state;
//        UIButton *printBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
//
//        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH,NewProportion(100.f))];
//        headView.backgroundColor = [ManagerEngine getColor:@"f2f2f2"];
//        [headView addSubview:headLabel];
        _orderDetailTableView.tableHeaderView = self.headerView;
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, NewProportion(40.f))];
        footView.backgroundColor = [ManagerEngine getColor:@"f2f2f2"];
        _orderDetailTableView.tableFooterView = footView;
        
    }
    return _orderDetailTableView;
}
@end
