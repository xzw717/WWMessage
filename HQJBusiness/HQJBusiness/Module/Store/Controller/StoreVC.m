//
//  StoreVC.m
//  HQJBusiness
//
//  Created by mymac on 2019/6/24.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "StoreVC.h"
#import "HQJMenu.h"
#import "StoreMainCell.h"
#import "StoreADCell.h"
#import "ScanViewController.h"
#import "StoreViewModel.h"
#import "NewMessageImageView.h"
#import "AppDelegate.h"
#import "ZW_TabBar.h"

#define StoreNavButtonSize 22.f

#define StoreTableViewSpacing 10.f

#define StoreTableViewWidth WIDTH - StoreTableViewSpacing * 2
#define StoreTableViewHeadViewHeight 15.f
#define StoreTableViewCellCornerRadius 5.f



@interface StoreVC ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property (nonatomic, strong) UITableView *storeTabelView;
@property (nonatomic, strong) UIView *setCycleScrollView;
@property (nonatomic, strong) NSMutableDictionary *cellHeightDict;
@property (nonatomic, strong) StoreViewModel *viewModel;
@end

@implementation StoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self storeVC_addViews];
    
}

- (void)storeVC_addViews {
    [self setNavigation];
    [self.view addSubview:self.storeTabelView];
    [self.storeTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(StoreTableViewSpacing);
        make.right.mas_equalTo(-StoreTableViewSpacing);

    }];
}

#pragma mark --- 导航控制器设置
- (void)setNavigation {
    /*消息按钮*/
    NewMessageImageView *messageButton = [[NewMessageImageView alloc]initWithHintStyle:redViewStyleSmallNumber];
    messageButton.image = [UIImage imageNamed:@"nav_message"];
    [messageButton setNumbaer:9];
    messageButton.frame = CGRectMake(0, 0, StoreNavButtonSize, StoreNavButtonSize);
    [messageButton setTapImage:^{
        AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        ZW_TabBar *tab = (ZW_TabBar*)delegate.window.rootViewController;
        [tab didSelectItem:1];
    }];

    UIBarButtonItem *barLeftItem = [[UIBarButtonItem alloc] initWithCustomView:messageButton];
    self.navigationItem.leftBarButtonItem = barLeftItem;
    /*消息按钮*/
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuButton setImage:[UIImage imageNamed:@"nav_more"] forState:UIControlStateNormal];
    menuButton.frame = CGRectMake(0, 0, StoreNavButtonSize, StoreNavButtonSize);
    @weakify(self);
    [menuButton bk_addEventHandler:^(id  _Nonnull sender) {
        @strongify(self);
                [self.viewModel navMenu:sender];
        
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barRightItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    self.navigationItem.rightBarButtonItem = barRightItem;
   
}


#pragma mark --- UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if (indexPath.section == 2) return 53.f;
    StoreMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([StoreMainCell class])];
    NSString *key = [NSString stringWithFormat:@"%ld%ld",indexPath.section,indexPath.row];
    CGFloat height = [self.cellHeightDict[key] floatValue];
    if (height && height != 0) {
        return height;
    } else {
        [self.cellHeightDict setObject:[NSString stringWithFormat:@"%f",[cell cellHeight:self.viewModel.modelAry[indexPath.section]]] forKey:key];
        return [cell cellHeight:self.viewModel.modelAry[indexPath.section]];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return StoreTableViewHeadViewHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.titleAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return 1;
 
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel cellManageWithTableView:tableView cellForRowAtIndexPath:indexPath];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = DefaultBackgroundColor;
    return view;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        CGFloat cornerRadius = StoreTableViewCellCornerRadius;
        cell.backgroundColor = UIColor.clearColor;
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        CGMutablePathRef pathRef = CGPathCreateMutable();
        CGRect bounds = CGRectInset(cell.bounds, 0, 0);
        BOOL addLine = NO;
        
        if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            
        } else if (indexPath.row == 0) {
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            addLine = YES;
            
        } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            
        } else {
            CGPathAddRect(pathRef, nil, bounds);
            addLine = YES;
            
        }
        layer.path = pathRef;
        CFRelease(pathRef);

        //颜色修改
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:1].CGColor;
        layer.strokeColor=[UIColor whiteColor].CGColor;
        
        if (addLine == YES) {
            CALayer *lineLayer = [[CALayer alloc] init];
            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
            lineLayer.backgroundColor = tableView.separatorColor.CGColor;
            [layer addSublayer:lineLayer];
            
        }
        UIView *testView = [[UIView alloc] initWithFrame:bounds];
        [testView.layer insertSublayer:layer atIndex:0];
        testView.backgroundColor = UIColor.clearColor;
        cell.backgroundView = testView;
        
    }

}

#pragma mark ---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel selectCellForIndex:indexPath];
}
- (UIView  *)setCycleScrollView {
    if (!_setCycleScrollView) {
        _setCycleScrollView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH / 3)];
      SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, StoreTableViewHeadViewHeight, WIDTH, WIDTH / 3) delegate:self placeholderImage:[UIImage imageNamed:@"banner02"]];
//        cycleScrollView.backgroundColor = [UIColor greenColor];
        cycleScrollView.layer.masksToBounds = YES;
        cycleScrollView.layer.cornerRadius = StoreTableViewCellCornerRadius;
//        cycleScrollView.imageURLStringsGroup = @[@"banner02"];
        cycleScrollView.currentPageDotColor = [UIColor whiteColor];
        [_setCycleScrollView addSubview:cycleScrollView];
    }
    return _setCycleScrollView;
}


- (UITableView *)storeTabelView {
    if (!_storeTabelView) {
        _storeTabelView = [[UITableView alloc]init];
//        _storeTabelView.frame = CGRectMake(StoreTableViewSpacing, 0 , StoreTableViewWidth, HEIGHT - NavigationControllerHeight);
        _storeTabelView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _storeTabelView.separatorStyle =  UITableViewCellSeparatorStyleNone;
//        _storeTabelView.estimatedRowHeight = 100.f;
        _storeTabelView.delegate = self;
        _storeTabelView.dataSource = self;
        _storeTabelView.showsVerticalScrollIndicator = NO;
        [_storeTabelView registerClass:[StoreADCell class] forCellReuseIdentifier:NSStringFromClass([StoreADCell class])];

        [_storeTabelView registerClass:[StoreMainCell class] forCellReuseIdentifier:NSStringFromClass([StoreMainCell class])];
        _storeTabelView.tableFooterView = [UIView new];
        _storeTabelView.tableHeaderView = self.setCycleScrollView;
        
    }
    return _storeTabelView;
}

- (NSMutableDictionary *)cellHeightDict {
    if (!_cellHeightDict) {
        _cellHeightDict = [NSMutableDictionary dictionary];
    }
    return _cellHeightDict;
}
- (StoreViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[StoreViewModel alloc]initWithTargetObjct:self];
        _viewModel.vm_storetableView = self.storeTabelView;
    }
    return _viewModel;
}
@end
