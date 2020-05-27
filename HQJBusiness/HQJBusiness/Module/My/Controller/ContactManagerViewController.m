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
#import "ContactManagerCell.h"
#import "HQJWebViewController.h"
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
        [_tableView registerClass:[ContactManagerCell class] forCellReuseIdentifier:NSStringFromClass([ContactManagerCell class])];
        
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
    NSInteger type;
    if (self.topTag == 0) {
        type=2;
    }else{
        type=1;
    }
    [ContactManagerViewModel getContactManagerList:Shopid andSignResul:type completion:^(NSArray<ContactModel *> * _Nonnull list) {
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
    ContactManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ContactManagerCell class]) forIndexPath:indexPath];
    
    //"type": 1,      ----1：物联网新商业 2：国家追溯平台
    //            "signUrl": "合同预览签署地址",
    //"peugeotid": 3,   -----标识id
    //            "signtime": "签署时间"
    ContactModel *model = self.dataArray[indexPath.row];
    NSMutableString *result = [[NSMutableString alloc]init];
    if ([model.type isEqualToString:@"1"]) {
        [result appendString:@"物联网新商业"];
    }else{
        [result appendString:@"国家追溯平台"];
    }

    switch (model.peugeotid.integerValue) {
        case 1://标识企业
            [result appendString:@"(标识企业)"];
            
            break;
            
        case 2://异盟企业
            [result appendString:@"(异盟企业)"];
            
            break;
            
        case 3://标杆企业
            [result appendString:@"(标杆企业)"];
            
            break;
            
        case 4://兄弟企业
            [result appendString:@"(兄弟企业)"];
            
            break;
            
        case 5://生态企业
            [result appendString:@"(生态企业)"];
            break;
    }
    [result appendString:@"合同"];
    
    [cell setTitle:result];
    return cell;
    
}
#pragma mark ---UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactModel *model = self.dataArray[indexPath.row];
    if (model.signUrl) {
        HQJWebViewController *webVC = [[HQJWebViewController alloc]init];
        webVC.webUrlStr = model.signUrl;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    
}


@end
