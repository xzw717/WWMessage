//
//  JumpH5ViewController.m
//  HQJBusiness
//
//  Created by Ethan on 2021/7/9.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//
#import "JumpH5ViewController.h"
#import "HQJWebViewController.h"
#import "XDPayModel.h"
#import "XDPayViewController.h"
#import "HQJLocationManager.h"
#import "XDDetailViewModel.h"
#import "HintView.h"
@interface JumpH5ViewController()


@property (nonatomic, strong) UIImageView  *introduceImageView;
@property (nonatomic, strong) UIButton *stateButton;
@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UIScrollView *bgView;
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
//@property (nonatomic,strong) XDModel *model;
@property (nonatomic,strong) NSDictionary *resultDict;

/// XD 商家独立入驻
@property (nonatomic, assign) CGFloat roleValue;
@property (nonatomic, assign) NSInteger code;

@property (nonatomic, assign) NSInteger coisrole;

@property (nonatomic, assign) CGFloat price;

@property (nonatomic, strong) NSString *coisorderid;

@property (nonatomic, assign) NSInteger xdstate;

@end

@implementation JumpH5ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"利益命运共同体";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addviews];
    [self layoutViews];
    @weakify(self);
    [[[HQJLocationManager shareInstance]getLocation] setLocation:^(CGFloat lat, CGFloat lon, NSString * _Nonnull cityName) {
        @strongify(self);
        [SVProgressHUD dismiss];

        self.latitude = lat;
        self.longitude = lon;
      
    }];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requstState];


}
/// XD 商家独立入驻
- (void)requstXD {
    [XDDetailViewModel getXDShopState:Shopid andPeugeotid:@"6" completion:^(id  _Nonnull dict) {
        self.resultDict = dict;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)) ,dispatch_get_main_queue() , ^{
            [self.stateButton setTitle:[self getButtonString] forState:UIControlStateNormal];

        });

    }];
}
- (NSString *)getButtonString{
    if (self.code != 6666) {
      switch ([self.resultDict[@"state"] integerValue]) {
            
            //1生成订单
            //2代付款
            //3付款成功(1.生成第一份合同2.去完善信息（快捷入驻）)
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
              return self.code == 0 ? @"待审核" : @"立即加入";
            
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
            if ( self.code  == 0 || self.code == 6666 ) {
                return  @"待实名认证";

            } else {
                return @"签署新商业合同";

            }

    }
        
    } else {
        return  @"";
    }
    return @"";
}
- (void)handleXDState{
    
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
                [self jumpH5:[NSString stringWithFormat:@"%@%@?shopid=%@&mobile=%@&type=1&peugeotid=6",HQJBH5UpDataDomain,HQJBXdshopmsgInterface,Shopid,Mmobile]];
//                http://statics.wuwuditu.com/shopappH5/index.html#/xdshopmsg
                break;
                
            case 3://1 付款成功，去生成第一份合同
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
                [ManagerEngine SVPAfter:self.resultDict[@"errdata"] complete:^{
                    // 跳转信息填写H5页
                    [self jumpH5:[NSString stringWithFormat:@"%@%@?shopid=%@&mobile=%@&type=3&peugeotid=6",HQJBH5UpDataDomain,HQJBXdshopmsgInterface,Shopid,Mmobile]];
                }];
                
                break;
        }
    }
    
}
- (void)createOreder{
    [XDDetailViewModel submitXDOrder:Shopid andType:@"0" andProid:@"6"  completion:^(XDPayModel *model) {
        XDPayViewController *payVC = [[XDPayViewController alloc]initWithXDPayModel:model];
        payVC.payType = buyXD;
        payVC.isMyShopPay = NO;
        [self.navigationController pushViewController:payVC animated:YES];
        
    }];
}
- (void)createContract:(NSInteger)type{
    [XDDetailViewModel initiateESign:Shopid andType:[NSString stringWithFormat:@"%ld",type] andState:@"1" andPeugeotid:@"6" completion:^(id  _Nonnull result) {
        [self jumpH5:(NSString *)result];
        
    }];
}
- (void)jumpH5:(NSString *)url{
    
    HQJWebViewController *webVC = [[HQJWebViewController alloc]init];
    webVC.zwNavView.hidden = YES;
    webVC.webUrlStr = url;
    [self.navigationController pushViewController:webVC animated:YES];
    
}
- (void)clickBtn {
    HQJWebViewController *pvc = [[HQJWebViewController alloc]init];
    pvc.zwNavView.hidden = YES;
    if ([self.stateButton.currentTitle isEqualToString:@"签署合同"]) {
        pvc.webUrlStr = self.signUrl;

    } else if ([self.stateButton.currentTitle isEqualToString:@"去支付"]) {
        [self jumpPay];
        return;
    } else if ([self.stateButton.currentTitle isEqualToString:@"申请溯源"]) {
        [self handleXDState];

        return;
    }  else if ([self.stateButton.currentTitle isEqualToString:@"立即加入"]) {
        if ([Ttypeid integerValue] == 19) {
            [self handleXDState];
            return;

        } else {
            pvc.webUrlStr = [NSString stringWithFormat:@"%@%@?shopid=%@&lat=%f&lng=%f",HQJBH5UpDataDomain,HQJBShopInformationInterface,Shopid,self.latitude,self.longitude];

        }
  
    } else if ([self.stateButton.currentTitle isEqualToString:@"审核失败"] && self.coisrole == 9) {
        @weakify(self);
        [HintView enrichSubviews:[NSString stringWithFormat:@"%@",self.reason] andSureTitle:@"修改" cancelTitle:@"取消" sureAction:^{
            @strongify(self);
            [SVProgressHUD showWithStatus:@"加载中"];
            [ManagerEngine SVPAfter:self.resultDict[@"errdata"] complete:^{
                [SVProgressHUD dismiss];
                // 跳转信息填写H5页
            http://subtest.heqijia.net/XdShopAudit/getDetailByShopId.action?shopid=0f53ec90-e7ff-443d-9d82-2000fdb34f0a
                [self jumpH5:[NSString stringWithFormat:@"%@%@?shopid=%@&mobile=%@&type=3&peugeotid=6",HQJBH5UpDataDomain,HQJBXdshopmsgInterface,Shopid,Mmobile]];
            }];
        }];

//        pvc.webUrlStr = [NSString stringWithFormat:@"%@%@?shopid=%@&lat=%f&lng=%f",HQJBH5UpDataDomain,HQJBShopInformationInterface,Shopid,self.latitude,self.longitude];
        return;
    } else if ([self.stateButton.currentTitle isEqualToString:@"当前有其他流程未完成"]){
        [self. navigationController popViewControllerAnimated:YES];
        return;
    } else {
        [self handleXDState];

        return;

    }
    [self.navigationController pushViewController:pvc animated:YES];

}
- (void)jumpPay{

    XDPayModel *model = [[XDPayModel alloc]init];
    model.orderid = self.resultDict[@"orderdata"][@"orderid"];
    model.ordermoney = self.resultDict[@"orderdata"][@"ordermoney"];
    model.proid = self.resultDict[@"orderdata"][@"proid"];
    model.proname = self.resultDict[@"orderdata"][@"proname"];
    XDPayViewController *payVC = [[XDPayViewController alloc]initWithXDPayModel:model];
    payVC.payType = registerXD;
    payVC.isMyShopPay = YES;
    payVC.xdPayshopidString = Shopid;
    payVC.xdPaylatitude = self.latitude;
    payVC.xdPaylongitude = self.longitude;
    payVC.xdPayroleValue = self.roleValue;
    [self.navigationController pushViewController:payVC animated:YES];
}
- (void)requstState {
    NSString *url = [NSString stringWithFormat:@"%@%@",HQJBDomainName,HQJBGetShopUpgradeStateInterface];
    [RequestEngine HQJBusinessGETRequestDetailsUrl:url parameters:@{@"shopid":Shopid} complete:^(NSDictionary *dic) {
        if([dic[@"resultCode"]integerValue] == 2100){
            self.coisrole = [dic[@"resultMsg"][@"coisrole"]integerValue];
            self.xdstate = [dic[@"resultMsg"][@"xdstate"] integerValue];
            self.code = [dic[@"resultMsg"][@"rolecheckstate"] integerValue];
            self.roleValue = [dic[@"resultMsg"][@"role"] integerValue];
            self.price = [dic[@"resultMsg"][@"price"] floatValue];
            self.reason = [dic[@"resultMsg"][@"rolecheckremark"] stringByReplacingOccurrencesOfString:@"_&_" withString:@"\n"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)) ,dispatch_get_main_queue() , ^{
//                [self layoutTheSubViews];

            });
            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"shopid"]) {
                  [[NSUserDefaults standardUserDefaults]  setObject:dic[@"resultMsg"][@"shopid"] ? dic[@"resultMsg"][@"shopid"] : @"" forKey:@"shopid"];
            }
            if (self.coisrole == 9) {
                if (self.code == 1000) {
                    [self requstXD];

                } else {
                    [self setState:dic];

                }
                
            } else if (self.code == 1000 && self.xdstate == 0 ) {
                [self.stateButton setTitle:@"立即加入" forState:UIControlStateNormal];
                self.stateButton.backgroundColor = DefaultAPPColor;
            } else {
                                
                self.stateButton.enabled = NO;
                self.stateButton.backgroundColor = [UIColor grayColor];
                [self.stateButton setTitle:@"当前有其他流程未完成" forState:UIControlStateNormal];
            }
               
            self.introduceLabel.hidden = [Ttypeid integerValue] == 19  ? YES : NO;
            self.introduceImageView.hidden = !self.introduceLabel.hidden;
                
