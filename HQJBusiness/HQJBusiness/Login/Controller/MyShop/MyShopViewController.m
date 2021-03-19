//
//  RegisterViewController.m
//  HQJBusiness
//
//  Created by 姚 on 2019/6/26.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MyShopViewController.h"
#import "HintView.h"
#import "HQJWebViewController.h"
#import "HQJLocationManager.h"
#import "XDDetailViewModel.h"

#import "XDPayViewController.h"
#define TopSpace 40/3.f

@interface MyShopViewController ()

@property (nonatomic,strong)UIView *shopNameView;
@property (nonatomic,strong)UILabel *shopNameLabel;
@property (nonatomic,strong)UILabel *shopNameValueLabel;
@property (nonatomic,strong)UIView *snBottomView;

@property (nonatomic,strong)UIView *mobileView;
@property (nonatomic,strong)UILabel *mobileLabel;
@property (nonatomic,strong)UILabel *mobileValueLabel;
@property (nonatomic,strong)UIView *mbBottomView;

@property (nonatomic,strong)UIView *applyTimeView;
@property (nonatomic,strong)UILabel *applyTimeLabel;
@property (nonatomic,strong)UILabel *applyTimeValueLabel;
@property (nonatomic,strong)UIView *tmBottomView;

@property (nonatomic,strong)UIView *bonusView;
@property (nonatomic,strong)UILabel *bonusLabel;
@property (nonatomic,strong)UILabel *bonusValueLabel;

@property (nonatomic,strong)UIView *stateView;
@property (nonatomic,strong)UILabel *stateLabel;
@property (nonatomic,strong)UILabel *stateValueLabel;
@property (nonatomic, strong) HintView *showView;
/// 失败原因
@property (nonatomic, strong) NSString *reason;

/// 对应状态的URL
@property (nonatomic, strong) NSString *signUrl;

/// 客服电话
@property (nonatomic, strong) UILabel *phoneLabel;

@property (nonatomic,strong)NSString *shopidString;
/// 纬度
@property (nonatomic, assign) CGFloat latitude ;
/// 经度
@property (nonatomic, assign) CGFloat longitude ;
@property (nonatomic,strong) XDModel *model;
@property (nonatomic,strong) NSDictionary *resultDict;

/// XD 商家独立入驻
@property (nonatomic, assign) CGFloat roleValue;
@property (nonatomic, assign) NSInteger code;

@property (nonatomic, assign) CGFloat price;

@end

@implementation MyShopViewController

#pragma lazy-load

- (UIView *)shopNameView{
    if (_shopNameView == nil) {
        _shopNameView = [[UIView alloc]init];
        _shopNameView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_shopNameView];
    }
    return _shopNameView;
}

- (UILabel *)shopNameLabel{
    if ( _shopNameLabel == nil ) {
        _shopNameLabel = [[UILabel alloc]init];
        _shopNameLabel.font = [UIFont systemFontOfSize:16];
        _shopNameLabel.text = @"店铺简称";
        [self.shopNameView addSubview:_shopNameLabel];
        
    }
    
    return _shopNameLabel;
}
-(UILabel *)shopNameValueLabel {
    if ( _shopNameValueLabel == nil ) {
        _shopNameValueLabel = [[UILabel alloc]init];
        _shopNameValueLabel.font = [UIFont systemFontOfSize:16];
        _shopNameValueLabel.text = @"";
        _shopNameValueLabel.textAlignment = NSTextAlignmentRight;
        [self.shopNameView addSubview:_shopNameValueLabel];
    }
    
    return _shopNameValueLabel;
}
- (UIView *)snBottomView{
    if ( _snBottomView  == nil ) {
        _snBottomView = [[UIView alloc]init];
        _snBottomView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
        [self.shopNameView addSubview:_snBottomView];
    }
    return _snBottomView;
}


- (UIView *)mobileView{
    if (_mobileView == nil) {
        _mobileView = [[UIView alloc]init];
        _mobileView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_mobileView];
    }
    return _mobileView;
}

- (UILabel *)mobileLabel{
    if ( _mobileLabel == nil ) {
        _mobileLabel = [[UILabel alloc]init];
        _mobileLabel.font = [UIFont systemFontOfSize:16];
        _mobileLabel.text = @"手机号码";
        [self.mobileView addSubview:_mobileLabel];
        
    }
    
    return _mobileLabel;
}

