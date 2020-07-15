//
//  RegisterViewController.m
//  HQJBusiness
//
//  Created by 姚 on 2019/6/26.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//
@interface queryCityModel : NSObject
@property (nonatomic, strong) NSString *aliasname;
@property (nonatomic, strong) NSString *areaid;

@end
@interface queryCityModel ()

@end
@implementation queryCityModel
@end
#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "CreateShopViewController.h"
#import "HQJWebViewController.h"
#import "CityListViewController.h"
#import "JKCountDownButton.h"
#import "HintView.h"
#import "MyShopViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate,CityListViewDelegate,UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)UIButton *backBtn;

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *loginBtn;

@property (nonatomic,strong)UIImageView *logoImageView;
@property (nonatomic,strong)UILabel *topicLabel;


@property (nonatomic,strong)UITextField *userNameText;
@property (nonatomic,strong)UITextField *authCodeText;
@property (nonatomic,strong)JKCountDownButton *getAuthCodeBtn;
@property (nonatomic,strong)UIView *acBottomView;
@property (nonatomic,strong)UIButton *secureBtn;



@property (nonatomic,strong)UIView *accessoryView;
@property (nonatomic,strong)UIButton *accessoryBtn;
@property (nonatomic,strong)UIButton *protocolBtn;


@property (nonatomic,strong)UIButton *registerBtn;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic ,assign) BOOL selected;

@property (nonatomic, strong) UILabel *locationTitleLabel;

@property (nonatomic, strong) UIView *userBottomView;
@property (nonatomic, strong) UIView *authCodeBottomView;
@property (nonatomic, strong) UIView *locationBottomView;

/// 市
@property (nonatomic, strong) UIButton *cityBtn;
/// 区
@property (nonatomic, strong) UIButton *regionBtn;
/// 区列表
@property (nonatomic, strong) UITableView *queryCityTabelView;
/// 区列表遮罩
@property (nonatomic, strong) UIView *tableMaskView;
@property (nonatomic, strong) NSMutableArray <queryCityModel *>*queryCityArray;
/// 选中的城市Model
@property (nonatomic, strong) queryCityModel *cityModel;
@end

@implementation RegisterViewController

#pragma lazy-load

- (UIButton *)backBtn{
    if ( _backBtn == nil ) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"icon_back_arrow_blue"] forState:UIControlStateNormal];
        [_backBtn bk_addEventHandler:^(id  _Nonnull sender) {
            NSLog(@"pop success");
            [self.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_backBtn];
    }
    return _backBtn;
}