//            if (self.code == -1 || self.code == 1000) {
//
//
//            }
          
        } else {
            [SVProgressHUD showErrorWithStatus:@"加载失败，请稍候重试"];
        }
    } andError:^(NSError *error) {
        
    } ShowHUD:YES];
}


- (void)setState:(NSDictionary *)dic {
    if (self.code == 1000) {
        if ([Ttypeid integerValue] == 19) {
            [self.stateButton setTitle:@"申请溯源" forState:UIControlStateNormal];

        }
        if ([Ttypeid integerValue] == 20) {
            [self.stateButton setTitle:@"已完成" forState:UIControlStateNormal];

        }
        self.stateButton.backgroundColor = DefaultAPPColor;
    }
    if ( self.code == 0 ) {
        [self.stateButton setTitle:@"待审核" forState:UIControlStateNormal];

    }
    if ( self.code == 1004 || self.code == 1003 ) {
        [self.stateButton setTitle:@"去支付" forState:UIControlStateNormal];
        self.stateButton.backgroundColor = DefaultAPPColor;
        self.coisorderid= dic[@"resultMsg"][@"coisorderid"];

    }
    
    if ( self.code == 9999 ) {
        self.signUrl = dic[@"resultMsg"][@"signUrl"];
        [self.stateButton setTitle:@"签署合同" forState:UIControlStateNormal];
        self.stateButton.backgroundColor = DefaultAPPColor;

    }
    if (self.code == 1001){
        [self.stateButton setTitle:@"审核失败" forState:UIControlStateNormal];
        self.stateButton.backgroundColor = [UIColor grayColor];

    }
    if (self.code == 1001){
        [self.stateButton setTitle:@"审核失败" forState:UIControlStateNormal];
        self.stateButton.backgroundColor = [UIColor grayColor];

    }
}

