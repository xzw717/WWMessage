//
//  ToolsViewController.m
//  HQJBusiness
//
//  Created by Ethan on 2021/6/7.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//
@interface ToolsCustomFlowLayout : UICollectionViewFlowLayout

@end
@interface ToolsCustomFlowLayout ()
@property (nonatomic) CGFloat maximumInteritemSpacing;
@end
@implementation ToolsCustomFlowLayout
- (instancetype)init{
    if (self = [super init]) {
        self.minimumLineSpacing = 1;
        self.minimumInteritemSpacing = 1;
        self.maximumInteritemSpacing = 1;
        self.sectionInset = UIEdgeInsetsMake(0 , 0, 0, 0);
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
#import "ToolsViewController.h"
#import "ShopCollectionViewCell.h"
#import "ShopModel.h"
#import "ShopViewModel.h"
#import "HQJWebViewController.h"
@interface ToolsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray *dataSourceAry;
@property (nonatomic, strong) ShopViewModel *viewModel;
@end

@implementation ToolsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zwNavView.backgroundColor = DefaultAPPColor;
    self.zwBackButton.hidden = YES;
    self.zw_title = @"工具";
    self.zwTitLabel.textColor = [UIColor whiteColor];
    self.viewModel = [[ShopViewModel alloc]init];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NavigationControllerHeight);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-15);
    }];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  2;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(WIDTH, 40);
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ShopCollectionViewCell *cell = (ShopCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ShopCollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.sp_model = self.dataSourceAry[indexPath.section][indexPath.row];
    return cell;
    
    
    
    
    
    
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 0) {
            UICollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 20)];
            label.text = @"商家助手";
            label.font = [UIFont systemFontOfSize:15.f];
            label.textColor = [ManagerEngine getColor:@"606266"];
            [headerView addSubview:label];
            reusableView = headerView;
        } else {
            UICollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 20)];
            label.text = @"营销工具";
            label.font = [UIFont systemFontOfSize:15.f];
            label.textColor = [ManagerEngine getColor:@"606266"];
            [headerView addSubview:label];
            reusableView = headerView;
        }
        
    }
    return reusableView;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    HQJWebViewController *vc = [[HQJWebViewController alloc]init];
//    [vc setWebUrlStr:[NSString  stringWithFormat:@"%@shopappH5/index.html#/couponlist?id=%@&hash=%@",WWMCouponDomain
//                      ,MmberidStr,HashCode]];
//    [vc setFd_interactivePopDisabled:YES];
//    [self.navigationController pushViewController:vc animated:YES];
    [self.viewModel clickItemWithIndexPath:indexPath dataArray:self.dataSourceAry];
    
    
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        ToolsCustomFlowLayout *flowLayout = [[ToolsCustomFlowLayout alloc] init];
        flowLayout.headerReferenceSize = CGSizeMake(10, 40);
        flowLayout.itemSize = CGSizeMake((WIDTH - 3) / 4, (WIDTH - 3) / 4);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = self.view.backgroundColor;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[ShopCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ShopCollectionViewCell class])];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        
        
    }
    return _collectionView;
}
- (NSArray *)dataSourceAry {
    if (!_dataSourceAry) {
        _dataSourceAry = [NSMutableArray array];
        NSArray *rowTitleWithImageArray = @[@[@{@"sp_image":@"icon_tool_verificationcode",
                                                @"sp_title":@"消费码核销",
                                                @"sp_action":@"ConsumerCodeVerificationViewController"},
                                              @{@"sp_image":@"icon_tool_download",
                                                @"sp_title":@"台卡下载",
                                                @"sp_action":@"DeccaDownloadViewController"}],
                                            @[@{@"sp_image":@"icon_tool_coupon",
                                                @"sp_title":@"优惠券",
                                                @"sp_action":@"HQJWebViewController",
                                                @"sp_parameter":@{@"webUrlStr":[NSString  stringWithFormat:@"%@shopappH5/index.html#/couponlist?id=%@&hash=%@",WWMCouponDomain
                                                                                ,MmberidStr,HashCode],
                                                                  @"fd_interactivePopDisabled":@(YES),
                                                                  @"isHiddenNav":@(YES)
                                                }},
                                              @{@"sp_image":@"icon_tool_union",
                                                @"sp_title":@"联盟活动",
                                                @"sp_action":@"UnionActivityViewController"}]];
        [rowTitleWithImageArray enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray *allData = [NSMutableArray array];
            allData = [ShopModel mj_objectArrayWithKeyValuesArray:obj];
            [_dataSourceAry addObject:allData];
                
        
        }];
        
    }
    return _dataSourceAry;
}
@end
