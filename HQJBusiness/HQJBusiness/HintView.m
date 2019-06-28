//
//  HintView.m
//  HQJBusiness
//
//  Created by 姚 on 2019/6/25.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "HintView.h"

@interface HintView ()

@property (nonatomic,strong)UIView *maskView;
@property (nonatomic,strong)UIButton *cancelButton;
@property (nonatomic,strong)UILabel *topicLabel;
@property (nonatomic,strong)UIView *divisionView;

@end

@implementation HintView

-(UIView *)maskView {
    if ( _maskView == nil ) {
        _maskView =  [[UIView alloc]init];
        _maskView.backgroundColor = [UIColor whiteColor];
        _maskView.alpha = 1;
        _maskView.layer.masksToBounds = YES;
        _maskView.layer.cornerRadius = 10.0f;
        [self addSubview:_maskView];
    }
    return _maskView;
}
-(UILabel *)topicLabel {
    if ( _topicLabel == nil ) {
        _topicLabel =  [[UILabel alloc]init];
        _topicLabel.font = [UIFont systemFontOfSize:40/3];
        _topicLabel.textColor = [ManagerEngine getColor:@"010101"];
        _topicLabel.textAlignment = NSTextAlignmentLeft;
        _topicLabel.numberOfLines = 2;
        [_topicLabel sizeToFit];
        [self.maskView addSubview:_topicLabel];
    }
    
    
    return _topicLabel;
}

- (UIView *)divisionView{
    if ( _divisionView  == nil ) {
        _divisionView = [[UIView alloc]init];
        _divisionView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
        [self.maskView addSubview:_divisionView];
    }
    
    return _divisionView;
}

- (UIButton *)cancelButton{
    if ( _cancelButton == nil ) {
        _cancelButton =  [UIButton buttonWithType:0];
        [_cancelButton setTitleColor:[ManagerEngine getColor:@"919191"] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:40/3];
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.cornerRadius = S_RatioH(100.0f/6);
        _cancelButton.layer.borderWidth = 1.0f;
        _cancelButton.layer.borderColor = [ManagerEngine getColor:@"919191"].CGColor;
        [_cancelButton bk_addEventHandler:^(id  _Nonnull sender) {
            [self dismssView];
        } forControlEvents:UIControlEventTouchUpInside];
        
        [self.maskView addSubview:_cancelButton];
    }
    return _cancelButton;
}
- (UIButton *)sureButton{
    if ( _sureButton == nil ) {
        _sureButton =  [UIButton buttonWithType:0];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureButton.backgroundColor = [ManagerEngine getColor:@"ff4949"];
        _sureButton.titleLabel.font = [UIFont boldSystemFontOfSize:40/3];
        _sureButton.layer.masksToBounds = YES;
        _sureButton.layer.cornerRadius = S_RatioH(100.0f/6);
        [self.maskView addSubview:_sureButton];
    }
    return _sureButton;
}

-(instancetype)initWithFrame:(CGRect)frame withTopic:(NSString *)topic andSureTitle:(NSString *)sureTitle cancelTitle:(NSString *)cancelTitle{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
        [self enrichSubviews:topic andSureTitle:sureTitle cancelTitle:cancelTitle];
    }
    return self;
}
- (void)enrichSubviews:(NSString *)topic andSureTitle:(NSString *)sureTitle cancelTitle:(NSString *)cancelTitle {
    
    self.maskView.sd_layout.centerYEqualToView(self).centerXEqualToView(self).heightIs(S_RatioH(470.0f/3)).widthIs(S_RatioW(240.0f));
    self.cancelButton.sd_layout.bottomSpaceToView(self.maskView, S_RatioW(40/3)).leftSpaceToView(self.maskView, S_RatioW(40/3)).heightIs(S_RatioH(100.0f/3)).widthIs(S_RatioW(100.0f));
    self.sureButton.sd_layout.bottomSpaceToView(self.maskView, S_RatioW(40/3)).rightSpaceToView(self.maskView, S_RatioW(40/3)).heightIs(S_RatioH(100.0f/3)).widthIs(S_RatioW(100.0f));
    self.divisionView.sd_layout.bottomSpaceToView(self.sureButton, S_RatioW(40/3)).leftSpaceToView(self.maskView, 10).rightSpaceToView(self.maskView, 10).heightIs(0.5f);
    self.topicLabel.sd_layout.topSpaceToView(self.maskView, 30).leftSpaceToView(self.maskView, 25).rightSpaceToView(self.maskView, 25).bottomSpaceToView(self.divisionView, 5);
    self.topicLabel.text = topic;
    [self.sureButton setTitle:sureTitle forState:UIControlStateNormal];
    [self.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
    
}

-(void)dismssView {
    
    [self removeFromSuperview];
    
}
@end
