//
//  RegisterViewController.m
//  HQJBusiness
//
//  Created by 姚 on 2019/6/26.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MyShopViewController.h"


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


@property (nonatomic,strong)UILabel *stateLabel;
@property (nonatomic,strong)UIView *stateView;
@property (nonatomic,strong)UIImageView *successImageView;
@property (nonatomic,strong)UILabel *successLabel;

@property (nonatomic,strong)UIButton *sureBtn;
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
        _shopNameValueLabel.text = @"古风日";
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


-(UILabel *)applyTimeValueLabel {
    if ( _applyTimeValueLabel == nil ) {
        _applyTimeValueLabel = [[UILabel alloc]init];
        _applyTimeValueLabel.font = [UIFont systemFontOfSize:16];
        _applyTimeValueLabel.text = @"2017-12-21";
        [self.applyTimeView addSubview:_applyTimeValueLabel];
    }
    
    return _applyTimeValueLabel;
}


-(UILabel *)stateLabel {
    if ( _stateLabel == nil ) {
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.backgroundColor = [UIColor whiteColor];
        _stateLabel.font = [UIFont boldSystemFontOfSize:18.f];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.textColor = [ManagerEngine getColor:@"ff4949"];
        _stateLabel.text = @"待审核...";
        [self.view addSubview:_stateLabel];
    }
    
    return _stateLabel;
}

- (UIView *)stateView{
    if (_stateView == nil) {
        _stateView = [[UIView alloc]init];
        _stateView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_stateView];
    }
    return _stateView;
}
- (UIImageView *)successImageView{
    if (_successImageView == nil) {
        _successImageView = [[UIImageView alloc]init];
        _successImageView.image = [UIImage imageNamed:@"check-circle_green"];
        [self.stateView addSubview:_successImageView];
    }
    return _successImageView;
}
-(UILabel *)successLabel{
    if ( _successLabel == nil ) {
        _successLabel = [[UILabel alloc]init];
        _successLabel.font = [UIFont boldSystemFontOfSize:18.f];
        _successLabel.textAlignment = NSTextAlignmentCenter;
        _successLabel.textColor = [ManagerEngine getColor:@"13ce67"];
        [self.stateView addSubview:_successLabel];
    }
    
    return _successLabel;
}

- (UIButton *)sureBtn{
    if ( _sureBtn == nil ) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.backgroundColor = DefaultAPPColor;
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.layer.cornerRadius = S_XRatioH(145/6);
        _sureBtn.titleLabel.font = [UIFont boldSystemFontOfSize:50/3];
        [self.view addSubview:_sureBtn];
    }
    
    return _sureBtn;
}

#pragma click method

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navType = HQJNavigationBarBlue;
    self.isHideShadowLine = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的店铺";
    [self.view setBackgroundColor:[ManagerEngine getColor:@"f7f7f7"]];
    [self layoutTheSubViews];
    
    // Do any additional setup after loading the view.
    
    
}
#pragma private method
- (void)layoutTheSubViews{
    
    self.shopNameView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.view, TopSpace).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH);
    
    self.shopNameLabel.sd_layout.leftSpaceToView(self.shopNameView, 70.0f/3).heightIs(S_XRatioH(130.0f/3)).widthIs(70.0f);
    
    self.shopNameValueLabel.sd_layout.leftSpaceToView(self.shopNameLabel, 10).rightEqualToView(self.shopNameView).heightIs(S_XRatioH(130.0f/3));
    
    self.snBottomView.sd_layout.leftEqualToView(self.shopNameLabel).bottomEqualToView(self.shopNameView).heightIs(.5f).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    self.mobileView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.shopNameView,0).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH);
    
    self.mobileLabel.sd_layout.leftSpaceToView(self.mobileView, 70.0f/3).heightIs(S_XRatioH(130.0f/3)).widthIs(70.0f);
    
    self.mobileValueLabel.sd_layout.leftSpaceToView(self.mobileLabel, 10).rightEqualToView(self.mobileView).heightIs(S_XRatioH(130.0f/3));
    
    self.mbBottomView.sd_layout.leftEqualToView(self.mobileLabel).bottomEqualToView(self.mobileView).heightIs(.5f).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
    
    self.applyTimeView.sd_layout.leftEqualToView(self.view).topSpaceToView(self.mobileView,0).heightIs(S_XRatioH(130.0f/3)).widthIs(WIDTH);
    
    self.applyTimeLabel.sd_layout.leftSpaceToView(self.applyTimeView, 70.0f/3).heightIs(S_XRatioH(130.0f/3)).widthIs(70.0f);
    
    self.applyTimeValueLabel.sd_layout.leftSpaceToView(self.applyTimeLabel, 10).rightEqualToView(self.applyTimeView).heightIs(S_XRatioH(130.0f/3));
    
    
    self.stateLabel.sd_layout.topSpaceToView(self.applyTimeView, 230.f/3).centerXEqualToView(self.view).heightIs(S_XRatioH(470.0f/3)).widthIs(S_XRatioW(720.0f/3));
    
    self.sureBtn.sd_layout.leftSpaceToView(self.view, 70.0f/3).bottomSpaceToView(self.view, S_XRatioH(102.0f/3)).heightIs(S_XRatioH(145.0f/3)).widthIs(WIDTH-S_XRatioW(110.0f/3));
    
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
