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
//#import ""
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

@property (nonatomic,strong)UIView *stateView;
@property (nonatomic,strong)UILabel *stateLabel;
@property (nonatomic,strong)UILabel *stateValueLabel;
@property (nonatomic, strong) HintView *showView;
@property (nonatomic,strong)NSString *shopidString;
/// 失败原因
@property (nonatomic, strong) NSString *reason;

/// 对应状态的URL
@property (nonatomic, strong) NSString *signUrl;

/// 客服电话
@property (nonatomic, strong) UILabel *phoneLabel;
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

- (void)clickState:(UITapGestureRecognizer *)tap {
    HQJWebViewController *pvc = [[HQJWebViewController alloc]init];
    pvc.zwNavView.hidden = YES;
    if ([self.stateValueLabel.text isEqualToString:@"去开店"]) {
        pvc.webUrlStr = [NSString stringWithFormat:@"%@%@?shopid=%@",HQJBH5UpDataDomain,HQJBNewstoreListInterface,self.shopidString];
    } else if ([self.stateValueLabel.text isEqualToString:@"审核成功"]) {
        [HintView enrichSubviews:@"重新登录即可获取完整体验" andSureTitle:@"去登录" cancelTitle:@"取消" sureAction:^{
            [ManagerEngine login];
        }];
        return;
    } else if ([self.stateValueLabel.text isEqualToString:@"审核失败"]) {
        @weakify(self);
        [HintView enrichSubviews:[NSString stringWithFormat:@"%@",self.reason] andSureTitle:@"修改" cancelTitle:@"取消" sureAction:^{
            @strongify(self);
            pvc.webUrlStr = [NSString stringWithFormat:@"%@%@?shopid=%@",HQJBH5UpDataDomain,HQJBNewstoreListInterface,self.shopidString];
            [self.navigationController pushViewController:pvc animated:YES];
        }];
         return;
    } else if ([self.stateValueLabel.text isEqualToString:@"待实名认证"]) {
        pvc.webUrlStr = [NSString stringWithFormat:@"%@%@?shopid=%@",HQJBH5UpDataDomain,HQJBNewstoreListInterface,self.shopidString];
    } else if ([self.stateValueLabel.text isEqualToString:@"发起合同"]) {
        
    } else if ([self.stateValueLabel.text isEqualToString:@"签署合同"]) {
        pvc.webUrlStr = self.signUrl;
    } else {
        return;
    }
    [self.navigationController pushViewController:pvc animated:YES];

    
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
   

    self.viewControllerName = @"LoginViewController";
    self.fd_interactivePopDisabled = YES;
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:self.phoneLabel.text];
    [attri addAttributes:@{NSForegroundColorAttributeName:DefaultAPPColor} range:NSMakeRange(5, self.phoneLabel.text.length - 5)];
    [attri addAttributes:@{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(5, self.phoneLabel.text.length - 5)];
    self.phoneLabel.attributedText = attri;
   
    
}
- (instancetype)initWithShopid:(NSString *)shopid {
    self = [super init];
    if (self) {
        self.shopidString = shopid;
    }
    return self;
}

- (void)clickPhone:(UITapGestureRecognizer *)tap {
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://4000591081"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}


- (void)requstState {
    NSString *url = [NSString stringWithFormat:@"%@%@",HQJBDomainName,HQJBGetShopUpgradeStateInterface];
    [RequestEngine HQJBusinessGETRequestDetailsUrl:url parameters:@{@"shopid":self.shopidString} complete:^(NSDictionary *dic) {
        if([dic[@"resultCode"]integerValue] == 2100){
            NSInteger code = [dic[@"resultMsg"][@"rolecheckstate"] integerValue];
            self.signUrl = dic[@"resultMsg"][@"signUrl"];
            self.shopNameValueLabel.text = dic[@"resultMsg"][@"shopname"];
            self.mobileValueLabel.text = dic[@"resultMsg"][@"mobile"];
            self.applyTimeValueLabel.text = dic[@"resultMsg"][@"upgraderoletime"];
            if (code == -1) {
                self.stateValueLabel.text = @"去开店";
            } else if ( code == 1000 ) {
                self.stateValueLabel.text = @"审核成功";

            } else if ( code == 1001 ) {
                self.stateValueLabel.text = @"审核失败";
                self.reason = [dic[@"resultMsg"][@"rolecheckremark"] stringByReplacingOccurrencesOfString:@"_&_" withString:@"\n"];
            } else if ( code  == 6666 ) {
                self.stateValueLabel.text = @"待实名认证";

            } else if ( code == 8888 ) {
                self.stateValueLabel.text = @"发起合同";

            } else if ( code == 9999 ) {
                self.stateValueLabel.text = @"签署合同";

            } else {
                self.stateValueLabel.text = @"待审核";

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
    
    self.phoneLabel.sd_layout.centerXEqualToView(self.view).bottomSpaceToView(self.view, ToolBarHeight - 20).heightIs(20).widthIs(WIDTH);
    
    

}



@end
