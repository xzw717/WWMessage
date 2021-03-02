//
//  AddUnionImageCell.m
//  HQJBusiness
//
//  Created by 姚志中 on 2021/2/3.
//  Copyright © 2021 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "AddUnionSelectCell.h"
#import "ZGRelayoutButton.h"
#define LeftMargin 10
@interface AddUnionSelectCell ()
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) NSArray *tempArray;
@end
@implementation AddUnionSelectCell
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _nameLabel;
}
- (void)updateConstraints {
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(LeftMargin);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    [super updateConstraints];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.nameLabel];
        [self updateConstraintsIfNeeded];
    }
    return self;
}
- (void)setDataArray:(NSArray *)dataArray{
    self.tempArray = dataArray;
    if ([dataArray[1] hasPrefix:@"*"]) {
        NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc]initWithString:dataArray[1]];
        [attributed addAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} range:NSMakeRange(0, 1)];
        self.nameLabel.attributedText = attributed;
    }else{
        self.nameLabel.text = dataArray[1];
    }
    NSArray *sepArray = [dataArray[2] componentsSeparatedByString:@","];
    NSArray * tempArray;
    if ([self.model valueForKey:[dataArray lastObject]]) {
        tempArray = [[self.model valueForKey:[dataArray lastObject]] componentsSeparatedByString:@","];
    }
    ZGRelayoutButton *lastView;
    NSInteger itemCount = sepArray.count > 2 ? 2 : sepArray.count;
    float wid = (WIDTH - 120)/itemCount;
    CGSize ItemSize = CGSizeMake(wid, 50);
    for (int i = 0; i < sepArray.count; i ++) {
        
        ZGRelayoutButton *item = [[ZGRelayoutButton alloc]init];
        item.imageSize = CGSizeMake(20,20);
        item.offset = 2;
        item.type = ZGRelayoutButtonTypeNomal;
        item.titleLabel.font = [UIFont systemFontOfSize:15];
        [item setImage:[UIImage imageNamed:@"icon_cart_unsel"] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:@"icon_select"] forState:UIControlStateSelected];
        [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [item setTitle:sepArray[i] forState:UIControlStateNormal];
        [item addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
        if ([tempArray containsObject:sepArray[i]]) {
            [self itemClicked:item];
        }
        item.tag = i;
        [self.contentView addSubview:item];
        
        if (lastView) {
            if (i % itemCount == 0) {
                [item mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(lastView.mas_bottom);
                    make.left.mas_equalTo(120);
                    make.size.mas_equalTo(ItemSize);
                }];
            } else {
                [item mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(lastView.mas_top);
                    make.left.mas_equalTo(lastView.mas_right);
                    make.size.mas_equalTo(ItemSize);
                }];
            }
        } else{
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(120);
                make.size.mas_equalTo(ItemSize);
            }];
        }
        lastView = item;
    }
}
- (void)itemClicked:(ZGRelayoutButton *)button{
    button.selected = !button.selected;
    NSArray *sepArray = [self.tempArray[2] componentsSeparatedByString:@","];
    !self.clickBlock ? : self.clickBlock(sepArray[button.tag]);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
