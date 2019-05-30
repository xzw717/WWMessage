//
//  SetBindingCell.m
//  HQJBusiness
//
//  Created by mymac on 2019/5/30.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "SetBindingCell.h"
@interface SetBindingCell ()
//@property (nonatomic, strong) *name;
@property (nonatomic, strong) UILabel *bindingLabel;

@end
@implementation SetBindingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.bindingLabel];
        [self.bindingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(-30);
        }];
    }
    return self;
}
- (void)setIsHiddenLabel:(BOOL)isHiddenLabel {
    self.bindingLabel.hidden = isHiddenLabel;
}
- (UILabel *)bindingLabel {
    if (!_bindingLabel) {
        _bindingLabel = [[UILabel alloc]init];
        _bindingLabel.textColor = [ManagerEngine getColor:@"cccccc"];
        _bindingLabel.text = @"已绑定";
    }
    return _bindingLabel;
}
@end