-(UILabel *)mobileValueLabel {
    if ( _mobileValueLabel == nil ) {
        _mobileValueLabel = [[UILabel alloc]init];
        _mobileValueLabel.font = [UIFont systemFontOfSize:16];
        _mobileValueLabel.text = @"13888377734";
        _mobileValueLabel.textAlignment = NSTextAlignmentRight;
        [self.mobileView addSubview:_mobileValueLabel];
    }
    
    return _mobileValueLabel;
}
- (UIView *)mbBottomView{
    if ( _mbBottomView  == nil ) {
        _mbBottomView = [[UIView alloc]init];
        _mbBottomView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
        [self.mobileView addSubview:_mbBottomView];
    }
    return _mbBottomView;
}

- (UIView *)applyTimeView{
    if (_applyTimeView == nil) {
        _applyTimeView = [[UIView alloc]init];
        _applyTimeView.backgroundColor = [UIColor whiteColor];
    
        [self.view addSubview:_applyTimeView];
    }
    return _applyTimeView;
}

- (UILabel *)applyTimeLabel{
    if ( _applyTimeLabel == nil ) {
        _applyTimeLabel = [[UILabel alloc]init];
        _applyTimeLabel.font = [UIFont systemFontOfSize:16];
        _applyTimeLabel.text = @"申请时间";
        [self.applyTimeView addSubview:_applyTimeLabel];
        
    }
    
    return _applyTimeLabel;
}

- (UIView *)tmBottomView{
    if ( _tmBottomView  == nil ) {
        _tmBottomView = [[UIView alloc]init];
        _tmBottomView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
        [self.applyTimeView addSubview:_tmBottomView];
    }
    return _tmBottomView;
}
-(UILabel *)applyTimeValueLabel {
    if ( _applyTimeValueLabel == nil ) {
        _applyTimeValueLabel = [[UILabel alloc]init];
        _applyTimeValueLabel.font = [UIFont systemFontOfSize:16];
        _applyTimeValueLabel.textAlignment = NSTextAlignmentRight;
        _applyTimeValueLabel.text = @"2017-12-21";
        [self.applyTimeView addSubview:_applyTimeValueLabel];
    }
    
    return _applyTimeValueLabel;
}

- (UIView *)stateView{
    if (_stateView == nil) {
        _stateView = [[UIView alloc]init];
        _stateView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickState:)];
        [_stateView addGestureRecognizer:tap];
        _stateView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_stateView];
    }
    return _stateView;
}
-(UILabel *)stateLabel {
    if ( _stateLabel == nil ) {
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.font = [UIFont systemFontOfSize:16.f];
        _stateLabel.text = @"状态";
        [self.stateView addSubview:_stateLabel];
    }
    
    return _stateLabel;
}
- (UILabel *)stateValueLabel {
    if ( _stateValueLabel == nil ) {
        _stateValueLabel = [[UILabel alloc]init];
        _stateValueLabel.font = [UIFont systemFontOfSize:16.f];
        _stateValueLabel.textAlignment = NSTextAlignmentRight;
        _stateValueLabel.textColor = [ManagerEngine getColor:@"ff4949"];
        [self.stateView addSubview:_stateValueLabel];
    }
    
    return _stateValueLabel;
}
- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.text = @"客服热线：4000591081";
        _phoneLabel.textColor = [UIColor blackColor];
        _phoneLabel.font = [UIFont systemFontOfSize:14.f];
        _phoneLabel.textAlignment = NSTextAlignmentCenter;
        _phoneLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickPhone:)];
        [_phoneLabel addGestureRecognizer:tap];
        [self.view addSubview:_phoneLabel];
    }
    return _phoneLabel;
}


- (UIView *)bonusView{
    if (_bonusView == nil) {
        _bonusView = [[UIView alloc]init];
        _bonusView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_bonusView];
    }
    return _bonusView;
}
- (UILabel *)bonusLabel{
    if ( _bonusLabel == nil ) {
        _bonusLabel = [[UILabel alloc]init];
        _bonusLabel.font = [UIFont systemFontOfSize:16];
        _bonusLabel.text = @"活动积分";
        [self.bonusView addSubview:_bonusLabel];
        
    }
    
    return _bonusLabel;
}

