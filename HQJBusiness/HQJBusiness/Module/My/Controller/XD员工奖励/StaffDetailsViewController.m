//
//  StaffDetailsViewController.m
//  HQJBusiness
//   员工详情页
//  Created by mymac on 2020/7/28.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "StaffDetailsViewController.h"
#import "StaffdetailsHeaderView.h"
#import "StaffDetailsVC.h"
#import "InvitedRecordViewController.h"
#import "RewardsRecordViewController.h"
#import "SGSegmentedControlBottomView.h"
#import "QRCodeView.h"
#import "MemberStaffModel.h"
#import "StaffDetailsViewModel.h"
@interface StaffDetailsViewController ()<UIScrollViewDelegate,SGSegmentedControlStaticDelegate>
@property (nonatomic, strong) StaffdetailsHeaderView *headerView;
@property (nonatomic, strong) SGSegmentedControlStatic *topSView;
@property (nonatomic, strong) SGSegmentedControlBottomView *bottomSView;
@property (nonatomic, strong) UIButton *editorButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, assign) listStyle style;
@property (nonatomic, strong) MemberStaffModel *model;
@end

@implementation StaffDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initVC];

}
- (void)initView {
    [self.zwBackButton setImage:[UIImage imageNamed:self.style == stafflistStyle ? @"icon_Return_02" : @"icon_Return_01"] forState:UIControlStateNormal];
//    [self.zw_rightOneButton set];
    UIButton *qrCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    qrCodeButton.frame = CGRectMake(0, 0, 20, 20);
    [qrCodeButton setImage:[UIImage imageNamed:@"my_icon_ewm"] forState:UIControlStateNormal];
    [qrCodeButton addTarget:self action:@selector(showQRCode) forControlEvents:UIControlEventTouchUpInside];
    self.zw_rightOneButton =  qrCodeButton;
    self.zw_rightOneButton.hidden = self.style == stafflistStyle ? NO : YES;
     [self setNavBackgroundColor:[ManagerEngine getColor:@"f5f5f5"] alpha:0.f];
     [self.view addSubview:self.headerView];
     
     [self.view bringSubviewToFront:self.zwNavView];
    self.headerView.image = [UIImage imageNamed:self.style == stafflistStyle ? @"Listbackground" : @"VIPbackground"];

     [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.right.left.mas_equalTo(0);
         make.height.mas_equalTo(NavigationControllerHeight + NewProportion(710));
     }];
    [self.view addSubview:self.deleteButton];
    [self.view addSubview:self.editorButton];
    [self.editorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-NewProportion(140));
        make.left.mas_equalTo(NewProportion(407));
        make.width.mas_equalTo(NewProportion(80));
        make.height.mas_equalTo(NewProportion(150));
    }];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.mas_equalTo(-NewProportion(407));
         make.centerY.width.height.mas_equalTo(self.editorButton);
     }];
}
- (void)showQRCode {
    @weakify(self);
    [StaffDetailsViewModel getQrCodeWithStaffID:self.model.nid completion:^(NSString * _Nonnull imageUrl) {
        @strongify(self);
        [QRCodeView showQrCode].
        company([NameSingle shareInstance].name).
        name(self.model.nickname).
        phone(self.model.mobile).
        qrCode(imageUrl);

    }];
}
- (void)removeStaff {
    [StaffDetailsViewModel removeStaffWithStaffID:self.model.nid];
}
- (instancetype)initWithDetailsStyle:(listStyle)style objectModel:(nonnull MemberStaffModel *)model{
    self = [super init];
    if (self) {
        self.style = style;
        self.model = model;
    }
    return self;
}
-(void)initVC {
    StaffDetailsVC *sdVC = [[StaffDetailsVC alloc]initWithDetalisStyle:self.style detaliModel:self.model];
    [self addChildViewController:sdVC];
    
    InvitedRecordViewController *irZHVC = [[InvitedRecordViewController alloc]initRecordWithStyle:self.style detaliModel:self.model];
    [self addChildViewController:irZHVC];
    
    NSArray *childVC = @[sdVC, irZHVC];
    
    NSArray *title_arr = @[@"详情",self.style == stafflistStyle ? @"邀请记录":@"消费记录"];
    
    self.bottomSView = [[SGSegmentedControlBottomView alloc] initWithFrame:CGRectMake(0, NavigationControllerHeight + NewProportion(710) , WIDTH, HEIGHT - NavigationControllerHeight - NewProportion(710))];
    _bottomSView.childViewController = childVC;
    _bottomSView.backgroundColor = [UIColor clearColor];
    _bottomSView.delegate = self;
    [self.view addSubview:_bottomSView];
    
    self.topSView = [SGSegmentedControlStatic segmentedControlWithFrame:CGRectMake(0, NavigationControllerHeight + NewProportion(710) , WIDTH, 44) delegate:self childVcTitle:title_arr indicatorIsFull:NO];
    
    // 必须实现的方法
    [self.topSView SG_setUpSegmentedControlType:nil];
    
    [self.topSView SG_setUpSegmentedControlStyle:^(UIColor *__autoreleasing *segmentedControlColor, UIColor *__autoreleasing *titleColor, UIColor *__autoreleasing *selectedTitleColor, UIColor *__autoreleasing *indicatorColor, BOOL *isShowIndicor) {
        *indicatorColor = DefaultAPPColor;
        *isShowIndicor = YES;
    }];
    self.topSView.selectedIndex = 0;
    
    _topSView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topSView];
    [self.view bringSubviewToFront:self.editorButton];
    [self.view bringSubviewToFront:self.deleteButton];
}

