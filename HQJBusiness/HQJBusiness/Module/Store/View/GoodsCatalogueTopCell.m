//
//  GoodsCatalogueTopCell.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/16.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "GoodsCatalogueTopCell.h"
#define LeftRightSpacing (72 / 3)
#define TopBottomSpacing (60 / 3)

#define MainViewWidth WIDTH - LeftRightSpacing * 2
#define LabelOutsideLeftRightSpacing (34 / 3)
#define LabelInsideideTopBottomSpacing (26 / 3)
#define LabelOutsideTopBottomSpacing (50 / 3)

#define LabelFont (40 / 3)

@interface GoodsCatalogueTopCell ()
@property (nonatomic, strong) UILabel *titleLab;
@end
@implementation GoodsCatalogueTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLab];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(44/ 3.f);
            make.left.mas_equalTo(LeftRightSpacing);
        }];
    }
    return self;
}
- (void)itemArray:(NSArray *)ary {
    UILabel *btn1 ;
    for (NSInteger i = 0 ; i< ary.count ; i++) {
        UILabel *label = [self.contentView viewWithTag:i + 1000];
        [label removeFromSuperview];
        UILabel *itemLabel = [[UILabel alloc]init];
        
        itemLabel.text = ary[i];
        itemLabel.textAlignment = NSTextAlignmentCenter;
        itemLabel.layer.masksToBounds = YES;
        itemLabel.tag = i + 1001;
        itemLabel.layer.cornerRadius = 45 / 3.f;
        itemLabel.backgroundColor = [ManagerEngine getColor:@"ececee"];        
        CGFloat btnWidth =   [ManagerEngine setTextWidthStr:ary[i] andFont:[UIFont systemFontOfSize:LabelFont]] +LabelOutsideTopBottomSpacing * 2 ;
        if (btnWidth > WIDTH - LeftRightSpacing* 2) {
            btnWidth = WIDTH - LeftRightSpacing * 2;
        }
        CGFloat btnHeight = 16 + LabelInsideideTopBottomSpacing * 2;
        
        
        itemLabel.mj_w = btnWidth;
        itemLabel.mj_h = btnHeight;
        if (!btn1) {
            itemLabel.mj_x = LabelOutsideLeftRightSpacing;
            itemLabel.mj_y = (44 + 60 + 40) / 3.f ;
        } else {
            if (itemLabel.mj_x + btn1.mj_w <= MainViewWidth &&
                btnWidth <= MainViewWidth - btn1.mj_x - btn1.mj_w) { /// 同一行放得下
                
                itemLabel.mj_x = btn1.mj_x + btn1.mj_w + LabelOutsideLeftRightSpacing;
                itemLabel.mj_y = btn1.mj_y;
            } else {   /// 同一行放不下就换行
                itemLabel.mj_x = LabelOutsideLeftRightSpacing;
                itemLabel.mj_y = btn1.mj_y + btn1.mj_h + LabelOutsideTopBottomSpacing;
                
            }
        }
       
        btn1 = itemLabel;
        self.cellHeight = self.cellHeight + itemLabel.bottom + LabelOutsideTopBottomSpacing;
        [self.contentView addSubview:itemLabel];
    }


}

- (CGFloat)textWithObject:(NSString *)object {
    CGFloat width1=[object boundingRectWithSize:CGSizeMake(1000, LabelFont) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:LabelFont]} context:nil].size.width;
    return width1;
}

- (UILabel *)titleLab {
    if (_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"已添加的商品目录";
        _titleLab.textColor = [ManagerEngine getColor:@"909399"];
        _titleLab.font = [UIFont systemFontOfSize:LabelFont];
    }
    return _titleLab;
}
@end
