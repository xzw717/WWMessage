//
//  PersonInfoCell.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/4.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ShopInfoTextCell.h"




#define LeftSpace 70/3.f
#define RightSpace 16.f
#define IconSpace 70/3.f

@interface ShopInfoTextCell ()<UITextViewDelegate>
@end
@implementation ShopInfoTextCell


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.textColor = [ManagerEngine getColor:@"909399"];
    }
    return _titleLabel;
}
- (UITextView *)textView{
    if ( _textView == nil ) {
        _textView = [[UITextView alloc]init];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.textColor = [UIColor blackColor];
        _textView.delegate = self;
        _textView.keyboardType = UIKeyboardTypeDefault;
        //    textView.text = @"请写在自定义属性前面，如果长度大于limitLength设置长度会被自动截断。";
        _textView.limitLength = @120;
        _textView.placeholdColor = [ManagerEngine getColor:@"909399"];
        _textView.limitPlaceColor = [ManagerEngine getColor:@"909399"];
        _textView.placeholdFont = [UIFont systemFontOfSize:16];
        _textView.limitPlaceFont = [UIFont systemFontOfSize:16];
        //    textView.autoHeight = @1;
        //    textView.limitLines = @4;//行数限制优先级低于字数限制
        _textView.infoBlock = ^(NSString *text, CGSize textViewSize) {
            NSLog(@"当前文字: %@   当前高度:%lf",text,textViewSize.height);
        };
        
    }
    return _textView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addTheSubviews];
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (void)addTheSubviews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.textView];
}

- (void)updateConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(16.f);
        make.left.mas_offset(LeftSpace);
        make.right.mas_offset(-LeftSpace);
        make.height.mas_equalTo(20.f);
    }];

    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel).offset(20.f);
        make.bottom.mas_equalTo(self).offset(-20.f);
        make.left.mas_offset(20.f);
        make.right.mas_offset(-20.f);
    }];
    [super updateConstraints];
}

#pragma mark --
#pragma mark ---UITextView Delegate


- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    return YES;
}
//- (void)textFieldChanged:(UITextField *)textField
//{
//    NSLog(@"值是---%@",textField.text);
//    self.titleLabel.text = [NSString stringWithFormat:@"%ld/120",textField.text.length];
//
//}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
