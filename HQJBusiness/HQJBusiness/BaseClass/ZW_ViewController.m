//
//  ZW_ViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/14.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_ViewController.h"

@interface ZW_ViewController ()

@property (nonatomic, strong) UIView *bottomLineView;


@end

@implementation ZW_ViewController
-(UIView *)zwNavView {
    if (!_zwNavView) {
        _zwNavView = [[UIView alloc]init];
        _zwNavView.frame = CGRectMake(0, 0, WIDTH, NavigationControllerHeight);
        _zwNavView.backgroundColor = [UIColor whiteColor];
    }
    
    return _zwNavView;
}

-(UILabel *)zwTitLabel {
    
    if (!_zwTitLabel) {
        _zwTitLabel = [[UILabel alloc]init];
        _zwTitLabel.font = [UIFont systemFontOfSize:18.f];
        _zwTitLabel.textColor = [UIColor blackColor];
        [_zwNavView addSubview:_zwTitLabel];
    }
    
    return _zwTitLabel ;
}

-(UIButton *)zwBackButton {
    if (!_zwBackButton) {
        _zwBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_zwBackButton setImage:[UIImage imageNamed:@"icon_back_arrow_blue"] forState:UIControlStateNormal];
        [_zwBackButton setImage:[UIImage imageNamed:@"icon_back_arrow_blue"] forState:UIControlStateHighlighted];
        [_zwNavView addSubview:_zwBackButton];
    }
    
    
    return _zwBackButton;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc]init];
        _bottomLineView.backgroundColor = [ManagerEngine getColor:@"cccccc"];
    }
    return _bottomLineView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.zwNavView];
    [self.view bringSubviewToFront:self.zwNavView];
    [self.zwNavView addSubview:self.bottomLineView];

    self.zwBackButton.sd_layout.leftSpaceToView(self.zwNavView,0).topSpaceToView(self.zwNavView,NavigationControllerHeight - 44).heightIs(44).widthIs(44);
    self.bottomLineView.sd_layout.leftSpaceToView(self.zwNavView, 0).rightSpaceToView(self.zwNavView, 0).heightIs(0.5).topSpaceToView(self, NavigationControllerHeight - 0.5);
    @weakify(self);
    [self.zwBackButton bk_addEventHandler:^(id  _Nonnull sender) {
        @strongify(self);
        if (self.viewControllerName) {
            
            for (UIViewController* v in self.navigationController.viewControllers) {
                if ([[NSString stringWithFormat:@"%@",[v class]] isEqualToString:self.viewControllerName]) {
                    [self.navigationController popToViewController:v animated:YES];
            
                }
        
            }
            
        
        } else {
            if (self.navigationController.viewControllers && self.navigationController.viewControllers.count > 0) {
                [self.navigationController popViewControllerAnimated:YES];

            } else {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        
        }
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    

}

//设置导航栏主题
- (void)setupNavigationBar
{
    
    //    self.lh_barTintColor = [ManagerEngine getColor:@"00ccb8"];
    
    
    UINavigationBar *appearance = [UINavigationBar appearance];
    //统一设置导航栏颜色，如果单个界面需要设置，可以在viewWillAppear里面设置，在viewWillDisappear设置回统一格式。
    [appearance setBarTintColor:[ManagerEngine getColor:@"18abf5"]];
    
    //导航栏title格式
    NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
    textAttribute[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:18.f];
    [appearance setTitleTextAttributes:textAttribute];
    
}


-(void)setZWrightOneButton:(UIButton *)ZWrightOneButton {
    
    _ZWrightOneButton = ZWrightOneButton;
    
    [self.zwNavView addSubview:ZWrightOneButton];
    
    ZWrightOneButton.sd_layout.rightSpaceToView(self.zwNavView, kEDGE).centerYIs(self.zwNavView.centerY_sd + 20 /2).heightIs(40).widthIs(40);
    
    
}

-(void)setZWrightTwoButton:(UIButton *)ZWrightTwoButton {
    
    _ZWrightTwoButton = ZWrightTwoButton;
    
    [self.zwNavView addSubview:ZWrightTwoButton];
        
    ZWrightTwoButton.sd_layout.leftSpaceToView(self.ZWrightOneButton,WIDTH - 14 * 2 - 22 * 2).topSpaceToView(self.zwNavView,33).heightIs(22).widthIs(22);

    
    
}
-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.fd_prefersNavigationBarHidden = YES;

//    [ManagerEngine navColorStyle:self andColor:[UIColor whiteColor]];
    [ManagerEngine navViewWillAppearColor:self andConmp:^(id  _Nonnull sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    

}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [ManagerEngine navViewWillDisappearColor:self];
    self.fd_prefersNavigationBarHidden = NO;

    [ManagerEngine dismissHomeSvP];
    
}




/*
 * 返回时的类型
 *
 
-(void)setBackStyle:(NavBackStyle)backStyle {
    
    [self backOnAnInterface:backStyle];

    
}

-(void)backOnAnInterface:(NavBackStyle)style {

    if (style == BackOnAnInterfaceStyle) {
        [ManagerEngine navViewWillAppearColor:self andConmp:^(id  _Nonnull sender) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } else  if(style == AlertViewBackStyle){
        
//        self.fd_interactivePopDisabled = YES;
        
        [ManagerEngine navViewWillAppearColor:self andConmp:^(id  _Nonnull sender) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:self.titleStr preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
                
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }];
       
        
    } else {
//        self.fd_interactivePopDisabled = YES;
        [ManagerEngine navViewWillAppearColor:self andConmp:^(id  _Nonnull sender) {
            [self popViews];
        }];
        
    }
    
    
}

*/
-(void)popViews {
    
    for (UIViewController* v in self.navigationController.viewControllers) {
        
        if ([[NSString stringWithFormat:@"%@",[v class]] isEqualToString:self.viewControllerName]) {
            [self.navigationController popToViewController:v animated:YES];
            
        }
        
    }

    
}


-(void)setZw_title:(NSString *)zw_title {
    
    self.zwTitLabel.text = zw_title;
    
    CGFloat titleWidth = [ManagerEngine setTextWidthStr:zw_title andFont:[UIFont systemFontOfSize:18.f]];
    
    self.zwTitLabel.sd_layout.leftSpaceToView(self.zwNavView,(WIDTH - titleWidth) / 2).bottomSpaceToView(self.zwNavView,15).heightIs(18).widthIs(titleWidth);
    
    
    
//    [ManagerEngine navTitle:self andTitle:zw_title];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