- (void)SGSegmentedControlStatic:(SGSegmentedControlStatic *)segmentedControlStatic didSelectTitleAtIndex:(NSInteger)index  {
    // 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.bottomSView.contentOffset = CGPointMake(offsetX, 0);
    [self.bottomSView showChildVCViewWithIndex:index outsideVC:self];
    if (self.style == stafflistStyle) {
        self.editorButton.hidden = self.deleteButton.hidden = index == 0 ? NO : YES;
    }
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if(scrollView == _bottomSView) {
        
        // 计算滚动到哪一页
        NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
        
        // 1.添加子控制器view
        [self.bottomSView showChildVCViewWithIndex:index outsideVC:self];
        
        // 2.把对应的标题选中
        [self.topSView changeThePositionOfTheSelectedBtnWithScrollView:scrollView];
        if (self.style == stafflistStyle) {
            self.editorButton.hidden = self.deleteButton.hidden = index == 0 ? NO : YES;
        }
        
    }
    
}
- (StaffdetailsHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[StaffdetailsHeaderView alloc]init];
        _headerView.headerModel = self.model;
    }
    return _headerView;
}
- (UIButton *)editorButton {
    if (!_editorButton) {
        _editorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editorButton setImage:[UIImage imageNamed:@"icon_edit_1"] forState:UIControlStateNormal];
        [_editorButton setTitle:@"编辑" forState:UIControlStateNormal];
        _editorButton.titleLabel.font = [UIFont systemFontOfSize:NewProportion(40)];
        [_editorButton setTitleColor:[ManagerEngine getColor:@"777777"] forState:UIControlStateNormal];
        [_editorButton setTitleEdgeInsets:UIEdgeInsetsMake(50, 22, 5, 0)];
        [_editorButton setImageEdgeInsets:UIEdgeInsetsMake(5, 25, 15, 25)];
        _editorButton.hidden = self.style == stafflistStyle ? NO : YES;

    }
    return _editorButton;
}
- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:[UIImage imageNamed:@"icon_trash_1"] forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:NewProportion(40)];
            [_deleteButton setTitleColor:[ManagerEngine getColor:@"777777"] forState:UIControlStateNormal];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleEdgeInsets:UIEdgeInsetsMake(50, 22, 5, 0)];
        [_deleteButton setImageEdgeInsets:UIEdgeInsetsMake(5, 25, 15, 25)];
        _deleteButton.hidden = self.style == stafflistStyle ? NO : YES;
        [_deleteButton addTarget:self action:@selector(removeStaff) forControlEvents:UIControlEventTouchUpInside];

    }
    return _deleteButton;
}
@end
