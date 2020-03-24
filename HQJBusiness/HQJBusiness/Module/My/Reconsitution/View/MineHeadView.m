//
//  MineHeadView.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/2.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MineHeadView.h"

#define  HeadTopSpacing  38/3.f
#define  HeadLeftSpacing  54/3.f
#define  HeadImageSize 178/3.f

#define  NameLabelTopSpacing  68/3.f
#define  StateLabelTopSpacing  25/3.f

#define  StateImageSize 53/3.f

#define  MinSpacing  5.f

@interface MineHeadView ()

@property (nonatomic,strong)UIImageView *headImageView;

@property (nonatomic,strong)UILabel *nameLabel;

@property (nonatomic,strong)UIImageView *stateImageView;

@property (nonatomic,strong)UILabel *stateLabel;

@property (nonatomic,strong)UIButton *qrCodeButton;

@property (nonatomic,strong)UIButton *rightButton;

@end


@implementation MineHeadView


#pragma lazy-load

- (UIImageView *)headImageView{
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc]init];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 10;
        _headImageView.layer.borderColor = [ManagerEngine getColor:@"66ffff"].CGColor;
        _headImageView.layer.borderWidth = 2.f;
        [self addSubview:_headImageView];
    }
    return _headImageView;
}
- (UIImageView *)stateImageView{
    if (_stateImageView == nil) {
        _stateImageView = [[UIImageView alloc]init];
        _stateImageView.image = [UIImage imageNamed:@"my_iocn_source"];
        [self addSubview:_stateImageView];
    }
    return _stateImageView;
}

-(UILabel *)nameLabel {
    if ( _nameLabel == nil ) {
        _nameLabel =  [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:17.f];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.text = @"商家名称";
        [self addSubview:_nameLabel];
    }
    
    
    return _nameLabel;
}
-(UILabel *)stateLabel {
    if ( _stateLabel == nil ) {
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.font = [UIFont systemFontOfSize:12.f];
        _stateLabel.textColor = [ManagerEngine getColor:@"ccffff"];
        _stateLabel.text = @"已溯源  |  联盟商家";
        [self addSubview:_stateLabel];
    }
    return _stateLabel;
}
- (UIButton *)qrCodeButton{
    if ( _qrCodeButton == nil ) {
        _qrCodeButton = [UIButton buttonWithType:0];
        [_qrCodeButton setImage:[UIImage imageNamed:@"my_icon_ewm_white"] forState:UIControlStateNormal];
        [self addSubview:_qrCodeButton];
    }
    return _qrCodeButton;
}

- (UIButton *)rightButton{
    if ( _rightButton == nil ) {
        _rightButton = [UIButton buttonWithType:0];
        [_rightButton setImage:[UIImage imageNamed:@"my_button_enter_white"] forState:UIControlStateNormal];
        
        [self addSubview:_rightButton];
    }
    return _rightButton;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame ];
    if (self) {
        self.backgroundColor = DefaultAPPColor;
        self.userInteractionEnabled = YES;
        [self layoutTheSubViews];
    }
    return self;
}

- (void)layoutTheSubViews{
    self.headImageView.sd_layout.centerYEqualToView(self).leftSpaceToView(self,HeadLeftSpacing).heightIs(HeadImageSize).widthIs(HeadImageSize);
    self.nameLabel.sd_layout.topSpaceToView(self,NameLabelTopSpacing).leftSpaceToView(self.headImageView,HeadLeftSpacing).widthIs(200.f);
    self.stateImageView.sd_layout.topSpaceToView(self.nameLabel,StateLabelTopSpacing).leftSpaceToView(self.headImageView,HeadLeftSpacing).heightIs(StateImageSize).widthIs(StateImageSize);
    self.stateLabel.sd_layout.centerYEqualToView(self.stateImageView).leftSpaceToView(self.stateImageView,MinSpacing).heightIs(20.f).widthIs(200.f);
    
    self.rightButton.sd_layout.centerYEqualToView(self.headImageView).rightSpaceToView(self,HeadLeftSpacing).heightIs(57/3.f).widthIs(41/3.f);
    self.qrCodeButton.sd_layout.centerYEqualToView(self.headImageView).rightSpaceToView(self.rightButton,MinSpacing).heightIs(63/3.f).widthIs(65/3.f);
    
}

- (void)setModel:(ShopModel *)model{
    self.nameLabel.text = model.realname;
    self.stateLabel.text =[NSString stringWithFormat:@"已溯源  |  %@",model.isSource];
    
//    [NameSingle shareInstance].name = xzw_model.realname; // --- 单例存商家名字
//    [NameSingle shareInstance].role = xzw_model.role;   //  -----   存商家类型
//    [NameSingle shareInstance].mobile = xzw_model.mobile;
//    [NameSingle shareInstance].memberid = xzw_model.memberid;
}

@end
