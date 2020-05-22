//
//  ContactManagerViewController.m
//  HQJBusiness
//
//  Created by 姚志中 on 2020/5/21.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ContactManagerViewController.h"
#import "ContactManagerHeadView.h"
#import "ContactManagerViewModel.h"
#import "ContactModel.h"
#define TableViewCellHeight 140.f/3
#define HeadHeight  132/3.f
#define TableViewTopSpace 40/3.f
@interface ContactManagerViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, assign) NSInteger topTag;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ContactManagerHeadView *headView;
@property (nonatomic, strong) NSArray <ContactModel *>*dataArray;
@end

@implementation ContactManagerViewController

-(UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight);
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.tableHeaderView = self.headView;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        
    }
    
    return _tableView;
}

- (ContactManagerHeadView *)headView{
    if (_headView == nil) {
        _headView = [[ContactManagerHeadView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, HeadHeight) andTitleArray:@[@"已签合同",@"待签合同"]];
        _headView.selectIndex = 0;
        @weakify(self);
        [_headView setItemBlock:^(NSInteger selectedIndex) {
            @strongify(self);
            self.topTag = selectedIndex;
            [self requsetData];
        }];
    }
    return _headView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    self.zwTitLabel.text = @"合同管理";
    [self addSubViews];
    [self requsetData];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)addSubViews{
    [self.view addSubview:self.tableView];
}
- (void)requsetData{
    [ContactManagerViewModel getContactManagerList:@"f46d46d8-debc-4d48-a08c-78cc857d2ae1" andSignResul:self.topTag+1 completion:^(NSArray<ContactModel *> * _Nonnull list) {
        self.dataArray = list;
        [self.tableView reloadData];
    }];
}
#pragma mark --- UITableViewDataSource


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return TableViewTopSpace;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TableViewCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   static NSString *cellId = @"ContactManagercell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    ContactModel *model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [ManagerEngine getColor:@"666666"];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.text = model.type;
    cell.detailTextLabel.textColor = [ManagerEngine getColor:@"ff4949"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.text = @"待审核";
    return cell;
    
}
#pragma mark ---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


@end
