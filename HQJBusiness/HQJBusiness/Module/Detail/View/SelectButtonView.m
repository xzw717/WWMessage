//
//  SelectButtonView.m
//  HQJBusiness
//
//  Created by mymac on 2017/9/8.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "SelectButtonView.h"
@interface SelectButtonView ()
@property (nonatomic, strong) NSMutableArray <UIButton *>*modeButtonArray;
@property (nonatomic, strong) UIView *bottomlineView;
@property (nonatomic, strong) UIButton *oldButton;
@end
@implementation SelectButtonView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.modeButtonArray = [NSMutableArray array];

        [self addButton];
        
        [self addSubview:self.bottomlineView];
    }
    
    return self;
}

- (void)addButton {
    for (NSInteger i = 0; i < 2; i++ ) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        /// 取整
        int a = i%2;
        button.frame = CGRectMake(WIDTH/2 * a, 0, WIDTH/2, 40);
        button.tag = i + 200;
        [button setTitle:[self titleArray][i] forState:UIControlStateNormal];
        [button setTitleColor:i == 0 ? [UIColor orangeColor] : [UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickModeButton:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            _oldButton = button;
        }
        [self.modeButtonArray addObject:button];
        [self addSubview:button];
    }
    NSLog(@"%@",self.modeButtonArray);
}

- (NSArray *)titleArray {
    return @[@"线上支付",
             @"线下支付"];
}

- (void)clickModeButton:(UIButton *)btn {
    
    if (_oldButton == btn) {
        
    } else {
        [btn setTitleColor:[UIColor orangeColor]  forState:UIControlStateNormal];
        [_oldButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }
    _oldButton = btn;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomlineView.center = CGPointMake(btn.center.x, btn.center.y + 20);

    }];
    !self.titleStr ? : self.titleStr(btn.titleLabel.text);
}


- (UIView *)bottomlineView {
    if (!_bottomlineView) {
        _bottomlineView = [[UIView alloc]init];
        [self.modeButtonArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.tag == 200) {
                self.bottomlineView.center = CGPointMake(obj.center.x, obj.center.y + 20);
            }
        }];
        _bottomlineView.bounds = CGRectMake(0, 0, WIDTH / 3, 1);
        _bottomlineView.backgroundColor = [UIColor orangeColor];
    }
    return _bottomlineView;
}



@end
