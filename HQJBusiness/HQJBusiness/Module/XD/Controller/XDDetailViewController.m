//
//  XDViewController.m
//  HQJBusiness
//
//  Created by mymac on 2020/5/17.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDDetailViewController.h"
#import "XDDetailTableViewCell.h"
#import "XDDetailSecCell.h"
#import "XDDetailViewModel.h"
#import "XDDetailBottomView.h"
#import "XDPayViewController.h"
@interface XDDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
}
@property (nonatomic,strong) UITableView *xdTableView;
@property (nonatomic,strong) XDDetailBottomView *bottomView;
@property (nonatomic,assign) XDType xdType;
@property (nonatomic,assign) NSInteger xdState;

@end

@implementation XDDetailViewController

- (instancetype)initWithXDType:(XDType)xdType {
    self = [super init];
    if (self) {
        
        self.xdType = xdType;
        
    }
    return self;
    
}

-(UITableView *)xdTableView {
    if ( _xdTableView == nil ) {
        _xdTableView = [[UITableView alloc]init];
        _xdTableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT- NavigationControllerHeight - 50);
        _xdTableView.backgroundColor = DefaultBackgroundColor;
        _xdTableView.delegate = self;
        _xdTableView.dataSource = self;
        
        [_xdTableView registerClass:[XDDetailTableViewCell class] forCellReuseIdentifier:NSStringFromClass([XDDetailTableViewCell class])];
        [_xdTableView registerClass:[XDDetailSecCell class] forCellReuseIdentifier:NSStringFromClass([XDDetailSecCell class])];
        
        
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 180)];
        iv.image = [UIImage imageNamed:[XDDetailViewModel xdImageBannerArray][self.xdType]];
        _xdTableView.tableHeaderView = iv;
        _xdTableView.tableFooterView = [UIView new];
        
        
    }
    
    return _xdTableView;
}
- (XDDetailBottomView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[XDDetailBottomView alloc]initWithFrame:CGRectMake(0, HEIGHT - 50, WIDTH, 50)];
        _bottomView.priceLabel.text = [NSString stringWithFormat:@"¥%@",[XDDetailViewModel priceArray][self.xdType]];
        [_bottomView.payButton addTarget:self action:@selector(gotoPay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}

#pragma mark --- tableView  data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, 50)];
    view.backgroundColor = DefaultBackgroundColor;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,40/3,WIDTH, 110/3)];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [ManagerEngine getColor:@"333333"];
    label.font = [UIFont boldSystemFontOfSize:16];
    if (section == 0) {
        label.text = @"    国物追溯平台产品及其衍生服务";
    }else{
        label.text = @"    增值服务";
    }
    [view addSubview:label];
    return view;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        
        NSArray *temp = [XDDetailViewModel tempArray][self.xdType][0];
        return temp.count;
        
    }else{
        return 1;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        NSString *temp = [XDDetailViewModel firDataArray][indexPath.row][1];
        return [XDDetailViewModel getStringHeight:temp] + 42;
        
    }else{
        
        return [XDDetailViewModel getSecCellHeight:[XDDetailViewModel tempArray][self.xdType][1]];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        XDDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XDDetailTableViewCell class]) forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLabel.text = [XDDetailViewModel firDataArray][indexPath.row][0];
        cell.descLabel.text = [XDDetailViewModel firDataArray][indexPath.row][1];
        return cell;
    }else{
        XDDetailSecCell *secCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XDDetailSecCell class]) forIndexPath:indexPath];
        secCell.selectionStyle = UITableViewCellSelectionStyleNone;
        secCell.dataArray = [XDDetailViewModel tempArray][self.xdType][1];
        return secCell;
    }
    
    
}

- (void)gotoPay{
    XDPayViewController *payVC = [[XDPayViewController alloc]init];
    payVC.xdType = self.xdType + 1;
    payVC.priceStr = [XDDetailViewModel priceArray][self.xdType];
    [self.navigationController pushViewController:payVC animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DefaultBackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.zwNavView.backgroundColor = DefaultAPPColor;
    [self.zwBackButton setImage:[UIImage imageNamed:@"icon_back_arrow_white"] forState:UIControlStateNormal];
    [self.view addSubview:self.xdTableView];
    [self.view addSubview:self.bottomView];
    
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [XDDetailViewModel getXDShopState:Shopid andPeugeotid:[NSString stringWithFormat:@"%ld",self.xdType+1] completion:^(id  _Nonnull dict) {
        self.xdState = [dict[@"state"] integerValue];
        NSString *stateStr;
        switch (self.xdState) {
            case 1:
                stateStr = @"签第一份合同";
                break;
            case 2:
                stateStr = @"签第2份合同";
                break;
            case 3:
                stateStr = @"签第一份合同";
                break;
            case 4:
                stateStr = @"签第一份合同";
                break;
            case 5:
                stateStr = @"签第一份合同";
                break;
            case 6:
                stateStr = @"签第一份合同";
                break;
            default:
                break;
        }

        [self.bottomView.payButton setTitle:@"立即加入" forState:UIControlStateNormal];
    }];
}

//
//1生成第一份合同(调后台接口生成合同)
//2第一份合同待签署(去签属合同)
//3签署成功(去生成订单)
//4签署失败(跳1)
//5代付款(调支付宝付款)
//6付款成功(生成第份合同)
//7待签署(去签署第二份合同)
//8签署成功(等待待审核)
//9签署失败(跳6 )
//10审核成功
//11审核失败(修改信息,需要修改合同就跳6 ,或者跳8 )

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
