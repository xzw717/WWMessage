//
//  GoodsManageCell.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/9.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "GoodsManageCell.h"
#import "GoodsManageModel.h"
@interface GoodsManageCell()
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *inventoryLabel;
@property (nonatomic, strong) UIButton *editorButton;
@property (nonatomic, strong) UIButton *shelvesButton;
@property (nonatomic, strong) UIButton *deleteButton;

@end
@implementation GoodsManageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self goodsManageCell_addSubViwe];
        [self updateConstraintsIfNeeded];
   
        
    }
    return self;
}
- (void)setModel:(GoodsManageModel *)model {
    self.titleLabel.text = model.titleStr;
    self.priceLabel.text = model.priceStr;
    self.selectButton.selected = model.isSelect;
    if (self.selectButton.selected == YES) {
        [self.selectButton setImage:[UIImage imageNamed:@"commoditymanagement_button_select"] forState:UIControlStateNormal];
        
    } else {
        [self.selectButton setImage:[UIImage imageNamed:@"commoditymanagement_button_unselect"] forState:UIControlStateNormal];
        
    }
    self.inventoryLabel.text = [NSString stringWithFormat:@"库存：%@  总销量：%@",model.inventory,model.sales];
}

- (void)selectBtnClick:(UIButton *)btn {

    self.selectButton.selected = !self.selectButton.selected;
    if (self.selectButton.selected == YES) {
        [self.selectButton setImage:[UIImage imageNamed:@"commoditymanagement_button_select"] forState:UIControlStateNormal];

    } else {
        [self.selectButton setImage:[UIImage imageNamed:@"commoditymanagement_button_unselect"] forState:UIControlStateNormal];

    }
    !self.cellSelect ? : self.cellSelect(self.selectButton.selected);

}

- (void)editBtn{
    !self.cellEdit ? :self.cellEdit();
}
- (void)shelvesBtn{
   !self.cellShelve ? :self.cellShelve();
}
- (void)deleteBtn{
    !self.cellDelete ? :self.cellDelete(self.deleteButton.currentTitle);
}

- (void)setButtonTitleArray:(NSArray<NSString *> *)buttonTitleArray {
    _buttonTitleArray = buttonTitleArray;
    
    if (buttonTitleArray.count == 3) {
        [self.shelvesButton setHidden:NO];
        [self.editorButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.shelvesButton.mas_left).mas_offset(-56 / 3.f);
        }];
    } else {
        [self.shelvesButton setHidden:YES];
        [self.editorButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.deleteButton.mas_left).mas_offset(-56 / 3.f);
        }];
    }
    if ([buttonTitleArray containsObject:@"删除"]) {
        [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];

    } else {
        [self.deleteButton setTitle:@"下架" forState:UIControlStateNormal];

    }

}

- (void)goodsManageCell_addSubViwe {
    [self.contentView addSubview:self.selectButton];
    [self.contentView addSubview:self.titleImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.inventoryLabel];
    [self.contentView addSubview:self.editorButton];
    [self.contentView addSubview:self.shelvesButton];
    [self.contentView addSubview:self.deleteButton];

}
- (void)updateConstraints {
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(150 / 3.f);
        make.left.mas_equalTo(46 / 3.f);
        make.width.height.mas_equalTo(56 / 3.f);
    }];
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.selectButton);
        make.left.mas_equalTo(self.selectButton.mas_right).mas_offset(47 / 3.f);
        make.width.height.mas_equalTo(272 / 3.f);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImageView);
        make.left.mas_equalTo(self.titleImageView.mas_right).mas_offset(47 / 3.f);
        make.right.mas_equalTo(-66 / 3.f);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(60 / 3.f);
        make.left.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(self.titleLabel);

    }];
    [self.inventoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceLabel.mas_bottom).mas_offset(36 / 3.f);
        make.left.mas_equalTo(self.priceLabel);
         make.right.mas_equalTo(self.titleLabel);
    }];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.inventoryLabel.mas_bottom).mas_offset(67 / 3.f);
        make.right.mas_equalTo(-30 / 3.f);
        make.width.mas_equalTo(224 / 3.f);
        make.height.mas_equalTo(82 / 3.f);
    }];
    [self.shelvesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.deleteButton);
        make.right.mas_equalTo(self.deleteButton.mas_left).mas_offset(-56 / 3.f);
        make.width.mas_equalTo(224 / 3.f);
        make.height.mas_equalTo(82 / 3.f);
    }];
    [self.editorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shelvesButton);
