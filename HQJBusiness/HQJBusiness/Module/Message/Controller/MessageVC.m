//
//  MessageVC.m
//  HQJBusiness
//
//  Created by mymac on 2019/6/24.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageVC.h"
#import "MessageTopTAB.h"
#import "MessageViewModel.h"
#import "MessageGeneralCell.h"

#define MessageNavButtonSize (22.f)
#define MessageBlueBackgroundViewHeight (280 / 3.f)
#define MessageTopTABcornerRadius (10.f)
#define MessageTopTABHeight (100.f)
#define MessageTopTABEdge (10.f)

@interface MessageVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>{
    NSInteger _topBtnTag;
}
@property (nonatomic, strong) UITableView *messageTabelView;
@property (nonatomic, strong) MessageViewModel *viewModel;
@property (nonatomic, strong) MessageTopTAB *tabView;
@property (nonatomic, strong) NSMutableArray  *dataAry;
@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self messageVC_addSubView];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeMessage:) name:ChangeMessageNotification object:nil];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
  
}

- (void)changeMessage:(NSNotificationCenter *)notifi {
    [_tabView addMessageNotice:1 messageCount:21];
}

- (void)messageVC_addSubView {
    [self setNav];
    [self setTopView];
    [self setBottomView];
}


- (void)setTopView {
    UIView *blueBackgroundView = [[UIView alloc]init];
    blueBackgroundView.backgroundColor = DefaultAPPColor;
    [self.view addSubview:blueBackgroundView];
    [blueBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(MessageBlueBackgroundViewHeight);
        
    }];
    
    self.tabView = [[MessageTopTAB alloc]init];
    self.tabView.backgroundColor = [UIColor whiteColor];
    self.tabView.layer.masksToBounds = YES;
    self.tabView.layer.cornerRadius = MessageTopTABcornerRadius;
    [self.view addSubview:self.tabView];
    [_tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MessageTopTABEdge);
        make.right.mas_equalTo(-MessageTopTABEdge);
        make.bottom.mas_equalTo(blueBackgroundView.mas_bottom).mas_offset(kEDGE);
        make.height.mas_equalTo(MessageTopTABHeight);
    }];
    self.viewModel.tabViwe = _tabView;
    _tabView.topViewSelectBlock = self.viewModel.topViewSelectViewModle;


}

- (void)setBottomView {
    [self.view addSubview:self.messageTabelView];
    [self.messageTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tabView.mas_bottom);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.right.mas_equalTo(0);
    }];
}

- (void)setNav {
    /*消息按钮*/
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuButton setImage:[UIImage imageNamed:@"nav_more"] forState:UIControlStateNormal];
    menuButton.frame = CGRectMake(0, 0, MessageNavButtonSize, MessageNavButtonSize);
    @weakify(self);
    [menuButton bk_addEventHandler:^(id  _Nonnull sender) {
        @strongify(self);
        [self.viewModel messageMenu:sender];
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barRightItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    self.navigationItem.rightBarButtonItem = barRightItem;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.viewModel.dataAry.count;
 
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageGeneralCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MessageGeneralCell class]) forIndexPath:indexPath];
    if (indexPath.row != 2) {
        [cell unreadMessage];
    } else {
        [cell readMessage];
    }
    return cell;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"news-NullState"];
}

- (MessageViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MessageViewModel alloc]init];
        _viewModel.vm_messageTableView = self.messageTabelView;
    }
    return _viewModel;
}

- (UITableView *)messageTabelView {
    if (!_messageTabelView) {
        _messageTabelView = [[UITableView alloc]init];
        _messageTabelView.delegate = self;
        _messageTabelView.dataSource = self;
        _messageTabelView.rowHeight = 230/3.f;
        _messageTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_messageTabelView registerClass:[MessageGeneralCell class] forCellReuseIdentifier:NSStringFromClass([MessageGeneralCell class])];
        _messageTabelView.tableFooterView = [UIView new];
        _messageTabelView.backgroundColor = DefaultBackgroundColor;
        _messageTabelView.emptyDataSetSource = self;
        _messageTabelView.emptyDataSetDelegate = self;
    }
    return _messageTabelView;
}
@end
