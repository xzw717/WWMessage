//
//  CreateShopViewController.m
//  HQJBusiness
//
//  Created by 姚 on 2019/6/26.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "CreateShopViewController.h"

#import "ZGRelayoutButton.h"

@interface CreateShopViewController ()
@property (nonatomic,strong)UIImageView *logoImageView;
@property (nonatomic,strong)UILabel *topicLabel;

@property (nonatomic,strong)ZGRelayoutButton *commonShopBtn;
@property (nonatomic,strong)UIView *verticalView;
@property (nonatomic,strong)ZGRelayoutButton *mygttBtn;

@property (nonatomic,strong)UIButton *createShopBtn;
@end

@implementation CreateShopViewController
#pragma lazy-load

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
- (ZGRelayoutButton *)commonShopBtn{
    if (_commonShopBtn == nil) {
        _commonShopBtn = [ZGRelayoutButton buttonWithType:UIButtonTypeCustom];
        _commonShopBtn.imageSize = CGSizeMake(70, 70);
        _commonShopBtn.type = ZGRelayoutButtonTypeBottom;
        [_commonShopBtn setTitleColor:[ManagerEngine getColor:@"20a0ff"] forState:UIControlStateNormal];
        _commonShopBtn.titleLabel.font = [UIFont systemFontOfSize:40/3];
        [_commonShopBtn setTitle:@"创建普通店铺" forState:UIControlStateNormal];
        [_commonShopBtn setImage:[UIImage imageNamed:@"shop"] forState:UIControlStateNormal];
        [_commonShopBtn bk_addEventHandler:^(id  _Nonnull sender) {
            [MBProgressHUD show:@"验证码已发送" icon:@"check-circle" view:self.view];
            
        } forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_commonShopBtn];
        
    }
    return _commonShopBtn;
}
- (UIView *)verticalView{
    if ( _verticalView  == nil ) {
        _verticalView = [[UIView alloc]init];
        _verticalView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
        [self.view addSubview:_verticalView];
    }
    
    return _verticalView;
}

- (ZGRelayoutButton *)mygttBtn{
    
    if (_mygttBtn == nil) {
        _mygttBtn = [ZGRelayoutButton buttonWithType:UIButtonTypeCustom];
        _mygttBtn.imageSize = CGSizeMake(70, 70);
        _mygttBtn.type = ZGRelayoutButtonTypeBottom;
        [_mygttBtn setTitleColor:GrayColor forState:UIControlStateNormal];
        _mygttBtn.titleLabel.font = [UIFont systemFontOfSize:40/3];
        [_mygttBtn setTitle:@"创建共同体" forState:UIControlStateNormal];
        [_mygttBtn setImage:[UIImage imageNamed:@"jointly"] forState:UIControlStateNormal];
        [self.view addSubview:_mygttBtn];
        
    }
    return _mygttBtn;
}

- (UIButton *)createShopBtn{
    if (_createShopBtn == nil) {
        _createShopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_createShopBtn setTitleColor:RedColor forState:UIControlStateNormal];
        _createShopBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_createShopBtn setTitle:@"如何创建店铺？" forState:UIControlStateNormal];
        [self.view addSubview:_createShopBtn];
        
    }
    return _createShopBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self layoutTheSubViews];
    
    // Do any additional setup after loading the view.
}
#pragma private method
- (void)layoutTheSubViews{
    
    self.logoImageView.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.view,S_XRatioH(170.0f/3)+StatusBarHeight).heightIs(S_XRatioH(154.0f/3)).widthIs(S_XRatioW(76.0f));
    
    self.topicLabel.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.logoImageView,S_XRatioH(50.0f)).heightIs(S_XRatioH(20.0f)).widthIs(S_XRatioW(300.0f));
    
    self.verticalView.sd_layout.leftSpaceToView(self.view,WIDTH/2).topSpaceToView(self.topicLabel,S_XRatioH(100.0f)).heightIs(100.0f).widthIs(0.5f);

    self.commonShopBtn.sd_layout.rightSpaceToView(self.verticalView,30.0f).centerYEqualToView(self.verticalView).heightIs(110.0f).widthIs(80.0f);
    
    self.mygttBtn.sd_layout.leftSpaceToView(self.verticalView,30.0f).centerYEqualToView(self.verticalView).heightIs(110.0f).widthIs(80.0f);
    
    self.createShopBtn.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.commonShopBtn,S_XRatioH(470.0f/3)).heightIs(20.0f).widthIs(200.0f);
    
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
