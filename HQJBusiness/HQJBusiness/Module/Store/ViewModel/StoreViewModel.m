//
//  StoreViewModel.m
//  HQJBusiness
//
//  Created by mymac on 2019/6/25.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "StoreViewModel.h"
#import "HQJMenu.h"
#import "ScanViewController.h"
#import "FunctionSetVC.h"
#import "StoreMainCell.h"
#import "StoreADCell.h"
#import "DetailViewController.h"
#import "OrderManageVC.h"
#import "GoodsManageVC.h"
#import "MenuModel.h"
#import "MenuManager.h"
#import "ManuallyAddViewController.h"
#import "VerificationOrderDetailsViewController.h"
#import "OrderViewController.h"
#import "GoodsReleaseVC.h"
#import "CatalogueVC.h"
#import "ReleaseRulesVC.h"
#import "AppDelegate.h"
#import "ZW_TabBar.h"
#import "StoreMainCollectionViewCell.h"
#import "StoreCollectionReusableView.h"
#import "StoreADCollectionViewCell.h"
#import "StoreToolCollectionViewCell.h"
#import "StoreModel.h"
#import "MyViewModel.h"
#import "MyModel.h"
#define StoreMenuWidth  130.f;
#define StoreMenuRowHeight  57.f;
#define StoreMenuIconMargin  16.4f;
#define StoreMenuTextMargin  10.f;
#define StoreMenuFont  [UIFont systemFontOfSize:16.f];
#define StoreMenuSeparatorInset  UIEdgeInsetsMake(0, 40, 0, 0);
#define StoreMainViewWidth (WIDTH - 10 * 2)

//C

@interface StoreViewModel()
@property (nonatomic, strong) UIViewController *storeViewModel_self;
@property (nonatomic, strong) StoreModel *sm_model;
@property (nonatomic, strong) MyModel *m_model;
@property (nonatomic, strong) UICollectionView *vm_collectionView;
@property (nonatomic, strong) MyViewModel *viewModel;
@property (nonatomic, strong) NSMutableArray *toolAry;
@end
@implementation StoreViewModel
- (instancetype)initWithTargetObjct:(id)object collectionView:(UICollectionView *)vmCollectionView
{
    self = [super init];
    if (self) {
        self.storeViewModel_self = object;
        self.vm_collectionView = vmCollectionView;
        [self storeViewModel_notifi];
        NSMutableArray *ary = [NSMutableArray arrayWithArray:ToolItem];
        if (ary && ary.count != 0) {
            if (ary.count < 4) {
                NSInteger a = 4 - ary.count;
                for (NSInteger i = 0; i < a; i++) {
                    [ary addObject:@[]];
                }
            }
            self.toolAry = ary;

        } else {
            self.toolAry = @[@[@"经营有道",@"tool_icon_manage"],@[@"流量手册",@"tool_icon_flow"],@[],@[]].mutableCopy;

        }

     
    }
    return self;
}

- (void)stroeRequst:(void(^)(void))complete{
    [self.viewModel myRequst];
    @weakify(self);
    [self.viewModel  setMyrequstBlock:^(MyModel * xzw_model) {
        @strongify(self);
        self.m_model = xzw_model;
        
        [NameSingle shareInstance].name = xzw_model.realname; // --- 单例存商家名字
        [NameSingle shareInstance].role = xzw_model.role;   //  -----   存商家类型
        [NameSingle shareInstance].mobile = xzw_model.mobile;
        [NameSingle shareInstance].memberid = xzw_model.memberid;
        [self.vm_collectionView reloadData];
        !complete? :complete();
    }];
    NSMutableDictionary *dict = @{@"shopid":MmberidStr}.mutableCopy;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBDomainName,HQJBShopfindorderstatecodeInterface];
    if (MmberidStr) {
        @weakify(self);
        [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
            @strongify(self);
            StoreModel *requstModel = [StoreModel mj_objectWithKeyValues:dic[@"resultMsg"]];
            self.sm_model = requstModel;
            [self.vm_collectionView reloadData];
        } andError:^(NSError *error) {

        } ShowHUD:YES];
    }
}