- (UILabel *)titleLabel{
    if ( _titleLabel  == nil ) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:18.0f];
        _titleLabel.text = @"注册";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [ManagerEngine getColor:@"20a0ff"];
        [self.view addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

-(UIImageView *)logoImageView {
    if ( _logoImageView  == nil ) {
        _logoImageView = [[UIImageView alloc]init];
        _logoImageView.image = [UIImage imageNamed:@"logowuwumap"];
        [self.view addSubview:_logoImageView];
    }
    
    return _logoImageView;
}
- (UILabel *)topicLabel{
    if ( _topicLabel  == nil ) {
        _topicLabel = [[UILabel alloc]init];
        _topicLabel.font = [UIFont systemFontOfSize:18.0f];
        _topicLabel.text = @"【物物地图】商家入驻系统";
        _topicLabel.textAlignment = NSTextAlignmentCenter;
        _topicLabel.textColor = [ManagerEngine getColor:@"20a0ff"];
        [self.view addSubview:_topicLabel];
    }
    
    return _topicLabel;
}

-(UITextField *)userNameText {
    
    if ( _userNameText == nil ) {
        _userNameText = [[UITextField alloc]init];
        _userNameText.font = [UIFont systemFontOfSize:16];
        _userNameText.autocorrectionType = UITextAutocorrectionTypeNo;
        _userNameText.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _userNameText.delegate = self;
        _userNameText.clearsOnBeginEditing = YES;
        _userNameText.clearButtonMode = UITextFieldViewModeAlways;
        _userNameText.keyboardType = UIKeyboardTypeNumberPad;
        _userNameText.placeholder = @"请输入手机号";
        
        [self.view addSubview:_userNameText];
        
    }
    
    
    return _userNameText;
}

-(UITextField *)authCodeText {
    
    if ( _authCodeText == nil ) {
        _authCodeText = [[UITextField alloc]init];
        _authCodeText.font = [UIFont systemFontOfSize:16];
        _authCodeText.autocorrectionType = UITextAutocorrectionTypeNo;
        _authCodeText.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _authCodeText.delegate = self;
        _authCodeText.clearsOnBeginEditing = YES;
        _authCodeText.layer.masksToBounds = YES;
        _authCodeText.clearButtonMode = UITextFieldViewModeAlways;
        _authCodeText.keyboardType = UIKeyboardTypeNumberPad;
        _authCodeText.placeholder = @"请输入验证码";
        [self.view addSubview:_authCodeText];
        
    }
    return _authCodeText;
}


- (JKCountDownButton *)getAuthCodeBtn{
    if ( _getAuthCodeBtn == nil ) {
        _getAuthCodeBtn = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
        [_getAuthCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getAuthCodeBtn setTitleColor:[ManagerEngine getColor:@"555555"] forState:UIControlStateNormal];
        _getAuthCodeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:48/3.f];
//        [_getAuthCodeBtn bk_addEventHan dler:^(id  _Nonnull sender) {
//            CreateShopViewController *csvc = [[CreateShopViewController alloc]init];
//            [self.navigationController pushViewController:csvc animated:YES];
//        } forControlEvents:UIControlEventTouchUpInside];
        @weakify(self);
        [_getAuthCodeBtn countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
            @strongify(self);
            if (self.userNameText.text.length == 11) {
//                self.getAuthCodeBtn.enabled = NO;

                [self getCodeRequst];
            } else {
                [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
            }
            
        }];
        
        [self.view addSubview:_getAuthCodeBtn];
    }
    return _getAuthCodeBtn;
}

- (UIView *)acBottomView{
    if ( _acBottomView  == nil ) {
        _acBottomView = [[UIView alloc]init];
        _acBottomView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
        [self.view addSubview:_acBottomView];
    }
    return _acBottomView;
}


- (UIView *)accessoryView{
    if ( _accessoryView == nil ) {
        _accessoryView = [[UIView alloc]init];
        _accessoryView.userInteractionEnabled = YES;
        _accessoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _accessoryBtn.frame = CGRectMake(0, 0, 20, 20);
        [_accessoryBtn setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
        [_accessoryBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
        _accessoryBtn.userInteractionEnabled = NO;
//        _accessoryBtn.enabled = NO;
        UILabel *accessoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 100, 20)];
        accessoryLabel.text = @"我已阅读并同意";
        accessoryLabel.textColor = [ManagerEngine getColor:@"909399"];
        accessoryLabel.font = [UIFont systemFontOfSize:12.0f];
        [_accessoryView addSubview:accessoryLabel];
        [_accessoryView addSubview:_accessoryBtn];
        UITapGestureRecognizer *accessoryTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(accessoryClick)];
        [_accessoryView addGestureRecognizer:accessoryTap];
        
        [self.view addSubview:_accessoryView];
    }
    return _accessoryView;
    
    
}

- (UIButton *)protocolBtn{
    if ( _protocolBtn == nil ) {
        _protocolBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_protocolBtn setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
        _protocolBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_protocolBtn setTitle:@"《【物物地图】商家入驻协议》" forState:UIControlStateNormal];
        @weakify(self);
        [[_protocolBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            HQJWebViewController *pvc = [[HQJWebViewController alloc]init];
            pvc.zwNavView.hidden = YES;
            pvc.webUrlStr = [NSString stringWithFormat:@"%@%@",HQJBH5UpDataDomain,HQJBRegisterAgreementListInterface];
            [self.navigationController pushViewController:pvc animated:YES];
        }];
        [self.view addSubview:_protocolBtn];
    }
    return _protocolBtn;
}

- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"register_nonselect"] forState:UIControlStateNormal];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"register_select"] forState:UIControlStateDisabled];
        [_selectBtn addTarget:self action:@selector(clickSelectButton:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:_selectBtn];
    }
    return _selectBtn;
}

- (UIButton *)registerBtn{
    if ( _registerBtn == nil ) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:@"立即入驻" forState:UIControlStateNormal];
        _registerBtn.backgroundColor = [ManagerEngine getColor:@"b9b9b9"];
        _registerBtn.enabled = NO;
        _registerBtn.layer.masksToBounds = YES;
        _registerBtn.layer.cornerRadius = 44 / 2;
        _registerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:50/3];
        @weakify(self);
        [[_registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            [self registeredAction];
        }];
        [self.view addSubview:_registerBtn];
    }
    
    return _registerBtn;
}
- (UIView *)userBottomView {
    if (!_userBottomView) {
        _userBottomView = [[UIView alloc]init];
        _userBottomView.backgroundColor = [ManagerEngine getColor:@"cccccc"];
        [self.view addSubview:_userBottomView];
    }
    return _userBottomView;
}

- (UIView *)authCodeBottomView {
    if (!_authCodeBottomView) {
        _authCodeBottomView = [[UIView alloc]init];
        _authCodeBottomView.backgroundColor = [ManagerEngine getColor:@"cccccc"];
        [self.view addSubview:_authCodeBottomView];
    }
    return _authCodeBottomView;
}
- (UIView *)locationBottomView {
    if (!_locationBottomView) {
        _locationBottomView = [[UIView alloc]init];
        _locationBottomView.backgroundColor = [ManagerEngine getColor:@"cccccc"];
        [self.view addSubview:_locationBottomView];
    }
    return _locationBottomView;
}
- (UILabel *)locationTitleLabel {
    if (!_locationTitleLabel) {
        _locationTitleLabel = [[UILabel alloc]init];
        _locationTitleLabel.text = @"店铺位置";
        _locationTitleLabel.textColor = [ManagerEngine getColor:@"999999"];
        [self.view addSubview:self.locationTitleLabel];
    }
    return _locationTitleLabel;
}
- (UIButton *)cityBtn {
    if (!_cityBtn) {
        _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cityBtn setTitle:@"请选择" forState:UIControlStateNormal];
        [_cityBtn setTitleColor:[ManagerEngine getColor:@"000000"] forState:UIControlStateNormal];
        _cityBtn.titleLabel.font = [UIFont systemFontOfSize:48 /3.f];
        [self.view addSubview:self.cityBtn];
        [_cityBtn addTarget:self action:@selector(goCityList) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cityBtn;
}
- (UIButton *)regionBtn {
    if (!_regionBtn) {
        _regionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_regionBtn setTitle:@"请选择" forState:UIControlStateNormal];
        [_regionBtn setTitleColor:[ManagerEngine getColor:@"000000"] forState:UIControlStateNormal];
        _regionBtn.titleLabel.font = [UIFont systemFontOfSize:48 /3.f];
        [self.view addSubview:self.regionBtn];
        [_regionBtn addTarget:self action:@selector(requstRegion) forControlEvents:UIControlEventTouchUpInside];

    }
    return _regionBtn;
}