-(UILabel *)bonusValueLabel {
    if ( _bonusValueLabel == nil ) {
        _bonusValueLabel = [[UILabel alloc]init];
        _bonusValueLabel.font = [UIFont systemFontOfSize:16];
        _bonusValueLabel.textAlignment = NSTextAlignmentRight;
        _bonusValueLabel.text = @"20000.00000     个";
        [self.bonusView addSubview:_bonusValueLabel];
    }
    
    return _bonusValueLabel;
}
- (void)clickState:(UITapGestureRecognizer *)tap {
    if ( self.code != 6666 && self.roleValue == 7) {
            [self handleXDState:NO];


    } else  if ( self.code != 6666 && self.roleValue == 8) {
        [self handleXDState:YES];

    }  else {
        HQJWebViewController *pvc = [[HQJWebViewController alloc]init];
        pvc.zwNavView.hidden = YES;
          if ([self.stateValueLabel.text isEqualToString:@"去开店"]) {
              pvc.webUrlStr = [NSString stringWithFormat:@"%@%@?shopid=%@&lat=%f&lng=%f",HQJBH5UpDataDomain,HQJBNewstoreListInterface,self.shopidString,self.latitude,self.longitude];
              
              
          } else if ([self.stateValueLabel.text isEqualToString:@"审核成功"]) {
              [HintView enrichSubviews:@"重新登录即可获取完整体验" andSureTitle:@"去登录" cancelTitle:@"取消" sureAction:^{
                  [ManagerEngine login];
              }];
              return;
          } else if ([self.stateValueLabel.text isEqualToString:@"审核失败"]) {
              @weakify(self);
              [HintView enrichSubviews:[NSString stringWithFormat:@"%@",self.reason] andSureTitle:@"修改" cancelTitle:@"取消" sureAction:^{
                  @strongify(self);
                  pvc.webUrlStr = [NSString stringWithFormat:@"%@%@?shopid=%@&lat=%f&lng=%f",HQJBH5UpDataDomain,HQJBNewstoreListInterface,self.shopidString,self.latitude,self.longitude];
                  [self.navigationController pushViewController:pvc animated:YES];
              }];
               return;
          } else if ([self.stateValueLabel.text isEqualToString:@"待实名认证"]) {
              pvc.webUrlStr = [NSString stringWithFormat:@"%@%@?shopid=%@&lat=%f&lng=%f",HQJBH5UpDataDomain,HQJBNewstoreListInterface,self.shopidString,self.latitude,self.longitude];
          } else if ([self.stateValueLabel.text isEqualToString:@"发起合同"]) {
              
          } else if ([self.stateValueLabel.text isEqualToString:@"签署合同"]) {
              pvc.webUrlStr = self.signUrl;
          } else {
              return;
          }
          [self.navigationController pushViewController:pvc animated:YES];

        
    }
}
#pragma click method

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

     [self requstState];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"我的店铺";
    [self.view setBackgroundColor:[ManagerEngine getColor:@"f7f7f7"]];
    [self layoutTheSubViews];
    [SVProgressHUD showWithStatus:@"获取定位中"];
    self.viewControllerName = @"LoginViewController";
    self.fd_interactivePopDisabled = YES;
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:self.phoneLabel.text];
    [attri addAttributes:@{NSForegroundColorAttributeName:DefaultAPPColor} range:NSMakeRange(5, self.phoneLabel.text.length - 5)];
    [attri addAttributes:@{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(5, self.phoneLabel.text.length - 5)];
    self.phoneLabel.attributedText = attri;
   @weakify(self);
   [[[HQJLocationManager shareInstance]getLocation] setLocation:^(CGFloat lat, CGFloat lon, NSString * _Nonnull cityName) {
       @strongify(self);
       [SVProgressHUD dismiss];

       self.latitude = lat;
       self.longitude = lon;
     
   }];
   
    
}
- (instancetype)initWithShopid:(NSString *)shopid {
    self = [super init];
    if (self) {
        self.shopidString = shopid;
    }
    return self;
}
/// XD 商家独立入驻
- (void)requstXD {
    [XDDetailViewModel getXDShopState:self.shopidString andPeugeotid:@"6" completion:^(id  _Nonnull dict) {
        self.resultDict = dict;
        self.stateValueLabel.text = [self getButtonString];
    }];
}
- (void)handleXDState:(BOOL)isShortcut{
    
    //1生成订单
    //2代付款
    //3付款成功(生成第一份合同)
    //4第一份合同待签署(去签属合同)
    //5第-份合同签署成功(去生成第二-份合同)
    //6第一份合同签署失败(跳3)
    //7待签署(去签署第二份合同)
    //8签署成功(等待待审核)
    //9签署失败(跳5 )
    //10审核成功
    //11审核失败(修改信息,需要修改合同就跳5 ,或者跳8 )
    
    if (self.resultDict) {
        switch ([self.resultDict[@"state"] integerValue]) {
            case -1://-1 不可用
                [SVProgressHUD showErrorWithStatus:@"当前状态暂不支持申请"];
                break;
                
            case 0://0 信息未完善
                //跳转信息填写H5页
                [self jumpH5:[NSString stringWithFormat:@"%@%@?shopid=%@&type=1&peugeotid=6",HQJBH5UpDataDomain,HQJBNewstoreListInterface,Shopid]];
//                http://statics.wuwuditu.com/shopappH5/index.html#/xdshopmsg
                break;
                
            case 3://1 付款成功，去生成第一份合同
                if (isShortcut) {
                    [self jumpH5:[NSString stringWithFormat:@"%@%@?shopid=%@&lat=%f&lng=%f",HQJBH5UpDataDomain,HQJBNewstoreListInterface,self.shopidString,self.latitude,self.longitude]];

                } else {
                    [self createContract:1];

                }
                
                break;
            case 6://4 第一份合同签署失败，重新生成第一份合同（同步骤1）
                //去生成第一份合同
                [self createContract:1];
                break;
                
            case 4://2 第一份合同未签署，去签署第一份合同
            case 7://7 第二份合同未签署，去签署第二份合同
                //跳转H5去签署合同
                [self jumpH5:self.resultDict[@"data"]];
                break;
                
            case 1://3 第一份合同签署完成，去生成订单
                [self createOreder];
                break;
                
            case 2://5 订单已生成，待付款，跳支付页准备付款
                //跳转支付页
                [self jumpPay];
                
                break;
                
            case 5://第1份合同签署成功(去生成第2份合同)
            case 9://9 第二份合同签署失败，重新生成第二份合同（同步骤5）
                //去生成第二份合同
                [self createContract:2];
                break;
                
            case 8://8 第二份合同签署完成，等待审核
                [SVProgressHUD showSuccessWithStatus:@"等待审核"];
                break;
                
            case 10://10 审核成功，流程结束
                break;
                
            case 11://11 审核失败，修改信息
            {
//                HQJWebViewController *pvc = [[HQJWebViewController alloc]init];
//                pvc.zwNavView.hidden = YES;
                @weakify(self);
                [HintView enrichSubviews:[NSString stringWithFormat:@"%@",self.reason] andSureTitle:@"修改" cancelTitle:@"取消" sureAction:^{
                    @strongify(self);
                    [SVProgressHUD showWithStatus:@"加载中"];
                    [ManagerEngine SVPAfter:self.resultDict[@"errdata"] complete:^{
                        [SVProgressHUD dismiss];
                        // 跳转信息填写H5页
                        [self jumpH5:[NSString stringWithFormat:@"%@%@?shopid=%@&type=3&peugeotid=6",HQJBH5UpDataDomain,HQJBNewstoreListInterface,Shopid]];
                    }];
                }];
                
                
               
                
            }
                break;
            case 12://12 去生成第一份合同
                [self createContract:1];
                break;
        }
    }
    if ([self.stateValueLabel.text isEqualToString:@"待实名认证"]) {
        HQJWebViewController *pvc = [[HQJWebViewController alloc]init];
        pvc.zwNavView.hidden = YES;
        pvc.webUrlStr = [NSString stringWithFormat:@"%@%@?shopid=%@&lat=%f&lng=%f",HQJBH5UpDataDomain,HQJBNewstoreListInterface,self.shopidString,self.latitude,self.longitude];
        [self.navigationController pushViewController:pvc animated:YES];

    }

    
}
- (void)jumpH5:(NSString *)url{
    
    HQJWebViewController *webVC = [[HQJWebViewController alloc]init];
    webVC.zwNavView.hidden = YES;
    webVC.webUrlStr = url;
    [self.navigationController pushViewController:webVC animated:YES];
    
}
- (void)createContract:(NSInteger)type{
    [XDDetailViewModel initiateESign:self.shopidString andType:[NSString stringWithFormat:@"%ld",type] andState:@"1" andPeugeotid:@"6" completion:^(id  _Nonnull result) {
        [self jumpH5:(NSString *)result];
        
    }];
}
- (void)createOreder{
    [XDDetailViewModel submitXDOrder:self.shopidString andProid:@"6" andPrice:[NSString stringWithFormat:@"%f",self.price] completion:^(XDPayModel *model) {
        XDPayViewController *payVC = [[XDPayViewController alloc]initWithXDPayModel:model];
        payVC.payType = registerXD;
        payVC.xdPayroleValue = self.roleValue;
        payVC.xdPayshopidString = self.shopidString;
        payVC.xdPaylatitude = self.latitude;
        payVC.xdPaylongitude = self.longitude;
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
    model.proname = self.resultDict[@"orderdata"][@"proname"];
    XDPayViewController *payVC = [[XDPayViewController alloc]initWithXDPayModel:model];
    payVC.payType = registerXD;
    payVC.xdPayshopidString = self.shopidString;
    payVC.xdPaylatitude = self.latitude;
    payVC.xdPaylongitude = self.longitude;
    payVC.xdPayroleValue = self.roleValue;
    [self.navigationController pushViewController:payVC animated:YES];
}
- (NSString *)getButtonString{
    switch ([self.resultDict[@"state"] integerValue]) {
            
            //1生成订单
            //2代付款
            //3付款成功(生成第一份合同)
            //4第一份合同待签署(去签属合同)
            //5第-份合同签署成功(去生成第二-份合同)
            //6第一份合同签署失败(跳3)
            //7待签署(去签署第二份合同)
            //8签署成功(等待待审核)
            //9签署失败(跳5 )
            //10审核成功
            //11审核失败(修改信息,需要修改合同就跳5 ,或者跳8 )
        case -1://-1 不可用
            return @"不可申请";
            
        case 0://0 信息未完善
            return @"立即加入";
            
        case 3://1 信息已完善，去生成第一份合同
            if ( self.roleValue == 7) {
                return @"签署新商业合同";
            }
            if ( self.roleValue == 8) {
                return @"立即加入";
            }
            
        case 6:
            return @"签署新商业合同";
        case 2:
        case 1://3 第一份合同签署完成，去生成订单
            return @"立即支付";
            
        case 4://4 第一份合同签署失败，重新生成第一份合同（同步骤1）
            return @"签署新商业合同";
            
        case 8://8 第二份合同签署完成，等待审核
            return @"审核中";
        case 5:
        case 7:
        case 9://9 第二份合同签署失败，重新生成第二份合同（同步骤6）
            return @"签署国物溯源协议";
        case 10://10审核成功，流程结束
            return @"审核成功";
            
        case 11://11 审核失败，修改信息 宗海兰：修改成审核失败，跳出原因
            return @"审核失败";
        case 12://11 审核失败，修改信息 宗海兰：修改成审核失败，跳出原因
            return @"签署新商业合同";
    }
    return @"";
}

- (void)clickPhone:(UITapGestureRecognizer *)tap {
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://4000591081"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}


- (void)requstState {
    NSString *url = [NSString stringWithFormat:@"%@%@",HQJBDomainName,HQJBGetShopUpgradeStateInterface];
    [RequestEngine HQJBusinessGETRequestDetailsUrl:url parameters:@{@"shopid":self.shopidString} complete:^(NSDictionary *dic) {
        if([dic[@"resultCode"]integerValue] == 2100){
          
            self.code = [dic[@"resultMsg"][@"rolecheckstate"] integerValue];
            self.signUrl = dic[@"resultMsg"][@"signUrl"];
            self.shopNameValueLabel.text = dic[@"resultMsg"][@"shopname"];
            self.mobileValueLabel.text = dic[@"resultMsg"][@"mobile"];
            self.applyTimeValueLabel.text = dic[@"resultMsg"][@"upgraderoletime"];
            self.roleValue = [dic[@"resultMsg"][@"role"] integerValue];
            self.price = [dic[@"resultMsg"][@"price"] floatValue];
            self.reason = [dic[@"resultMsg"][@"rolecheckremark"] stringByReplacingOccurrencesOfString:@"_&_" withString:@"\n"];

            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"shopid"]) {
                  [[NSUserDefaults standardUserDefaults]  setObject:dic[@"resultMsg"][@"shopid"] ? dic[@"resultMsg"][@"shopid"] : @"" forKey:@"shopid"];
            }
            
            if (self.code != 6666 &&  self.roleValue == 7) {
                [self requstXD];

            } else   if (self.code != 6666 &&  self.roleValue == 8) {
                [self requstXD];

            } else {
                if (self.code == -1) {
                    self.stateValueLabel.text = @"去开店";
                } else if ( self.code == 1000 ) {
                    self.stateValueLabel.text = @"审核成功";

                } else if ( self.code == 1001 ) {
                    self.stateValueLabel.text = @"审核失败";
                } else if ( self.code  == 6666 ) {
                    self.stateValueLabel.text = @"待实名认证";

                } else if ( self.code == 8888 ) {
                    self.stateValueLabel.text = @"发起合同";

                } else if ( self.code == 9999 ) {
                    self.stateValueLabel.text = @"签署合同";

                } else {
                    self.stateValueLabel.text = @"待审核";

                }
            }

        } else {
            [SVProgressHUD showErrorWithStatus:@"加载失败，请稍候重试"];
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}

#pragma private method
- (void)layoutTheSubViews{
    self.shopNameView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.view, TopSpace + NavigationControllerHeight).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH);
    
    self.shopNameLabel.sd_layout.leftSpaceToView(self.shopNameView, 70.0f/3).heightIs(S_XRatioH(130.0f/3)).widthIs(70.0f);
    
    self.shopNameValueLabel.sd_layout.leftSpaceToView(self.shopNameLabel, 10).rightSpaceToView(self.shopNameView, 70.f/3).heightIs(S_XRatioH(130.0f/3));
    
    self.snBottomView.sd_layout.leftEqualToView(self.shopNameLabel).bottomEqualToView(self.shopNameView).heightIs(.5f).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    
    self.mobileView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.shopNameView,0).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH);
    
    self.mobileLabel.sd_layout.leftSpaceToView(self.mobileView, 70.0f/3).heightIs(S_XRatioH(130.0f/3)).widthIs(70.0f);
    
    self.mobileValueLabel.sd_layout.leftSpaceToView(self.mobileLabel, 10).rightSpaceToView(self.mobileView,70.f/3).heightIs(S_XRatioH(130.0f/3));
    
    self.mbBottomView.sd_layout.leftEqualToView(self.mobileLabel).bottomEqualToView(self.mobileView).heightIs(.5f).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    
    self.applyTimeView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.mobileView,0).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH);
    
    self.applyTimeLabel.sd_layout.leftSpaceToView(self.applyTimeView, 70.0f/3).heightIs(S_XRatioH(130.0f/3)).widthIs(70.0f);
    
    self.applyTimeValueLabel.sd_layout.leftSpaceToView(self.applyTimeLabel, 10).rightSpaceToView(self.applyTimeView,70.f/3).heightIs(S_XRatioH(130.0f/3));
    
    self.tmBottomView.sd_layout.leftEqualToView(self.applyTimeLabel).bottomEqualToView(self.applyTimeView).heightIs(.5f).widthIs(WIDTH-S_XRatioW(110.0f/3));


    self.stateView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.applyTimeView,0).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH);

    self.stateLabel.sd_layout.leftSpaceToView(self.stateView, 70.0f/3).heightIs(S_XRatioH(130.0f/3)).widthIs(70.0f);
    
    self.stateValueLabel.sd_layout.leftSpaceToView(self.stateLabel, 10).rightSpaceToView(self.stateView,70.f/3).heightIs(S_XRatioH(130.0f/3));
   
    self.bonusView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.stateView,0).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH);
    self.bonusLabel.sd_layout.leftSpaceToView(self.bonusView, 70.0f/3).heightIs(S_XRatioH(130.0f/3)).widthIs(70.0f);
    self.bonusValueLabel.sd_layout.leftSpaceToView(self.bonusLabel, 10).rightSpaceToView(self.bonusView,70.f/3).heightIs(S_XRatioH(130.0f/3));
    
    self.phoneLabel.sd_layout.centerXEqualToView(self.view).bottomSpaceToView(self.view, ToolBarHeight - 20).heightIs(20).widthIs(WIDTH);
    
    

}



@end
