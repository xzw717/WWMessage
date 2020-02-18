//
//  GoodsReleaseMainCell.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/12.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "GoodsReleaseMainCell.h"
#import "EvaluationTextView.h"
#import "GoodsReleaseModel.h"

#define LeftRigthEdge (72 / 3.f)
#define PriceText @"PriceText"
@interface GoodsReleaseMainCell ()<UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UILabel *mainTitleLabel;
@property (nonatomic, strong) UITextField *countTextfield;
@property (nonatomic, strong) EvaluationTextView *textView;
@property (nonatomic, strong) UILabel *remainingStringLabel;
@property (nonatomic, strong) UIImageView *rightArrowImageView;
@property (nonatomic, strong) GoodsReleaseModel *model;
@end
@implementation GoodsReleaseMainCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSeparatorInset:UIEdgeInsetsMake(0, LeftRigthEdge, 0, 0)];
        [self goodsReleaseMainCell_addSubviews];
        [self updateConstraintsIfNeeded];
 
    }
    return self;
}


- (void)setModel:(GoodsReleaseModel *)model {
    _model = model;
    if ([self.countTextfield.placeholder isEqualToString:@"请输入商品标题"]) {
        self.countTextfield.text = model.goodsName;
    } else if ([self.countTextfield.placeholder isEqualToString:@"请输入商品售价"]) {
        self.countTextfield.text = model.price;

    } else if ([self.countTextfield.placeholder isEqualToString:@"系统自动计算"]) {
        self.countTextfield.text = model.discountPrice;

    } else if ([self.countTextfield.placeholder isEqualToString:@"请输入库存数量"]) {
        self.countTextfield.text = model.inventory;

    } else if ([self.countTextfield.placeholder isEqualToString:@"请输入商品介绍"]) {
        self.countTextfield.text = model.introduce;

    } else {
        self.countTextfield.text = model.discount;

    }
}



- (void)textChange :(NSNotification*)notice {
    NSLog(@"调用了");
//        !self.cellUpdata? :self.cellUpdata(self.countTextfield.text);
}
- (void)textFieldDidChange:(UITextField *)textField{
    if (textField.markedTextRange == nil) {
        NSLog(@"text:%@", textField.text);
        [GoodsReleaseModel shareInstance].price = textField.text;
        CGFloat price = [[GoodsReleaseModel shareInstance].price floatValue];
        CGFloat propor = [[GoodsReleaseModel shareInstance].discount floatValue];
        [GoodsReleaseModel shareInstance].discountPrice = [NSString stringWithFormat:@"%.2f",price *propor];

        !self.cellUpdata? :self.cellUpdata();

    }
}
- (void)cellWithPricetext:(NSString *)priceText proportion:(NSString *)pro {
    CGFloat price = [priceText floatValue];
    CGFloat propor = [pro floatValue];
    self.countTextfield.text = [NSString stringWithFormat:@"%.2f",price * propor];
}

- (void)mainDataWithTitle:(NSString *)tit countPlaceholder:(NSString *)placeholder{
    self.mainTitleLabel.text = tit;
    self.countTextfield.placeholder = placeholder;
    self.textView.placeholder = placeholder;
    [GoodsReleaseModel shareInstance].discount = @"0.9";
    if ([tit isEqualToString:@"商品目录"]) {
        self.rightArrowImageView.hidden = NO;
        self.countTextfield.hidden = YES;
        self.textView.hidden = YES;
        self.remainingStringLabel.hidden = YES;
        if ([GoodsReleaseModel shareInstance].goodsName) {
            self.countTextfield.text = [GoodsReleaseModel shareInstance].goodsName;
        }
    } else if ([tit isEqualToString:@"商品介绍"]) {
        self.rightArrowImageView.hidden = YES;
        self.countTextfield.hidden = YES;
        self.textView.hidden = NO;
        self.remainingStringLabel.hidden = NO;
        if ([GoodsReleaseModel shareInstance].introduce) {
            self.textView.text = [GoodsReleaseModel shareInstance].introduce;
        }
    } else {
        self.rightArrowImageView.hidden = YES;
        self.countTextfield.hidden = NO;
        self.textView.hidden = YES;
        self.remainingStringLabel.hidden = YES;
    }
    
    if ([tit isEqualToString:@"折扣比例"]) {
        self.countTextfield.textColor = [ManagerEngine getColor:@"909399"];
    } else {
        self.countTextfield.textColor = [ManagerEngine getColor:@"000000"];

    }
    if ([tit isEqualToString:@"商品售价(元)"]) {
        [self.countTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        if ([GoodsReleaseModel shareInstance].price) {
            self.countTextfield.text = [GoodsReleaseModel shareInstance].price;
        }
    }
    if ([tit isEqualToString:@"折后价(元)"]) {
        if ([GoodsReleaseModel shareInstance].discountPrice && [[GoodsReleaseModel shareInstance].discountPrice floatValue] > 0) {
            self.countTextfield.text = [GoodsReleaseModel shareInstance].discountPrice;
        }
    }
    
    if ([tit isEqualToString:@"库存"]) {
        if ([GoodsReleaseModel shareInstance].introduce) {
            self.countTextfield.text = [GoodsReleaseModel shareInstance].inventory;
        }
    }
    
#pragma mark --- 键盘风格
    if ([tit isEqualToString:@"商品标题"] ||
        [tit isEqualToString:@"商品介绍"]) {
        self.countTextfield.keyboardType = UIKeyboardTypeDefault;

    } else {
        self.countTextfield.keyboardType = UIKeyboardTypeDecimalPad;

    }
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField.placeholder isEqualToString:@""] ||
        textField.placeholder == nil  ||
        [textField.placeholder isEqualToString:@"系统自动计算"] ||
        [textField.placeholder isEqualToString:@"美食"] ||
        [textField.placeholder isEqualToString:@"0.9"]) {
        return NO;
    } else {
        return YES;

    }
}
- (void)textViewDidEndEditing:(UITextView *)textView {
//    !self.textContentBlock ? : self.textContentBlock(textView.text);
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    self.remainingStringLabel.text = [NSString stringWithFormat:@"%ld/120",textView.text.length];
}