- (void)storeViewModel_notifi {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(operationItem:) name:CreateStoreTreasure object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alertView:) name:@"Qrcode" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addTool) name:StoreAddTool object:nil];

    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)addTool{
    NSMutableArray *ary = [NSMutableArray arrayWithArray:ToolItem];
  
    if (ary.count == 0) {
        [[[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"]  setObject:[NSNumber numberWithBool:1] forKey:CreateStoreTreasureKey];
    } else {
//        BOOL ishide = [[[[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"]  objectForKey:CreateStoreTreasureKey] boolValue];
//        if (!ishide) {
            [[[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"]  setObject:[NSNumber numberWithBool:0] forKey:CreateStoreTreasureKey];

//        }

        if (ary.count < 4) {
            NSInteger a = 4 - ary.count;
            for (NSInteger i = 0; i < a; i++) {
                [ary addObject:@[]];
            }
        }
    }
    self.toolAry = ary;
    [self.vm_collectionView reloadData];
}
-(void)alertView:(NSNotification *)infos {
    NSInteger  stateCode = [infos.userInfo[@"state"] integerValue];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (stateCode == -1) {
            [ManagerEngine alertMessage:@"消费码不存在"];
            
        } else if (stateCode == 1) {
            
            VerificationOrderDetailsViewController *vc = [[VerificationOrderDetailsViewController alloc]initWithNavType:HQJNavigationBarWhite orderId:infos.userInfo[@"orderid"] consumerCode:infos.userInfo[@"salecode"]];
            [self.storeViewModel_self.navigationController pushViewController:vc animated:YES];
            
            
            
        } else if (stateCode == 2) {
            
            [ManagerEngine alertMessage:@"已使用"];
            
        } else if (stateCode == 3) {
            
            [ManagerEngine alertMessage:@"已退款"];
            
        } else if (stateCode == 4) {
            
            [ManagerEngine alertMessage:@"已过期"];
        }
        
    });
    
    
}
- (void)operationItem:(NSNotification *)notifi {
    NSString *isHide = notifi.userInfo[@"isHide"];
//    if ([isHide isEqualToString:@"开"]) {
////        [self titleAry removeLastObject];
////        [self.modelAry removeLastObject];
//
//    } else {
//        [self.titleAry addObject:[self openingStoreAry]];
//        [self.modelAry addObject:@[]];
//    }
    [self.vm_collectionView reloadData];
}

#pragma mark --- 导航控制器菜单
- (void)navMenu:(UIView *)view {
    NSArray *itemTitAry = @[@"扫一扫", @"功能设置"];
    NSArray *itemImgAry = @[@"menu_scan", @"menu_set"];
    [MenuManager menushowForSender:view withMenuArray:itemTitAry imageArray:itemImgAry textAlignment:NSTextAlignmentLeft doneBlock:^(NSInteger selectedIndex) {
        if (selectedIndex == 0) {
            ScanViewController *sVC =[[ScanViewController alloc]init];
            [sVC setDismissBlock:^{
                ManuallyAddViewController *mVC = [[ManuallyAddViewController alloc]initWithNavType:HQJNavigationBarWhite];
                [self.storeViewModel_self.navigationController pushViewController:mVC animated:YES];
            }];
            [self.storeViewModel_self presentViewController:sVC animated:YES completion:nil];
        } else {
            FunctionSetVC *fVC = [[FunctionSetVC alloc]initWithNavType:HQJNavigationBarWhite];
            [self.storeViewModel_self.navigationController pushViewController:fVC animated:YES];
        }
    }];
    

}

#pragma mark --- 剥离控制器中的cell 
- (UITableViewCell *)cellManageWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 2) {
        StoreMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([StoreMainCell class]) forIndexPath:indexPath];
        //        cell.itemAry = .mutableCopy;
        @weakify(self);
        [cell setClickItemblock:^(NSString * _Nonnull title) {
            NSLog(@"你点击了：%@",title);
            @strongify(self);
            if ([title isEqualToString:@"添加商品"]) {
                
                [ManagerEngine goodsRelease];
       
            }
            if ([title isEqualToString:@"经营有道"]) {
                
                [self jumpWebView:@"Headlines/#/WillManaged" title:title];

            }
            if ([title isEqualToString:@"流量手册"]) {
                
                [self jumpWebView:@"Headlines/#/FlowManual" title:title];

            }
        }];
        cell.titleArray = self.titleAry[indexPath.section];
        cell.itemAry = [self modelAry][indexPath.section];

        return cell;
        
    } else  {
        StoreADCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([StoreADCell class])];
        [cell setClickADButtonBlock:^(NSString * _Nonnull btnTitle) {
            NSLog(@"你点击了：%@",btnTitle);
            ReleaseRulesVC *vc = [[ReleaseRulesVC alloc]initWithNavType:HQJNavigationBarWhite];
            vc.webUrlStr = [NSString stringWithFormat:@"%@register/#/newstore?mobile=13855555555",HQJBBonusDomainDeccaName];
            [[ManagerEngine currentViewControll].navigationController pushViewController:vc animated:YES];
        }];
        return cell;
    }
}
- (void)jumpWebView:(NSString *)url title:(NSString *)title{
    ProtocolViewController * vc  = [[ProtocolViewController alloc]initWithNavType:HQJNavigationBarWhite];
    vc.titleStr = title;
    vc.webUrlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainDeccaName,url];
    [[ManagerEngine currentViewControll].navigationController pushViewController:vc animated:YES];

}
- (void)selectCellForIndex:(NSIndexPath *)index {
    NSArray *ary = self.titleAry[index.section];
    if ([ary.lastObject isEqualToString:@"开店宝典"]) {
        AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        ZW_TabBar *tab = (ZW_TabBar*)delegate.window.rootViewController;
        [tab didSelectItem:3];
    } else {
        UIViewController *viewController;
        if ([ary.lastObject isEqualToString:@"交易数据"]) {
            viewController = [[DetailViewController alloc]initWithNavType:HQJNavigationBarWhite];
        } else if ([ary.lastObject isEqualToString:@"订单管理"]) {
            viewController = [[OrderViewController alloc]initWithNavType:HQJNavigationBarWhite];
        } else if ([ary.lastObject isEqualToString:@"商品管理"]) {
            viewController = [[GoodsManageVC alloc]initWithNavType:HQJNavigationBarWhite];
        }
        [self.storeViewModel_self.navigationController pushViewController:viewController animated:YES];
    }
    

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return  CGSizeMake(StoreMainViewWidth /3.f , NewProportion(255));

    } else if (indexPath.section == 1) {
        return  CGSizeMake(StoreMainViewWidth /3.f , NewProportion(810)/3 );

    } else if (indexPath.section == 2) {
        return  CGSizeMake(StoreMainViewWidth , NewProportion(160));
        
    }  else if (indexPath.section == 3) {
        return  CGSizeMake(StoreMainViewWidth /3.f , NewProportion(810)/3 );
    } else {
        HQJLog(@"每一个的宽度：%f",StoreMainViewWidth /4.f)
        return  CGSizeMake(88.75 + CGFLOAT_MIN, NewProportion(300));
        
    }
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.titleAry.count;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else if(section == 1){
        return 9;

    } else if(section == 2) {
        return 1;
    } else if(section == 3) {
        return [self.modelAry[section] count];
    } else {
        return 4;
    }
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        
        StoreADCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([StoreADCollectionViewCell class]) forIndexPath:indexPath];
