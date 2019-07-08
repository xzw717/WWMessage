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
@property (nonatomic, strong) UITableView *messageOrderTabelView;
@property (nonatomic, strong) UITableView *messageImportantTabelView;
@property (nonatomic, strong) UITableView *messageOtherTabelView;

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
    [self.view addSubview:self.messageOrderTabelView];
    [self.messageOrderTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tabView.mas_bottom);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.right.mas_equalTo(0);
    }];
    [self.view addSubview:self.messageImportantTabelView];
    [self.messageImportantTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tabView.mas_bottom);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.right.mas_equalTo(0);
    }];
    [self.view addSubview:self.messageOtherTabelView];
    [self.messageOtherTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    NSLog(@"%ld",tableView.tag);

    if (self.messageOrderTabelView == tableView) {
        return self.viewModel.dataAry.count;

    } else {
        return self.viewModel.dataOtherAry.count;

    }
 
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
        _viewModel.vm_messageTableViews= @[self.messageOrderTabelView,self.messageImportantTabelView,self.messageOtherTabelView];
    }
    return _viewModel;
}

- (UITableView *)messageOrderTabelView {
    if (!_messageOrderTabelView) {
        _messageOrderTabelView = [[UITableView alloc]init];
        _messageOrderTabelView.delegate = self;
        _messageOrderTabelView.dataSource = self;
        _messageOrderTabelView.rowHeight = 230/3.f;
        _messageOrderTabelView.hidden = NO;
        _messageOrderTabelView.tag = 10000;
        _messageOrderTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_messageOrderTabelView registerClass:[MessageGeneralCell class] forCellReuseIdentifier:NSStringFromClass([MessageGeneralCell class])];
        _messageOrderTabelView.tableFooterView = [UIView new];
        _messageOrderTabelView.backgroundColor = DefaultBackgroundColor;
        _messageOrderTabelView.emptyDataSetSource = self;
        _messageOrderTabelView.emptyDataSetDelegate = self;
    }
    return _messageOrderTabelView;
}
- (UITableView *)messageImportantTabelView {
    if (!_messageImportantTabelView) {
        _messageImportantTabelView = [[UITableView alloc]init];
        _messageImportantTabelView.delegate = self;
        _messageImportantTabelView.dataSource = self;
        _messageImportantTabelView.rowHeight = 230/3.f;
        _messageImportantTabelView.hidden = YES;
        _messageImportantTabelView.tag = 10001;
        _messageImportantTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_messageImportantTabelView registerClass:[MessageGeneralCell class] forCellReuseIdentifier:NSStringFromClass([MessageGeneralCell class])];
        _messageImportantTabelView.tableFooterView = [UIView new];
        _messageImportantTabelView.backgroundColor = DefaultBackgroundColor;
        _messageImportantTabelView.emptyDataSetSource = self;
        _messageImportantTabelView.emptyDataSetDelegate = self;
    }
    return _messageImportantTabelView;
}
- (UITableView *)messageOtherTabelView {
    if (!_messageOtherTabelView) {
        _messageOtherTabelView = [[UITableView alloc]init];
        _messageOtherTabelView.delegate = self;
        _messageOtherTabelView.dataSource = self;
        _messageOtherTabelView.rowHeight = 230/3.f;
        _messageOrderTabelView.hidden = YES;
        _messageOrderTabelView.tag = 10002;
        _messageOtherTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_messageOtherTabelView registerClass:[MessageGeneralCell class] forCellReuseIdentifier:NSStringFromClass([MessageGeneralCell class])];
        _messageOtherTabelView.tableFooterView = [UIView new];
        _messageOtherTabelView.backgroundColor = DefaultBackgroundColor;
        _messageOtherTabelView.emptyDataSetSource = self;
        _messageOtherTabelView.emptyDataSetDelegate = self;
    }
    return _messageOtherTabelView;
}
@end
