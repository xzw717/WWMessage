//
//  ShopViewController.m
//  HQJBusiness
//
//  Created by Ethan on 2021/6/2.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

@interface ShopCustomFlowLayout : UICollectionViewFlowLayout

@end
@interface ShopCustomFlowLayout ()
@property (nonatomic) CGFloat maximumInteritemSpacing;
@end
@implementation ShopCustomFlowLayout
- (instancetype)init{
    if (self = [super init]) {
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.maximumInteritemSpacing = 0;
        self.sectionInset = UIEdgeInsetsMake(0 , 30.f/2, 0, 30.f/2);
    }
    return self;
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //使用系统帮我们计算好的结果。 WIDTH - 15 * 2 )/ 4
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    //第0个cell没有上一个cell，所以从1开始
    for(int i = 1; i < [attributes count]; ++i) {
        //这里 UICollectionViewLayoutAttributes 的排列总是按照 indexPath的顺序来的。
        UICollectionViewLayoutAttributes *curAttr = attributes[i];
        UICollectionViewLayoutAttributes *preAttr = attributes[i-1];
        
        NSInteger origin = CGRectGetMaxX(preAttr.frame);
        //根据  maximumInteritemSpacing 计算出的新的 x 位置
        CGFloat targetX = origin + _maximumInteritemSpacing;
        // 只有系统计算的间距大于  maximumInteritemSpacing 时才进行调整
        if (CGRectGetMinX(curAttr.frame) > targetX) {
            // 换行时不用调整
            if (targetX + CGRectGetWidth(curAttr.frame) < self.collectionViewContentSize.width) {
                CGRect frame = curAttr.frame;
                frame.origin.x = targetX;
                curAttr.frame = frame;
            }
        }
    }
    return attributes;
}
@end