//        @weakify(self);

        [cell setClickLeftButton:^{
//            @strongify(self);
//            ReleaseRulesVC *vc = [[ReleaseRulesVC alloc]initWithNavType:HQJNavigationBarWhite];
//            vc.webUrlStr = [NSString stringWithFormat:@"%@register/#/newstore?mobile=13855555555",HQJBH5DeccaName];
//            [[ManagerEngine currentViewControll].navigationController pushViewController:vc animated:YES];
        }];
        [cell setClickRightButton:^{
//             @strongify(self);
//            ReleaseRulesVC *vc = [[ReleaseRulesVC alloc]initWithNavType:HQJNavigationBarWhite];
//            vc.webUrlStr = [NSString stringWithFormat:@"%@register/#/newstore?mobile=13855555555",HQJBH5DeccaName];
//            [[ManagerEngine currentViewControll].navigationController pushViewController:vc animated:YES];
        }];
        return cell;

    } else if (indexPath.section == 4) {
        StoreToolCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([StoreToolCollectionViewCell class]) forIndexPath:indexPath];
        cell.itemDictionary = [self modelAry][indexPath.section][indexPath.item];
        if (indexPath.item == 0 ) {
            [self hqj_roundedCornersWithRoundedRect:CGRectMake(0, 0,88.75 + CGFLOAT_MIN , NewProportion(300)) byRoundingCorners:UIRectCornerBottomLeft cornerRadii:NewProportion(30) lineWidth:cell];
            
        }else if ( indexPath.item == 3) {
            [self hqj_roundedCornersWithRoundedRect:CGRectMake(0, 0,88.75 + CGFLOAT_MIN, NewProportion(300)) byRoundingCorners:UIRectCornerBottomRight cornerRadii:NewProportion(30) lineWidth:cell];
            
        } else {
            [self hqj_roundedCornersWithRoundedRect:CGRectMake(0, 0,88.75 + CGFLOAT_MIN, NewProportion(300)) byRoundingCorners:UIRectCornerAllCorners cornerRadii:0 lineWidth:cell];
            
        }
        return cell;
    } else {
        StoreMainCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([StoreMainCollectionViewCell class]) forIndexPath:indexPath];
        cell.storeTitleStr = [self modelAry][indexPath.section][indexPath.item];
        if (indexPath.section == 0) {
            cell.mmodel = self.m_model;
            if (indexPath.item == 0 ) {
                [self hqj_roundedCornersWithRoundedRect:CGRectMake(0, 0,StoreMainViewWidth /3, NewProportion(255)) byRoundingCorners:UIRectCornerBottomLeft cornerRadii:NewProportion(30) lineWidth:cell];
                
            }else if ( indexPath.item == 2) {
                [self hqj_roundedCornersWithRoundedRect:CGRectMake(0, 0,StoreMainViewWidth /3, NewProportion(255)) byRoundingCorners:UIRectCornerBottomRight cornerRadii:NewProportion(30) lineWidth:cell];
                
            } else {
                [self hqj_roundedCornersWithRoundedRect:CGRectMake(0, 0,StoreMainViewWidth/3, NewProportion(255)) byRoundingCorners:UIRectCornerAllCorners cornerRadii:0 lineWidth:cell];
                
            }
        } else {
            cell.model = self.sm_model;

            if (indexPath.item == 6 ) {
                [self hqj_roundedCornersWithRoundedRect:CGRectMake(0, 0,StoreMainViewWidth /3, NewProportion(810)/3) byRoundingCorners:UIRectCornerBottomLeft cornerRadii:NewProportion(30) lineWidth:cell];
                
            }else if ( indexPath.item == 8) {
                [self hqj_roundedCornersWithRoundedRect:CGRectMake(0, 0,StoreMainViewWidth /3, NewProportion(810)/3) byRoundingCorners:UIRectCornerBottomRight cornerRadii:NewProportion(30) lineWidth:cell];
                
            } else {
                [self hqj_roundedCornersWithRoundedRect:CGRectMake(0, 0,StoreMainViewWidth/3,NewProportion(810)/3) byRoundingCorners:UIRectCornerAllCorners cornerRadii:0 lineWidth:cell];
                
            }
        }
        return cell;
    }
    

    
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 4) {
        if ([[self.toolAry[indexPath.item] firstObject] isEqualToString:@"经营有道"]) {
            [self jumpWebView:@"shopH5/Headlines/#/WillManaged" title:@"经营有道"];
        }
        if ([[self.toolAry[indexPath.item] firstObject] isEqualToString:@"流量手册"]) {
            [self jumpWebView:@"shopH5/Headlines/#/FlowManual" title:@"流量手册"];
        }
        
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return CGSizeMake(0, NewProportion(40));
        
    } else{
        return CGSizeMake(WIDTH, NewProportion(40) + NewProportion(150));
        
    }
}
////设置头部内容
//

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        
        if (indexPath.section != 2) {
            StoreCollectionReusableView * headerV =(StoreCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([StoreCollectionReusableView class]) forIndexPath:indexPath];
            headerV.itemAry = self.titleAry[indexPath.section];
            @weakify(self);
            [headerV setClickBtn:^{
                @strongify(self);
                [self selectCellForIndex:indexPath];
            }];
            reusableView = headerV;
        } else {
            UICollectionReusableView * headerV =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
            reusableView = headerV;

        }
        
      
    }
    return reusableView;
    
}
- (NSMutableArray *)modelAry {
//    if (!_modelAry) {
        BOOL ishide = [[[[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"]  objectForKey:CreateStoreTreasureKey] boolValue];
    
    
//    NSMutableArray *ary = [NSMutableArray arrayWithArray:ToolItem];
//   
//    
//        if (ary.count < 4) {
//            for (NSInteger i = 0; i < 4 - ary.count; i++) {
//                [ary addObject:@[]];
//            }
//        }
        if (ishide) {
            _modelAry =@[
                         @[@"今日积分",@"今日现金",@"今日RY值支出"],
                         @[@"今日订单数",@"商品订单",@"收款订单",@"已核销订单",@"待付款",@"待评价",@"待核销订单",@"",@""],
                         @[],
                         @[@"出售中",@"已下架",@"草稿中"]
                         ].mutableCopy;
        } else {
            _modelAry =@[
                         @[@"今日积分",@"今日现金",@"今日RY值支出"],
                         @[@"今日订单数",@"商品订单",@"收款订单",@"已核销订单",@"待付款",@"待评价",@"待核销订单",@"",@""],
                         @[],
                        @[@"出售中",@"已下架",@"草稿中"],
//                         @[@[@"经营有道",@"tool_icon_manage"],@[@"流量手册",@"tool_icon_flow"],@[],@[]]
                        self.toolAry].mutableCopy;
        }
     
//    }
    return _modelAry;
}

- (NSArray *)openingStoreAry {
    return  @[@"shop_store-opening",@"开店宝典"];
}

- (NSMutableArray *)titleAry {
        BOOL ishide = [[[[NSUserDefaults alloc] initWithSuiteName:@"group.com.first.HQJBusiness"]  objectForKey:CreateStoreTreasureKey] boolValue];
        if (ishide) {
            _titleAry = @[
                          @[@"store_transactionData",@"交易数据"],
                          @[@"store_orderManagement",@"订单管理"],
                          @[],
                          @[@"store_commodityManagement",@"商品管理"]
                          ].mutableCopy;
        } else {
            _titleAry = @[
                          @[@"store_transactionData",@"交易数据"],
                          @[@"store_orderManagement",@"订单管理"],
                          @[],
                          @[@"store_commodityManagement",@"商品管理"],
                          [self openingStoreAry]].mutableCopy;
        }
    return _titleAry;
}
- (void)hqj_roundedCornersWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGFloat)cornerRadii lineWidth:(UIView *)view {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadii, cornerRadii)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
   view.layer.mask = maskLayer;
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = maskPath.CGPath;
    pathLayer.fillColor = nil; // 默认为blackColor
    [view.layer addSublayer:pathLayer];
}
- (MyViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MyViewModel alloc]init];
    }
    return _viewModel;
}
@end



