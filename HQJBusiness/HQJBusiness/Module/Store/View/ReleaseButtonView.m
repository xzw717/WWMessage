//
//  ReleaseButtonView.m
//  HQJBusiness
//  商品编辑，商品发布 下面的按钮
//  Created by mymac on 2019/7/16.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ReleaseButtonView.h"
@interface ReleaseButtonView (){
    NSString *title;
}
@property (nonatomic, assign) ReleaseButtonStyle style;
/// 发布按钮
@property (nonatomic, strong) UIButton *releaseButton;
/// 保存按钮
@property (nonatomic, strong) UIButton *saveButton;

@end
@implementation ReleaseButtonView
- (instancetype)initWithReleaseButtonStyle:(ReleaseButtonStyle)style {
    self = [super init];
    if (self) {
        _style = style;
        switch (style) {
            case ReleaseButtonStylePublishNow:
                title = @"立即发布";
                break;
            case ReleaseButtonStyleSaveSubmit:
                title = @"保存并提交";
                break;
            case ReleaseButtonStyleSaveAndPublishNow:
                title = @"立即发布";
                break;
            default:
                break;
        }
        [self releaseButtonView_addSubView];
        [self releaseButtonView_layoutSubView];
    }
    return self;
}
- (void)clickReleaseButton {
    if (self.releaseButtonDelegate &&[self.releaseButtonDelegate respondsToSelector:@selector(clickRealeaseBtn)]) {
        [self.releaseButtonDelegate clickRealeaseBtn];
    }
    !self.clickRealeaseBtnBlock ? :self.clickRealeaseBtnBlock();
}
- (void)clickSaveButton {
    if (self.releaseButtonDelegate &&[self.releaseButtonDelegate respondsToSelector:@selector(clickSaveBtn)]) {
        [self.releaseButtonDelegate clickSaveBtn];
    }
    !self.clickSaveBtnBlock ? :self.clickSaveBtnBlock();

}
- (void)releaseButtonView_addSubView {
    [self addSubview:self.releaseButton];
    [self addSubview:self.saveButton];
}
- (void)releaseButtonView_layoutSubView {
    if (_style == ReleaseButtonStylePublishNow ||
        _style == ReleaseButtonStyleSaveSubmit) {
        self.saveButton.hidden = YES;
        [self.releaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(32 / 3.f);
            make.left.mas_equalTo(55 / 3.f);
            make.right.mas_equalTo(-55 / 3.f);
            make.height.mas_equalTo(145 / 3.f);
        }];
    } else {
        self.saveButton.hidden = NO;
        [self.releaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(32 / 3.f);
            make.right.mas_equalTo(-82 / 3.f);
            make.height.mas_equalTo(145 / 3.f);
            make.width.mas_equalTo(self.mas_width).multipliedBy(0.37);
        }];
        
        [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(32 / 3.f);
            make.left.mas_equalTo(82 / 3.f);
            make.height.mas_equalTo(145 / 3.f);
            make.width.mas_equalTo(self.mas_width).multipliedBy(0.37);
        }];
        
        
        
        
    }
    
    
}


- (UIButton *)releaseButton {
    if (!_releaseButton) {
        _releaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _releaseButton.backgroundColor = DefaultAPPColor;
        _releaseButton.layer.masksToBounds = YES;
        _releaseButton.layer.cornerRadius = 73 / 3.f;
        [_releaseButton setTitle:title forState:UIControlStateNormal];
        [_releaseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _releaseButton.titleLabel.font = [UIFont systemFontOfSize:50 / 3.f];
        [_releaseButton addTarget:self action:@selector(clickReleaseButton) forControlEvents:UIControlEventTouchUpInside];

    }
    return _releaseButton;
}
- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveButton.backgroundColor = [UIColor whiteColor];
        _saveButton.layer.masksToBounds = YES;
        _saveButton.layer.cornerRadius = 73 / 3.f;
        _saveButton.layer.borderColor = [ManagerEngine getColor:@"aaaaaa"].CGColor;
        _saveButton.layer.borderWidth =  1/ 3.f;
        [_saveButton setTitle:@"保存草稿" forState:UIControlStateNormal];
        [_saveButton setTitleColor:[ManagerEngine getColor:@"707070"] forState:UIControlStateNormal];
        [_saveButton addTarget:self action:@selector(clickSaveButton) forControlEvents:UIControlEventTouchUpInside];
        _saveButton.titleLabel.font = [UIFont systemFontOfSize:50 / 3.f];
    }
    return _saveButton;
}

@end
