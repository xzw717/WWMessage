//
//  GoodsManageAlertView.m
//  HQJBusiness
//  商品管理提示框
//  Created by mymac on 2019/7/11.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//




#import "GoodsManageAlertView.h"

#define AlertTitleFont (40 /3.f)
@protocol AlertCustomButtonDelegate <NSObject>

@optional
- (void)clickAlertCustomButtonWithTag:(NSInteger)tag;
@end

@interface AlertCustomButton : UIView
@property (nonatomic, strong) id<AlertCustomButtonDelegate> delegate;
@end
@interface AlertCustomButton ()
@property (nonatomic, strong) UILabel *hqjTitleLabel;
@end
@implementation AlertCustomButton


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        [self addSubview:self.hqjTitleLabel];
        [self.hqjTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(40 / 3.f);
            make.right.mas_equalTo(-40 / 3.f);
            make.height.mas_equalTo(100 / 3.f);
            make.center.mas_equalTo(self);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBtn)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)clickBtn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickAlertCustomButtonWithTag:)]) {
        [self.delegate clickAlertCustomButtonWithTag:self.tag];
    }
    
}


- (UILabel *)hqjTitleLabel {
    if (!_hqjTitleLabel) {
        _hqjTitleLabel = [[UILabel alloc]init];
        _hqjTitleLabel.layer.masksToBounds = YES;
        _hqjTitleLabel.layer.cornerRadius = 100 / 3 / 2.f;
        _hqjTitleLabel.layer.borderWidth = 1 / 3.f;
        _hqjTitleLabel.font = [UIFont systemFontOfSize:AlertTitleFont];
        _hqjTitleLabel.textAlignment = NSTextAlignmentCenter;
        _hqjTitleLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBtn)];
        [_hqjTitleLabel addGestureRecognizer:tap];
    }
    return _hqjTitleLabel;
}
@end



@interface GoodsManageAlertView () <AlertCustomButtonDelegate>
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) AlertCustomButton *noButton;
@property (nonatomic, strong) AlertCustomButton *yesButton;

@property (nonatomic, copy) GoodsManageAlertViewBlock deny; /// 否认
@property (nonatomic, copy) GoodsManageAlertViewBlock affirm; /// 确定

@end
@implementation GoodsManageAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    if (self) {
        [self goodsManageAlertView_addSubView];
        [self goodsManageAlertView_layoutSubView];
        [[UIApplication sharedApplication].delegate.window addSubview:self];
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.5];
        [CustomWindow addSubview:self];
        [UIView animateWithDuration:0.2 animations:^{
            self.maskView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                self.maskView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.14 animations:^{
                    self.maskView.transform = CGAffineTransformMakeScale(1.1, 1.1);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.13 animations:^{
                        self.maskView.transform = CGAffineTransformMakeScale(0.95, 0.95);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.12 animations:^{
                            self.maskView.transform = CGAffineTransformMakeScale(1.05, 1.05);
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.11 animations:^{
                                self.maskView.transform = CGAffineTransformMakeScale(0.98, 0.98);
                            } completion:^(BOOL finished) {
                                [UIView animateWithDuration:0.1 animations:^{
                                    self.maskView.transform = CGAffineTransformMakeScale(1.02, 1.02);
                                } completion:^(BOOL finished) {
                                    self.maskView.transform = CGAffineTransformIdentity;
                                    
                                }];
                            }];
                        }];
                        
                    }];
                    
                }];
                
            }];
            
        }];
    }
    return self;
}

+ (void)alertViewInitWithTitle:(NSString *)title Complete:(GoodsManageAlertViewBlock)complete {
    [GoodsManageAlertView alertViewInitWithTitle:title cancelButtonTitle:nil otherButtonTitles:nil Complete:complete negative:nil];
    
}
+ (void)alertViewInitWithTitle:(nullable NSString *)title
             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
             otherButtonTitles:(nullable id)otherButtonTitles
                      Complete:(nullable GoodsManageAlertViewBlock)complete
                      negative:(nullable GoodsManageAlertViewBlock)negative {
    GoodsManageAlertView *view =  [[GoodsManageAlertView alloc]init];
    view.affirm = complete;
    view.deny = negative;
    view.titleLabel.text = title;
    if (cancelButtonTitle) {
        [view.noButton.hqjTitleLabel setText:cancelButtonTitle];
    }
    if (otherButtonTitles) {
        if ([otherButtonTitles isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict =  otherButtonTitles;
            [dict.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
            }];
            UIColor *color =  otherButtonTitles[AlertViewTitleColor] ? otherButtonTitles[AlertViewTitleColor] :DefaultAPPColor;
            UIFont *font =  otherButtonTitles[AlertViewTitleFont] ? otherButtonTitles[AlertViewTitleFont] : [UIFont systemFontOfSize:AlertTitleFont];
            NSString *title =  otherButtonTitles[AlertViewTitle] ? otherButtonTitles[AlertViewTitle] :@"是";
            [view.yesButton.hqjTitleLabel setText:title];
            [view.yesButton.hqjTitleLabel setFont:font];
            [view.yesButton.hqjTitleLabel setBackgroundColor:color];
            [view.yesButton.hqjTitleLabel.layer setBorderColor:color.CGColor];
            
        } else {
            [view.yesButton.hqjTitleLabel setText:otherButtonTitles];
            
        }
        
    }
}