//        make.right.mas_equalTo(self.shelvesButton.mas_left).mas_offset(-56 / 3.f);
        make.width.mas_equalTo(224 / 3.f);
        make.height.mas_equalTo(82 / 3.f);
    }];
    [super updateConstraints];
}
- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _selectButton.backgroundColor = [UIColor grayColor];
        [_selectButton setImage:[UIImage imageNamed:@"commoditymanagement_button_unselect"] forState:UIControlStateNormal];
        [_selectButton addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}
- (UIImageView *)titleImageView {
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc]init];
        _titleImageView.backgroundColor = [UIColor redColor];
    }
    return _titleImageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 2;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:40 / 3.f];
        _titleLabel.textColor = [ManagerEngine getColor:@"333333"];
        _titleLabel.text = @"fhaldfhlhalf了快到家法拉第就发啦捡垃圾的酸辣粉静安寺马开店收费";
    }
    return _titleLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont systemFontOfSize:40 / 3.f];
        _priceLabel.textColor = [ManagerEngine getColor:@"333333"];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.text = @"￥67.00";
    }
    return _priceLabel;
}
- (UILabel *)inventoryLabel {
    if (!_inventoryLabel) {
        _inventoryLabel = [[UILabel alloc]init];
        _inventoryLabel.font = [UIFont systemFontOfSize:36 / 3.f];
        _inventoryLabel.textColor = [ManagerEngine getColor:@"606266"];
        _inventoryLabel.textAlignment = NSTextAlignmentLeft;
        _inventoryLabel.text = @"库存：9999  总销量：5646";
    }
    return _inventoryLabel;
}
- (UIButton *)editorButton {
    if (!_editorButton) {
        _editorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _editorButton.layer.masksToBounds = YES;
        _editorButton.layer.cornerRadius = 41 / 3.f;
        _editorButton.layer.borderColor = [UIColor blackColor].CGColor;
        _editorButton.layer.borderWidth = .5f;
        [_editorButton setTitle:@"编辑" forState:UIControlStateNormal];
        _editorButton.titleLabel.font = [UIFont systemFontOfSize:38 / 3.f];
        [_editorButton setTitleColor:[ManagerEngine getColor:@"333333"] forState:UIControlStateNormal];
        [_editorButton addTarget:self action:@selector(editBtn) forControlEvents:UIControlEventTouchUpInside];

    }
    return _editorButton;
}
- (UIButton *)shelvesButton {
    if (!_shelvesButton) {
        _shelvesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shelvesButton.layer.cornerRadius = 41 / 3.f;
        _shelvesButton.layer.borderColor = [UIColor blackColor].CGColor;
        _shelvesButton.layer.borderWidth = .5f;
        [_shelvesButton setHidden:YES];
        [_shelvesButton setTitle:@"上架" forState:UIControlStateNormal];
        _shelvesButton.titleLabel.font = [UIFont systemFontOfSize:38 / 3.f];
        [_shelvesButton setTitleColor:[ManagerEngine getColor:@"333333"] forState:UIControlStateNormal];
        [_shelvesButton addTarget:self action:@selector(shelvesBtn) forControlEvents:UIControlEventTouchUpInside];

    }
    return _shelvesButton;
}
- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.layer.cornerRadius = 41 / 3.f;
        _deleteButton.layer.borderColor = RedColor.CGColor;
        _deleteButton.layer.borderWidth = .5f;
//        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:38 / 3.f];
        [_deleteButton setTitleColor:RedColor forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}






@end
