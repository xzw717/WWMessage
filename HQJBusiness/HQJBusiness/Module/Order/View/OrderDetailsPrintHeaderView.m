//
//  OrderDetailsHeaderView.m
//  HQJBusiness
//
//  Created by mymac on 2019/5/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "OrderDetailsPrintHeaderView.h"
@interface OrderDetailsPrintHeaderView ()
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIButton *printButton;
@end
@implementation OrderDetailsPrintHeaderView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.stateLabel];
        [self addSubview:self.printButton];
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(37/2.f);
            make.centerY.mas_equalTo(self);
        }];
        [self.printButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-36/2.f);
            make.centerY.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(170/2.f, 28.f));
        }];
    }
    return self;
}

- (void)setStates:(NSString *)states {
    self.stateLabel.text = states;
    if ([states isEqualToString:@"待使用"]) {
        self.stateLabel.textColor = [ManagerEngine getColor:@"f58700"];
    } else if([states isEqualToString:@"待评价"]) {
        
        self.stateLabel.textColor = [ManagerEngine getColor:@"1ab2ff"];
        
    } else if([states isEqualToString:@"退款中"]) {
        
        self.stateLabel.textColor = [ManagerEngine getColor:@"ff5500"];
        
    } else if([states isEqualToString:@"订单取消"]) {
        
        self.stateLabel.textColor = [ManagerEngine getColor:@"ff0000"];
        
    } else {
        
        self.stateLabel.textColor = [ManagerEngine getColor:@"29cc29"];
        
    }
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.textColor = DefaultAPPColor;
        _stateLabel.font = [UIFont systemFontOfSize:18.f weight:UIFontWeightBold];
    }
    return _stateLabel;
}

- (UIButton *)printButton {
    if (!_printButton) {
        _printButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _printButton.layer.masksToBounds = YES;
        _printButton.layer.cornerRadius = 5.f;
        _printButton.backgroundColor = DefaultAPPColor;
        [_printButton setTitle:@"打印" forState:UIControlStateNormal];
        [_printButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        @weakify(self);
        [[_printButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            !self.clickPrint ? : self.clickPrint();
//                BlueToothVC *vc = [[BlueToothVC alloc]init];
//                [self.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _printButton;
}
@end