- (UITableView *)queryCityTabelView {
    if (!_queryCityTabelView) {
        _queryCityTabelView = [[UITableView alloc]init];
        _queryCityTabelView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _queryCityTabelView.delegate = self;
        _queryCityTabelView.dataSource = self;
        [_queryCityTabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _queryCityTabelView.layer.masksToBounds = YES;
        _queryCityTabelView.layer.cornerRadius = 5.f;
        _queryCityTabelView.tableFooterView = [UIView new];
    }
    return _queryCityTabelView;
}
- (UIView *)tableMaskView {
    if (!_tableMaskView) {
        _tableMaskView = [[UIView alloc]init];
        _tableMaskView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
//        _tableMaskView.hidden = YES;
        [[UIApplication sharedApplication].keyWindow addSubview:_tableMaskView];
        
    }
    return _tableMaskView;
}
#pragma click method
- (void)popMethod{
    NSLog(@"pop");
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickSelectButton:(UIButton *)btn {
    self.selected = !self.selected;
    if (self.selected) {
        [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"register_select"] forState:UIControlStateNormal];
    } else {
        [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"register_nonselect"] forState:UIControlStateNormal];
        
    }
}
- (void)accessoryClick{
//     _accessoryBtn.enabled = NO;
    _accessoryBtn.selected = !_accessoryBtn.isSelected;
}
- (void)secureBtnClicked:(UIButton *)sender{
    [HintView enrichSubviews:@"请联系客服：400-0591-081" andSureTitle:@"呼叫" cancelTitle:@"取消" sureAction:^{
        /// 调用系统方法拨号
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://400-0591-081"]]];
    }];
    
    //    sender.selected = !sender.selected;
    //    _pswText.secureTextEntry = sender.selected ? NO : YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.tableMaskView addSubview:self.queryCityTabelView];
    [self layoutTheSubViews];
    self.selected = NO;
    self.queryCityArray = [NSMutableArray array];
    self.tableMaskView.hidden = YES;
    [self setSignal];
}
- (void)setSignal {
    @weakify(self);
    RACSignal *nameSignal = [self.userNameText.rac_textSignal map:^id(id value) {
        @strongify(self);
        return @(self.userNameText.text.length > 0);
    }];
    RACSignal *codeSignal = [self.authCodeText.rac_textSignal map:^id(id value) {
         @strongify(self);
          return @(self.authCodeText.text.length > 0);
    }];
    RACSignal *accessorySignal = RACObserve(self.accessoryBtn, selected);
    RACSignal *citySignal = RACObserve(self.cityBtn.titleLabel, text);
    RACSignal *regionSignal = RACObserve(self.regionBtn.titleLabel, text);
  
    
    RACSignal *combineSignal = [RACSignal combineLatest:@[nameSignal,codeSignal,accessorySignal,citySignal,regionSignal] reduce:^id (NSNumber *name,NSNumber *code,NSNumber *accessory,NSString *city,NSString *region){
        return @([name boolValue] && [code boolValue] && [accessory boolValue] && ![city isEqualToString:@"请选择"] && ![region isEqualToString:@"请选择"]);
    }];
    
    [combineSignal subscribeNext:^(NSNumber *combined) {
         @strongify(self);
        self.registerBtn.backgroundColor = [combined boolValue] ? DefaultAPPColor:[ManagerEngine getColor:@"b9b9b9"];
        self.registerBtn.enabled = [combined boolValue] ;
    }];
}
#pragma private method
- (void)layoutTheSubViews{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(StatusBarHeight + 20.f);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.left.mas_equalTo(50.f/3);
        make.width.height.mas_equalTo(30.f);
    }];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(NavigationControllerHeight + 44.f);

    }];
    [self.topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.logoImageView.mas_bottom).mas_offset(S_XRatioH(50.f));
        
    }];
    [self.userNameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topicLabel.mas_bottom).mas_offset(60.f);
        make.left.mas_equalTo(30.f);
        make.right.mas_equalTo(-30.f);
        make.height.mas_equalTo(44.f);
    }];
    [self.authCodeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userNameText.mas_bottom).mas_offset(15.f);
        make.left.height.mas_equalTo(self.userNameText);
        make.width.mas_equalTo(self.userNameText.mas_width).multipliedBy(0.66f);
    }];
    [self.getAuthCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(self.userNameText.mas_bottom).mas_offset(15.f);
           make.right.height.mas_equalTo(self.userNameText);
           make.left.mas_equalTo(self.authCodeText.mas_right).mas_offset(15.f);
    }];