#import "ShopViewController.h"
#import "StaffRoleItem.h"
#import "ShopHeaderCollectionReusableView.h"
#import "ShopCollectionViewCell.h"
#import "ShopNumberCollectionViewCell.h"
#import "ShopFooterCollectionReusableView.h"
#import "ShopFirstHeaderCollectionReusableView.h"
#import "ShopViewModel.h"
#import "MyViewModel.h"
#import "MyModel.h"
#import "HintView.h"
#import "ShopNumberModel.h"
#import "ForgetPswViewController.h"
#import "TabBarBannerViewModel.h"
#import "TabBarBannerModel.h"
@interface ShopViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray *itemDataSource;
@property (nonatomic, strong) ShopViewModel *viewModel;
@property (nonatomic, strong) MyViewModel *myViewModel;
@property (nonatomic, strong) NSMutableArray *bannerArray;
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NavigationControllerHeight);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-15);
    }];
    self.zwNavView.backgroundColor = DefaultAPPColor;
    self.zwBackButton.hidden = YES;
    _myViewModel = [[MyViewModel alloc]init];
    [self shopDataRequst];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
 
    return UIStatusBarStyleLightContent;
}
- (void)shopDataRequst {
    @weakify(self);
    [_myViewModel  setMyrequstBlock:^(MyModel * xzw_model) {
        @strongify(self);
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = 0 ; i < 3; i ++) {
            ShopModel *model = [[ShopModel alloc]init];
            if (i == 0) {
                model.sp_number =  [NSString stringWithFormat:@"+%.2f",xzw_model.incomeBToday.doubleValue];
                model.sp_title = @"当日积分";
            } else if (i == 1) {
                model.sp_number =  [NSString stringWithFormat:@"+%.2f",fabs(xzw_model.incomCToday.doubleValue)];
                model.sp_title = @"当日现金";
            } else {
                model.sp_number =  [NSString stringWithFormat:@"+%.2f",xzw_model.zh];
                model.sp_title = @"RY值余额";
            }
            
            [array addObject:model];
        }
        
        self.viewModel.sourceArray[0] = array;
        
        [NameSingle shareInstance].name = xzw_model.realname; // --- 单例存商家名字
        [NameSingle shareInstance].role = xzw_model.role;   //  -----   存商家类型
        [NameSingle shareInstance].mobile = xzw_model.mobile;
        [NameSingle shareInstance].memberid = xzw_model.memberid;
        [NameSingle shareInstance].membertype = xzw_model.membertype;
        if ([isComplete integerValue] == 1 ||[isComplete integerValue] == 3) {
            if (![NameSingle shareInstance].isShow) {
                [NameSingle shareInstance].isShow = YES;
                @weakify(self);
                [HintView enrichSubviews:@"设置登录密码，保障账户安全" andSureTitle:@"前往设置" cancelTitle:@"放弃" sureAction:^{
                    @strongify(self);
                    ForgetPswViewController *fpVC = [[ForgetPswViewController alloc]init];
                    fpVC.isForget = NO;
                    [self.navigationController pushViewController:fpVC animated:YES];
                }];
            }
            
        }
        [MyViewModel getXdShopAuditWithCompletion:^(NSDictionary *dict) {
            [NameSingle shareInstance].peugeotid  = [dict[@"peugeotid"] integerValue];
//            self.model = self.model;
            if ([dict[@"peugeotid"] integerValue] == 6) {
                [MyViewModel getMerchantTotalAward:^(NSString *award) {
//                    self.reward = award;
//                    [self.myTableView reloadData];
//                    [self.myTableView.mj_header endRefreshing];
                    
                }];
            } else {
                [self.collectionView reloadData];
                
                [self.collectionView.mj_header endRefreshing];
            }
            
        }];
        [self.collectionView reloadData];
    }];
    [_myViewModel setMyrequstErrorBlock:^{
        @strongify(self);
        [self.collectionView.mj_header endRefreshing];

    }];
    [TabBarBannerViewModel pictureRequst:^(NSMutableArray *sender) {
        self.bannerArray = [NSMutableArray array];
        @strongify(self);
        for (TabBarBannerModel * picturemdoel in sender) {
            
            [self.bannerArray addObject:[NSString stringWithFormat:@"%@%@",HQJBImageDomainName,picturemdoel.src]];
            
        }
        [self.collectionView reloadData];

    }];
    [self.myViewModel getshopidWithMemberid:MmberidStr completion:^(NSString *shopid) {
        [self.collectionView reloadData];

    }];
    [_myViewModel myRequst];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.viewModel.sourceArray.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return CGSizeMake((WIDTH - 15 * 2 )/ 3  , 235.f/3);

    } else if (indexPath.section == 3){
        return CGSizeMake((WIDTH - 15 * 2 )/ 4  , 235.f/3 + 5);

    }  else {
        return CGSizeMake((WIDTH - 15 * 2 )/ 4  , 235.f/3);

    }


}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        return  self.viewModel.sourceArray[section].count;

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(WIDTH, WIDTH / 2 + 40);
    } else {
        return CGSizeMake(WIDTH, 128.f/3);
    }
    return CGSizeMake(0, 0);
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        ShopNumberCollectionViewCell *cell = (ShopNumberCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ShopNumberCollectionViewCell class]) forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.spn_model = self.viewModel.sourceArray[indexPath.section][indexPath.row];
        return cell;
    } else {
        ShopCollectionViewCell *cell = (ShopCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ShopCollectionViewCell class]) forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.sp_model = self.viewModel.sourceArray[indexPath.section][indexPath.row];
        return cell;

    }

 

   
   
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 0) {
            ShopFirstHeaderCollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ShopFirstHeaderCollectionReusableView class]) forIndexPath:indexPath];
            headerView.shopBannerView.imageURLStringsGroup = self.bannerArray;
            reusableView = headerView;
        } else {
            ShopHeaderCollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ShopHeaderCollectionReusableView class]) forIndexPath:indexPath];
            headerView.sp_sectionTitle = self.viewModel.sectionTitleArray[indexPath.section];
            reusableView = headerView;
        }
   
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        ShopFooterCollectionReusableView * footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([ShopFooterCollectionReusableView class]) forIndexPath:indexPath];
      
        reusableView = footerView;
        
    }
    return reusableView;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel clickItemWithIndexPath:indexPath dataArray:self.viewModel.sourceArray];
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        ShopCustomFlowLayout *flowLayout = [[ShopCustomFlowLayout alloc] init];
        flowLayout.footerReferenceSize = CGSizeMake(10, 40);

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = self.view.backgroundColor;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self shopDataRequst];
        }];
        [_collectionView registerClass:[ShopCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ShopCollectionViewCell class])];
        [_collectionView registerClass:[ShopNumberCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ShopNumberCollectionViewCell class])];
        
        [_collectionView registerClass:[ShopFirstHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ShopFirstHeaderCollectionReusableView class])];

        [_collectionView registerClass:[ShopHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ShopHeaderCollectionReusableView class])];
        
        
        [_collectionView registerClass:[ShopFooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([ShopFooterCollectionReusableView class])];


    }
    return _collectionView;
}
- (ShopViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ShopViewModel alloc]init];
        
    }
    return _viewModel;
}
@end