- (void)goodsReleaseMainCell_addSubviews {
    [self.contentView addSubview:self.mainTitleLabel];
    [self.contentView addSubview:self.countTextfield];
    [self.contentView addSubview:self.textView];
    [self.contentView addSubview:self.remainingStringLabel];
    [self.contentView addSubview:self.rightArrowImageView];
}

- (void)updateConstraints {
    [self.mainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(LeftRigthEdge);
        make.top.mas_equalTo(48 / 3.f);
    }];
    [self.countTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-LeftRigthEdge);
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.mainTitleLabel.mas_right).mas_offset(LeftRigthEdge);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mainTitleLabel);
        make.height.mas_equalTo(170 / 3.f);
        make.right.mas_equalTo(self.countTextfield);
        make.bottom.mas_equalTo(-135 / 3.f);
    }];
//
    [self.remainingStringLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.countTextfield);
        make.bottom.mas_equalTo(-48 / 3.f);
    }];
    [self.rightArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(- 72 / 3.f);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(15 / 2.f, 27 / 2.f));
    }];
    
    [self.mainTitleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.countTextfield setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [super updateConstraints];
}
- (UILabel *)mainTitleLabel {
    if (!_mainTitleLabel) {
        _mainTitleLabel = [[UILabel alloc]init];
        [_mainTitleLabel setFont:[UIFont systemFontOfSize:48 / 3.f]];
        [_mainTitleLabel setTextColor:[ManagerEngine getColor:@"909399"]];
    }
    return _mainTitleLabel;
}

- (UITextField *)countTextfield {
    if (!_countTextfield) {
        _countTextfield = [[UITextField alloc]init];
        [_countTextfield setFont:[UIFont systemFontOfSize:48 / 3.f]];
        _countTextfield.textAlignment = NSTextAlignmentRight;
        _countTextfield.keyboardType = UIKeyboardTypeDefault;
        _countTextfield.delegate = self;
    }
    return _countTextfield;
}

- (EvaluationTextView *)textView {
    if (!_textView) {
        _textView = [[EvaluationTextView alloc]init];
        [_textView setDelegate:self];
        [_textView setPlaceholder:@"请输入商品介绍"];
        [_textView setPlaceholderColor:[UIColor lightGrayColor]];
        [_textView setPlaceholderFont:[UIFont systemFontOfSize:15.0f]];
        [_textView setBackgroundColor:[UIColor whiteColor]];
        
    }
    return _textView;
}

- (UILabel *)remainingStringLabel {
    if (!_remainingStringLabel) {
        _remainingStringLabel = [[UILabel alloc]init];
        [_remainingStringLabel setFont:[UIFont systemFontOfSize:48 / 3.f]];
        [_remainingStringLabel setTextColor:[ManagerEngine getColor:@"909399"]];
        [_remainingStringLabel setText:@"0/120"];
    }
    return _remainingStringLabel;
}
- (UIImageView *)rightArrowImageView {
    if (!_rightArrowImageView) {
        _rightArrowImageView = [[UIImageView alloc]init];
        _rightArrowImageView.image = [UIImage imageNamed:@"goodsRelease_enter"];
    }
    return _rightArrowImageView;
}
@end