//    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(-ToolBarHeight + 20.f);
//        make.left.mas_equalTo(self.userNameText);
//    }];
    [self.accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userNameText);
        make.bottom.mas_equalTo(-ToolBarHeight + 20.f);
        make.width.mas_equalTo(100+20);
        make.height.mas_equalTo(20);
    }];
    
    [self.protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.accessoryView);
        make.left.mas_equalTo(self.accessoryView.mas_right).mas_offset(5);
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.userNameText);
        make.bottom.mas_equalTo(self.protocolBtn.mas_top).mas_offset(-30);
        make.height.mas_equalTo(self.userNameText);
    }];
    [self.locationTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.authCodeText.mas_bottom).mas_offset(15.f);
        make.left.height.mas_equalTo(self.authCodeText);
    }];
    [self.userBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.userNameText);
        make.top.mas_equalTo(self.userNameText.mas_bottom);
        make.height.mas_equalTo(0.5f);
    }];
    [self.userBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.userNameText);
        make.top.mas_equalTo(self.userNameText.mas_bottom);
        make.height.mas_equalTo(0.5f);
    }];
    [self.authCodeBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.userBottomView);
        
        make.top.mas_equalTo(self.authCodeText.mas_bottom);
        make.height.mas_equalTo(0.5f);
    }];
    [self.locationBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.userBottomView);
        make.top.mas_equalTo(self.locationTitleLabel.mas_bottom);
        make.height.mas_equalTo(0.5f);
    }];
    [self.cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.locationTitleLabel);
        make.right.mas_equalTo(self.regionBtn.mas_left).mas_offset(-10);
    }];
    [self.regionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.mas_equalTo(self.locationTitleLabel);
         make.right.mas_equalTo(self.getAuthCodeBtn);
     }];
    [self.tableMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    [self.queryCityTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(NavigationControllerHeight, 15, ToolBarHeight, 15));
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.queryCityArray.count;
   
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    queryCityModel *model = self.queryCityArray[indexPath.row];
    cell.textLabel.text = model.aliasname;
    return cell;
 
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     queryCityModel *model = self.queryCityArray[indexPath.row];
    self.cityModel = model;
    [self.regionBtn setTitle:model.aliasname forState:UIControlStateNormal];
    self.tableMaskView.hidden = YES;
}
-(void)getCodeRequst{
    NSString *urlStr;
    NSMutableDictionary *dict = @{@"mobile":self.userNameText.text}.mutableCopy;
    urlStr = [NSString stringWithFormat:@"%@%@",HQJBDomainName,HQJBGetByMobileCodeInterface];
    HQJLog(@"---%@",urlStr);
    [RequestEngine HQJBusinessGETRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
        if([dic[@"resultCode"]integerValue] != 2000) {
            self.getAuthCodeBtn.enabled = YES;
            
            [SVProgressHUD showErrorWithStatus:dic[@"resultHint"]];
        } else {
            [self.getAuthCodeBtn startCountDownWithSecond:60];
            
            [self.getAuthCodeBtn countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
                self.getAuthCodeBtn.enabled = NO;
                //                self.getAuthCodeBtn.backgroundColor = [ManagerEngine getColor:@"7fd4ff"];
                
                NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
                return title;
            }];
            [self.getAuthCodeBtn countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                countDownButton.enabled = YES;
                //                self.getAuthCodeBtn.backgroundColor = DefaultAPPColor;
                return @"重新获取";
            }];
        }
        
    } andError:^(NSError *error) {
        
//        [ManagerEngine dimssLoadView:self.registerBtn andtitle:@"确认"];
        
    } ShowHUD:YES];
    
}

