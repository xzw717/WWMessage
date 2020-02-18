//
//  NewMessageImageView.m
//  HQJBusiness
//
//  Created by mymac on 2019/6/29.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "NewMessageImageView.h"


#define backgroundCornerRadius (28 / 3.f)
#define backgroundCornerSmallRadius (numbeSmallrFont + 4 * 2)

#define numberCornerRadius (26 / 3.f)
#define numberFont (36 / 3.f)
#define numbeSmallrFont (17 / 3.f)

#define redViewHeight (52 / 3.f)
#define redSuperViewHeight (56 / 3.f)
#define redSuperViewSmallHeight (39 / 3.f)

#define redViewTopEdge (2.5f)
#define redViewleftEdge (6.f)

#define topLabelFont (40 / 3.f)
#define topImageHeight (49.f)
#define topImageLabelSpacing (26 / 3.f)


//#define numberCornerRadius (26 / 3.f)
//#define numberCornerRadius (26 / 3.f)

@interface NewMessageImageView ()
@property (nonatomic, strong) UILabel *numberLabel; /// 红色数字小红点
@property (nonatomic, assign) redViewStyle style; /// 红色数字小红点

@end
@implementation NewMessageImageView

- (instancetype)initWithHintStyle:(redViewStyle)style {
    self = [super init];
    if (self) {
        self.style = style;
        [self addSubview:self.numberLabel];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageView:)];
        [self addGestureRecognizer:tap];
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.left.mas_equalTo(self.mas_right).mas_offset(-backgroundCornerRadius);
            make.height.mas_equalTo(backgroundCornerRadius);
            make.width.mas_equalTo(numberFont);
            
        }];
        
    }
    return self;
}
- (void)clickImageView:(UITapGestureRecognizer *)tap {
    !self.tapImage ? :self.tapImage();
}
#pragma mark --- 设置消息数量
-  (void)setNumbaer:(NSInteger)count {
    self.numberLabel.hidden = NO;
    static NSString *counts;
    if (count > 99) {
        counts = @"99+";
    }else if (count >0) {
        counts = [NSString stringWithFormat:@"%ld",count];
    } else {
        if (self.style == redViewStyleNumber) {
            self.numberLabel.hidden = YES;
        } else {
            counts = @"";

        }
    }
    self.numberLabel.text = counts;
    [self messageHintView_needUpdateLayout];
}

- (void)hiddeRedView {
    self.numberLabel.hidden = YES;
}

- (void)setStyle:(redViewStyle)style {
    _style = style;
    if (style == redViewStyleNumber) return;
    if (style == redViewStyleSmallNumber) {
        self.numberLabel.layer.borderColor = DefaultAPPColor.CGColor;
        self.numberLabel.font = [UIFont systemFontOfSize:numbeSmallrFont];
        self.numberLabel.layer.cornerRadius = redSuperViewSmallHeight / 2.f;
    }
}
#pragma mark --- 更新约束
- (void)messageHintView_needUpdateLayout {
    NSInteger textCount = self.numberLabel.text.length;
    CGFloat width1=[self.numberLabel.text boundingRectWithSize:CGSizeMake(1000, redSuperViewSmallHeight +5) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:numbeSmallrFont]} context:nil].size.width;
 
   
    CGFloat numbaerWidth = 0.0f;
    CGFloat proportion = 0.0f;
    if (textCount > 1) {
        numbaerWidth = 8 * textCount;
        if (width1 < (redSuperViewSmallHeight + 5)) {
            width1 = redSuperViewSmallHeight + 5;
        }
        if (textCount > 2) {
            proportion = 1 / 2.f;
        } else {
            proportion = 2 / 3.f;
            
        }
        
    } else {
        proportion = 3 / 4.f;
        numbaerWidth = numberFont * textCount;
        width1 = redSuperViewSmallHeight;
    }
//    if (self.style == redViewStyleSmallNumber) {
//        numbaerWidth = 6 * textCount;
//
//    }
    if (self.style == redViewStyleDefault) {
        self.numberLabel.layer.cornerRadius = 5;
        self.numberLabel.layer.masksToBounds = YES;

        [self.numberLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(10);
            make.left.mas_equalTo(self.mas_right).mas_offset(-10 * proportion);

        }];

    }
    if (self.style == redViewStyleNumber) {
        [self.numberLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(numbaerWidth + 13 / 3 * 2);
            make.height.mas_equalTo(numberFont + 13 / 3 * 2);
            make.left.mas_equalTo(self.mas_right).mas_offset(- (numbaerWidth + 13 / 3 * 2) * proportion);
            
        }];
    }
    if (self.style == redViewStyleSmallNumber) {
        [self.numberLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width1);
            make.height.mas_equalTo(redSuperViewSmallHeight);
            make.left.mas_equalTo(self.mas_right).mas_offset(- width1  * proportion);
            
        }];
    }
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.text = @" ";
        _numberLabel.hidden = YES;
        _numberLabel.layer.cornerRadius = backgroundCornerRadius;
        _numberLabel.layer.backgroundColor = [ManagerEngine getColor:@"ff494b"].CGColor;
        _numberLabel.layer.masksToBounds = YES;
        _numberLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        _numberLabel.layer.borderWidth = 1.f;
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.font = [UIFont systemFontOfSize:numberFont];
        _numberLabel.clipsToBounds = YES;
    }
    return _numberLabel;
}

@end
