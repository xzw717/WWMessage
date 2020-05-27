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
#import "HQJWebViewController.h"
@interface XDDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
}
@property (nonatomic,strong) UITableView *xdTableView;
@property (nonatomic,strong) XDDetailBottomView *bottomView;
@property (nonatomic,assign) XDType xdType;
@property (nonatomic,strong) NSDictionary *resultDict;

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
        [_bottomView.payButton addTarget:self action:@selector(handleXDState) forControlEvents:UIControlEventTouchUpInside];
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

- (NSString *)getButtonString{
    switch ([self.resultDict[@"state"] integerValue]) {
        case -1://-1 不可用
            return @"不可申请";

        case 0://0 信息未完善
            return @"立即加入";

        case 1://1 信息已完善，去生成第一份合同
            return @"签署新商业合同";

        case 2://2 第一份合同未签署，去签署第一份合同
            return @"签署新商业合同";

        case 3://3 第一份合同签署完成，去生成订单
            return @"立即支付";

        case 4://4 第一份合同签署失败，重新生成第一份合同（同步骤1）
            return @"签署新商业合同";

        case 5://5 订单已生成，待付款，跳支付页准备付款
            return @"立即支付";

        case 6://6 订单已支付，去生成第二份合同
            return @"签署国物溯源协议";

        case 7://7 第二份合同未签署，去签署第二份合同
            return @"签署国物溯源协议";

        case 8://8 第二份合同签署完成，等待审核
            return @"审核中";

        case 9://9 第二份合同签署失败，重新生成第二份合同（同步骤6）
            return @"签署国物溯源协议";

        case 10://10审核成功，流程结束
            return @"审核成功";

        case 11://11 审核失败，修改信息
            return @"修改信息";
    }
    return @"";
}

- (void)handleXDState{
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
    if (self.resultDict) {
        switch ([self.resultDict[@"state"] integerValue]) {
            case -1://-1 不可用
                [SVProgressHUD showErrorWithStatus:@"当前状态暂不支持申请"];
                break;
                
            case 0://0 信息未完善
                //跳转信息填写H5页
                [self jumpH5:[NSString stringWithFormat:@"%@assets/xdESign/index.html#/xdshopmsg?shopid=%@&mobile=%@&type=1&peugeotid=%@",HQJBDomainName,Shopid,[NameSingle shareInstance].mobile,[NSString stringWithFormat:@"%ld",self.xdType+1]]];
                break;
                
            case 1://1 信息已完善，去生成第一份合同
            case 4://4 第一份合同签署失败，重新生成第一份合同（同步骤1）
                //去生成第一份合同
                [self createContract:1];
                break;
                
            case 2://2 第一份合同未签署，去签署第一份合同
            case 7://7 第二份合同未签署，去签署第二份合同
                //跳转H5去签署合同
                [self jumpH5:self.resultDict[@"data"]];
                break;
                
            case 3://3 第一份合同签署完成，去生成订单
                [self createOreder];
                break;
                
            case 5://5 订单已生成，待付款，跳支付页准备付款
                //跳转支付页
                [self jumpPay];

                break;
                
            case 6://6 订单已支付，去生成第二份合同
            case 9://9 第二份合同签署失败，重新生成第二份合同（同步骤6）
                //去生成第二份合同
                [self createContract:2];
                break;
                
            case 8://8 第二份合同签署完成，等待审核
                [SVProgressHUD showSuccessWithStatus:@"等待审核"];
                break;
                
            case 10://10 审核成功，流程结束
                break;
                
            case 11://11 审核失败，修改信息
                [ManagerEngine SVPAfter:self.resultDict[@"errdata"] complete:^{
                    // 跳转信息填写H5页
                    [self jumpH5:[NSString stringWithFormat:@"%@assets/xdESign/index.html#/xdshopmsg?shopid=%@&mobile=%@&type=3&peugeotid=%@",HQJBDomainName,Shopid,[NameSingle shareInstance].mobile,[NSString stringWithFormat:@"%ld",self.xdType+1]]];
                }];
                
                break;
        }
    }
    
}

- (void)jumpH5:(NSString *)url{
    
    HQJWebViewController *webVC = [[HQJWebViewController alloc]init];
    webVC.webUrlStr = url;
    [self.navigationController pushViewController:webVC animated:YES];
    
}
- (void)createContract:(NSInteger)type{
    [XDDetailViewModel initiateESign:Shopid andType:[NSString stringWithFormat:@"%ld",type] andState:@"1" andPeugeotid:[NSString stringWithFormat:@"%ld",self.xdType+1] completion:^(id  _Nonnull result) {
        
        [self jumpH5:(NSString *)result];
        
    }];
}
- (void)createOreder{
    [XDDetailViewModel submitXDOrder:Shopid andProid:[NSString stringWithFormat:@"%ld",self.xdType+1] andPrice:[XDDetailViewModel priceArray][self.xdType] completion:^(XDPayModel *model) {
        XDPayViewController *payVC = [[XDPayViewController alloc]initWithXDPayModel:model];
        [self.navigationController pushViewController:payVC animated:YES];
        
    }];
}
- (void)jumpPay{
    //            "state": 5,
    //"orderdata":
    //{
    //"orderid": 2,
    //"shopid": 2,
    //"proid": 2,
    //"ordermoney": 2
    XDPayModel *model = [[XDPayModel alloc]init];
    model.orderid = self.resultDict[@"orderdata"][@"orderid"];
    model.ordermoney = self.resultDict[@"orderdata"][@"ordermoney"];
    model.proid = self.resultDict[@"orderdata"][@"proid"];
    XDPayViewController *payVC = [[XDPayViewController alloc]initWithXDPayModel:model];
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
        self.resultDict = dict;
        [self.bottomView.payButton setTitle:[self getButtonString] forState:UIControlStateNormal];
    }];
}




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