#pragma mark --- 注册（立即入驻）
- (void)registeredAction {
//    HQJWebViewController *pvc = [[HQJWeb ontroller:pvc animated:YES];
    

    
    MyShopViewController *shopVC = [[MyShopViewController alloc]initWithShopid:@"dasghsd"];
                 
    [self.navigationController pushViewController:shopVC animated:YES];
    return;
    
    if (self.accessoryBtn.selected) {
        if (self.userNameText.text.length > 1 &&
            self.authCodeText.text.length > 1 &&
            ![self.cityBtn.currentTitle isEqualToString:@"请选择"] &&
            ![self.regionBtn.currentTitle isEqualToString:@"请选择"]) {
            NSString *url = [NSString stringWithFormat:@"%@%@",HQJBDomainName,HQJBRegisterInterface];
            NSDictionary *paraDict = @{@"mobile":self.userNameText.text,
                                       @"code":self.authCodeText.text,
                                       @"area":[NSString stringWithFormat:@"%@%@",self.cityBtn.currentTitle,self.regionBtn.currentTitle],
                                       @"areaId":self.cityModel.areaid};
            @weakify(self);
            [RequestEngine HQJBusinessPOSTRequestDetailsUrl:url parameters:paraDict complete:^(NSDictionary *dic) {
                @strongify(self);
                if ([dic[@"resultCode"]integerValue] == 2100) {
                    MyShopViewController *shopVC = [[MyShopViewController alloc]initWithShopid:dic[@"resultMsg"][@"id"]];
                    [self.navigationController pushViewController:shopVC animated:YES];
                } else {
                    [SVProgressHUD showErrorWithStatus:dic[@"resultHint"]];

                }
            } andError:^(NSError *error) {
                
            } ShowHUD:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:@"以上信息尚未完善"];
        }
    } else {
        [SVProgressHUD showErrorWithStatus:@"尚未阅读入驻协议"];

    }
}
- (void)goCityList {
    CityListViewController *cityListView = [[CityListViewController alloc]init];

    cityListView.delegate = self;
    //热门城市列表
    cityListView.arrayHotCity = [NSMutableArray arrayWithObjects:@"北京",@"上海",@"福州",@"杭州",@"重庆",@"成都",@"株洲",@"赣州",@"内江", nil];
    //历史选择城市列表
    cityListView.arrayHistoricalCity = [NSMutableArray arrayWithObjects:@"福州",@"厦门",@"泉州", nil];
    cityListView.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:cityListView animated:YES completion:nil];
}
- (void)didClickedWithCityName:(NSString *)cityName {
    [self.cityBtn setTitle:cityName forState:UIControlStateNormal];
    if (![self.regionBtn.currentTitle isEqualToString:@"请选择"]) {
        [self.regionBtn setTitle:@"请选择" forState:UIControlStateNormal];
    }
}
- (void)requstRegion {
    if (![self.cityBtn.currentTitle isEqualToString:@"请选择"]) {
        NSString *url = [NSString stringWithFormat:@"%@%@",HQJBDomainName,HQJBQueryCityAreaInterface];
          [RequestEngine HQJBusinessPOSTRequestDetailsUrl:url parameters:@{@"city":self.cityBtn.currentTitle} complete:^(NSDictionary *dic) {
              if ([dic[@"resultCode"]integerValue] == 1300) {
                  self.queryCityArray = [queryCityModel mj_objectArrayWithKeyValuesArray:dic[@"resultMsg"]];
                  self.tableMaskView.hidden = NO;
                      // 网络请求
                      dispatch_async(dispatch_get_main_queue(), ^{
                          
                          //主线程刷新UI
                          [self.queryCityTabelView mas_updateConstraints:^(MASConstraintMaker *make) {
                              if (self.queryCityArray.count * 44.f > HEIGHT - ToolBarHeight - NavigationControllerHeight) {
                                  make.height.mas_equalTo(HEIGHT - ToolBarHeight - NavigationControllerHeight);
                              } else {
                                  make.height.mas_equalTo(self.queryCityArray.count * 44.f);
                              }
                          }];
                          
                      });
                      
                  [self.queryCityTabelView reloadData];
              }
          } andError:^(NSError *error) {
              
          } ShowHUD:NO];
    }
  

}
@end