- (void)addviews {
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.introduceLabel];

    [self.bgView addSubview:self.introduceImageView];
    [self.view addSubview:self.stateButton];


}
- (void)layoutViews {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NavigationControllerHeight);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.stateButton.mas_top).mas_offset(-20);

    }];
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WIDTH - 30.f);
        make.left.mas_equalTo(15.f);
        make.top.mas_equalTo(30.f);
        make.bottom.mas_equalTo(0);
    }];
    [self.introduceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WIDTH);
        make.top.left.bottom.mas_equalTo(0);
    }];
    [self.stateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.bottom.mas_equalTo(-20.f);
        make.height.mas_equalTo(44.f);
    }];
    
 
}
- (UIButton *)stateButton {
    if (!_stateButton) {
        _stateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_stateButton setTitle:@"未知状态" forState:UIControlStateNormal];
        _stateButton.backgroundColor = DefaultAPPColor;
        _stateButton.layer.cornerRadius = 22.f;
        _stateButton.layer.masksToBounds = YES;
        [_stateButton addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stateButton;
}
- (UIImageView *)introduceImageView {
    if (!_introduceImageView) {
        _introduceImageView = [[UIImageView alloc]init];
        _introduceImageView.hidden = YES;
        _introduceImageView.image = [UIImage imageNamed:@"Communityofinterestsanddestiny"];
    }
    return _introduceImageView;
}
- (UIScrollView *)bgView {
    if (!_bgView) {
        _bgView = [[UIScrollView alloc]init];
        
    }
    return _bgView;
}
- (UILabel *)introduceLabel {
    if (!_introduceLabel) {
        _introduceLabel = [[UILabel alloc]init];
        _introduceLabel.text = @"                      神奇的利益命运共同体\n\n\n\n身为老板的您\n想不想把投资回报快速提升1.2倍！！\n想不想解放自己，提升员工？！\n想不想让自家品牌的连锁店快速落地？！\n您要问能实现么？\n从现在起，请把“么”字去掉！\n因为只要成为【物物地图】利益命运共同体，这些愿望统统都能实现！\n定位成为【物物地图】利益命运共同体，将有专业团队帮您量身打造营销方案，让您的企业实现短期内营业额爆发！让您的员工个人收益与门店收益直接挂钩，积极性高涨，自动形成核心团队，成为动车组！让进店顾客的每笔交易可追溯可查询，实现客户标签化管理，精准服务，提高粘性！助力您快速开出分店，打造连锁品牌，融合周边更多业态，服务更多人群！\n过去，许多传统实体门店进货，定价，卖货全都要靠老板自己，每天从早忙到晚，员工却成了闲人！现在，成为利益命运共同体之后，通过【物物地图】生态系统，经营的事情员工们都将自动、自发去做，有效提升门店的管理水平，把您一个人的单打独斗，变成一群人的抱团发展！您作为老板就能从繁杂的事务性工作中解放，转向考虑门店公司战略方向与顶层设计、寻找合伙人，做老板真正应该做的事情！这就是【物物地图】生态系统的神奇力量！\n想把生意做好一点？\n 想把生意再做大一点？\n想把生意做长久一点？\n物物地图】利益命运共同体，就是您不容错过的选择！";
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString: _introduceLabel.text];
        [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.f weight:UIFontWeightBold] range:[_introduceLabel.text rangeOfString:@"神奇的利益命运共同体"]];
        _introduceLabel.attributedText = text;
        _introduceLabel.numberOfLines = 0;
    }
    return _introduceLabel;
}
@end