- (void)clickAlertCustomButtonWithTag:(NSInteger)tag {
    if (tag == 10011) {
        !self.deny ? :self.deny();
        [self goodsManageAlertView_hiddeView];
    } else {
        !self.affirm ? :self.affirm();
        [self goodsManageAlertView_hiddeView];
    }
}

- (void)goodsManageAlertView_hiddeView {
    // 0.2 表示动画时长为0.2秒
    [UIView animateWithDuration:0.25 animations:^{
        // transform 使...变形
        // CGAffineTransformMakeScale(1.2, 1.2) 缩放的比例 缩放为原来的1.2倍
        self.maskView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
     

    }];

}
- (void)goodsManageAlertView_addSubView {
    [self addSubview:self.maskView];
    [self.maskView addSubview:self.titleLabel];
    [self.maskView addSubview:self.lineView];
    [self.maskView addSubview:self.noButton];
    [self.maskView addSubview:self.yesButton];

}
- (void)goodsManageAlertView_layoutSubView {
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(67.5f);
        make.right.mas_equalTo(-67.5f);
        make.height.mas_equalTo(self.maskView.mas_width).multipliedBy(470 / 720.f);
        make.center.mas_equalTo(self);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(137 / 3.f);
        make.centerX.mas_equalTo(self.maskView);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20 / 3.f);
        make.right.mas_equalTo(-20 / 3.f);
        make.bottom.mas_equalTo(- 40 / 3 * 2 - 100 / 3.f);
        make.height.mas_equalTo(.5f);
    }];
    [self.noButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.maskView.mas_width).multipliedBy(.5f);
        make.top.mas_equalTo(self.lineView.mas_bottom);
    }];
    [self.yesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.maskView.mas_width).multipliedBy(.5f);
        make.top.mas_equalTo(self.lineView.mas_bottom);
    }];
}
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]init];
        _maskView.layer.masksToBounds = YES;
        _maskView.layer.cornerRadius = 5.f;
        _maskView.backgroundColor = [UIColor whiteColor];
    }
    return _maskView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"占位标题";
        _titleLabel.textColor = [ManagerEngine getColor:@"010101"];
        _titleLabel.font = [UIFont systemFontOfSize:AlertTitleFont];
    }
    return _titleLabel;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [ManagerEngine getColor:@"d8d6d6"];
    }
    return _lineView;
}

- (AlertCustomButton *)noButton {
    if (!_noButton) {
        _noButton = [[AlertCustomButton alloc]init];
        [_noButton.hqjTitleLabel setBackgroundColor:[UIColor whiteColor]];
        [_noButton.hqjTitleLabel.layer setBorderColor:[UIColor grayColor].CGColor];
        [_noButton.hqjTitleLabel setText:@"否"];
        [_noButton.hqjTitleLabel setTextColor:[UIColor grayColor]];
        _noButton.delegate = self;
        _noButton.tag = 10011;

    }
    return _noButton;
}
- (AlertCustomButton *)yesButton {
    if (!_yesButton) {
        _yesButton = [[AlertCustomButton alloc]init];
        [_yesButton.hqjTitleLabel setBackgroundColor:DefaultAPPColor];
        [_yesButton.hqjTitleLabel.layer setBorderColor:DefaultAPPColor.CGColor];
        [_yesButton.hqjTitleLabel setText:@"是"];
        [_yesButton.hqjTitleLabel setTextColor:[UIColor whiteColor]];
        _yesButton.delegate = self;
        _yesButton.tag = 10012;

    }
    return _yesButton;
}
@end
