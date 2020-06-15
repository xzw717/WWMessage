//
//  RegisterViewController.m
//  HQJBusiness
//
//  Created by 姚 on 2019/6/26.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "SetUpShopViewController.h"


@interface SetUpShopViewController ()

@property (nonatomic,strong)UIButton *backBtn;

@property (nonatomic,strong)UIImageView *logoImageView;

@property (nonatomic,strong)UILabel *topicLabel;


@property (nonatomic,strong)UIImageView *shopImageView;
@property (nonatomic,strong)UILabel *shopSuccessLabel;
@property (nonatomic,strong)UILabel *applyShopLabel;

@property (nonatomic,strong)UIButton *confirmBtn;
@end

@implementation SetUpShopViewController

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
- (UIImageView *)shopImageView{
    if ( _shopImageView  == nil ) {
        _shopImageView = [[UIImageView alloc]init];
        _shopImageView.image = [UIImage imageNamed:@"icon_shop"];
        [self.view addSubview:_shopImageView];
    }
    
    return _shopImageView;
}
- (UILabel *)shopSuccessLabel{
    if ( _shopSuccessLabel  == nil ) {
        _shopSuccessLabel = [[UILabel alloc]init];
        _shopSuccessLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        _shopSuccessLabel.text = @"恭喜您，开店成功！";
        _shopSuccessLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_shopSuccessLabel];
    }
    
    return _shopSuccessLabel;
}


- (UILabel *)applyShopLabel{
    if ( _applyShopLabel  == nil ) {
        _applyShopLabel = [[UILabel alloc]init];
        _applyShopLabel.font = [UIFont boldSystemFontOfSize:40.0f/3];
        _applyShopLabel.text = @"赶紧上传商品吧";
        _applyShopLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_applyShopLabel];
    }
    
    return _applyShopLabel;
}
- (UIButton *)confirmBtn{
    if ( _confirmBtn == nil ) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"进入店铺" forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = DefaultAPPColor;
        _confirmBtn.layer.masksToBounds = YES;
        _confirmBtn.layer.cornerRadius = S_XRatioH(145/6);
        _confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:50/3];
        [self.view addSubview:_confirmBtn];
    }
    
    return _confirmBtn;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navType = HQJNavigationBarBlue;
    self.isHideShadowLine = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self layoutTheSubViews];
    
    // Do any additional setup after loading the view.

    
}
#pragma private method
- (void)layoutTheSubViews{
    
    self.logoImageView.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.view,S_XRatioH(170.0f/3)).heightIs(S_XRatioH(154.0f/3)).widthIs(S_XRatioW(76.0f));
    
    self.topicLabel.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.logoImageView,S_XRatioH(50.0f)).heightIs(S_XRatioH(20.0f)).widthIs(S_XRatioW(300.0f));
    
    self.shopImageView.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.topicLabel,S_XRatioH(50.0f)).heightIs(S_XRatioH(110.0f)).widthIs(S_XRatioW(130.0f));
    
    self.shopSuccessLabel.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.shopImageView,S_XRatioH(100.0f/3)).heightIs(S_XRatioH(20.0f)).widthIs(WIDTH);
    
    self.applyShopLabel.sd_layout.centerXEqualToView(self.view).topSpaceToView(self.shopSuccessLabel,S_XRatioH(50.0f/3)).heightIs(S_XRatioH(20.0f)).widthIs(WIDTH);
    
    self.confirmBtn.sd_layout.centerXEqualToView(self.view).bottomSpaceToView(self.view, S_XRatioH(102.0f/3)).heightIs(S_XRatioH(145.0f/3)).widthIs(WIDTH-S_XRatioW(110.0f/3));

}


-(void)nextStep{
//    NSMutableDictionary *dict = @{@"newpwd":self.pswText.text,
//                 @"pwdtype":@2,
//                 @"mobile":[NameSingle shareInstance].mobile,
//                 @"inputcode":self.authCodeText.text}.mutableCopy;
//
//    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBonusDomainName,HQJBInputNewpwdActionInterface];
//
//    [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
//        if ([dic[@"code"]integerValue] == 49000) {
//            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
//            [ManagerEngine SVPAfter:@"修改成功" complete:^{
//                [self.navigationController popViewControllerAnimated:YES];
//            }];
//        }else{
//            [SVProgressHUD showSuccessWithStatus:@"修改失败"];
//            [ManagerEngine dimssLoadView:self.confirmBtn andtitle:@"确认"];
//        }
//
//    } andError:^(NSError *error) {
//        [ManagerEngine dimssLoadView:self.confirmBtn andtitle:@"确认"];
//
//    } ShowHUD:YES];
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
