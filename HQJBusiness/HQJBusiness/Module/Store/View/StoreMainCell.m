//
//  StoreMainCell.m
//  HQJBusiness
//
//  Created by mymac on 2019/6/25.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
// 270 H
#import "StoreMainCell.h"

#define  ItemNumberFont  52/3.f
#define  ItemNameFont  38/3.f
#define  ItemNumberTopSpacing  65/3.f
#define  ItemNameTopSpacing  50/3.f
#define  ItemNameBottomSpacing  65/3.f
#define  ItemAddImageSize 20.f
#define  ItemHeight           766 / 3 / 3.f
#define  ItemWidth            (WIDTH - 10 *2 )/ 3.f
@interface ItemView ()
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *namelabel;
@property (nonatomic, strong) UIImageView *addImageView;
@end
@implementation ItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self itemView_addSubView];
        [self itemView_LayoutView];
        self.userInteractionEnabled = YES;
      
    }
    return self;
}


- (void)itemView_LayoutView {
    self.numberLabel.frame = CGRectMake(0, ItemNumberTopSpacing, ItemWidth, ItemNumberFont);
    self.namelabel.frame = CGRectMake(0, ItemHeight - ItemNameBottomSpacing  - ItemNameFont, ItemWidth, ItemNameFont);
    
}

- (void)setStyle:(ItemViewStyle)style {
    _style = style;
    switch (self.style) {
        case ItemViewStyleAddImage: {
            self.numberLabel.hidden = YES;
            self.namelabel.hidden = NO;
            self.addImageView.hidden = NO;

            self.addImageView.center = self.numberLabel.center;
            self.addImageView.bounds = CGRectMake(0, 0, ItemAddImageSize, ItemAddImageSize);
        }
            break;
        case ItemViewStyleOnlyImage: {
            self.numberLabel.hidden = YES;
            self.namelabel.hidden = YES;
            self.addImageView.hidden = NO;
            self.addImageView.center = CGPointMake(ItemWidth / 2, ItemHeight / 2);
            self.addImageView.bounds = CGRectMake(0, 0, ItemAddImageSize, ItemAddImageSize);
        }
            break;
        default:
            self.numberLabel.hidden = NO;
            self.namelabel.hidden = NO;
            self.addImageView.hidden = YES;
            break;
    }
}
- (void)itemView_addSubView {
    [self addSubview:self.numberLabel];
    [self addSubview:self.namelabel];
    [self addSubview:self.addImageView];
}
- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.font = [UIFont systemFontOfSize:ItemNumberFont];
        _numberLabel.textColor = [ManagerEngine getColor:@"333333"];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numberLabel;
}
- (UILabel *)namelabel {
    if (!_namelabel) {
        _namelabel = [[UILabel alloc]init];
        _namelabel.font = [UIFont systemFontOfSize:ItemNameFont];
        _namelabel.textColor = [ManagerEngine getColor:@"606266"];
        _namelabel.textAlignment = NSTextAlignmentCenter;

    }
    return _namelabel;
}
- (UIImageView *)addImageView {
    if (!_addImageView) {
        _addImageView = [[UIImageView alloc]init];
        _addImageView.image = [UIImage imageNamed:@"store_add"];
    }
    return _addImageView;
}
@end


#define CellTiTImageLeft 40/3.f
#define CellTiTImageTop 40/3.f
#define CellTiTLabelLeft 19/3.f
#define CellRightArrowImageRight 40/3.f
#define CellRightArrowImageTop 45/3.f
#define CellRightArrowImageBottom 45/3.f

#define CellTiTImageWidth 28.f
#define CellTiTImageHeight 25.f
#define CellTiTLabelFont 48/3.f

#define CellRightArrowImageWidth 14/2.f
#define CellRightArrowImageHeight 25/2.f
#define CellLineHeight  1/2.f

#define CellWidth  WIDTH - 10 *2



@interface StoreMainCell ()
@property (nonatomic, strong) UIImageView *stotrTitleImageView;
@property (nonatomic, strong) UILabel *stotrTitleLabel;
@property (nonatomic, strong) UIImageView *rightArrowImageView;
@property (nonatomic, strong) UIView *separationView;
@end
@implementation StoreMainCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self storeMainCell_addSubViwe];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)updateConstraints {
    self.stotrTitleImageView.frame = CGRectMake(CellTiTImageLeft, CellTiTImageTop, CellTiTLabelFont, CellTiTLabelFont);
    self.stotrTitleLabel.frame = CGRectMake(CellTiTImageLeft + CellTiTLabelFont + CellTiTLabelLeft , CellTiTImageTop,ItemWidth -  CellTiTImageLeft - CellTiTImageWidth - CellTiTLabelLeft , CellTiTLabelFont);
    self.rightArrowImageView.frame = CGRectMake(CellWidth - CellRightArrowImageRight - CellRightArrowImageWidth , CellRightArrowImageBottom, CellRightArrowImageWidth, CellRightArrowImageHeight);
    self.separationView.frame = CGRectMake(0, CellRightArrowImageBottom + CellRightArrowImageHeight + CellRightArrowImageHeight, CellWidth, CellLineHeight);
    
    [super updateConstraints];
}

#pragma mark --- 设置每一区的名称和图片
- (void)setTitleArray:(NSMutableArray *)titleArray {
    self.stotrTitleImageView.image = [UIImage imageNamed:titleArray.firstObject];
    self.stotrTitleLabel.text = titleArray.lastObject;
}

#pragma mark --- 设置单元格内的每一个小块内容
- (void)setItemAry:(NSMutableArray *)itemAry {
    _itemAry = itemAry;
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[ItemView class]]) {
            [obj removeFromSuperview];
        }
    }];
    int SPNum = 3;//水平一行放几个
    CGFloat JGGMinX = 0;//起始x值
    CGFloat JGGMinY = self.separationView.mj_y + self.separationView.mj_h;//起始y值
    CGFloat SPspace = 0;//水平距离
    CGFloat CXspace = 0;//垂直距离
    
    for (NSInteger i = 0; i < itemAry.count; i ++) {
        ItemView * view = [[ItemView alloc]init];
        view.userInteractionEnabled = YES;
        if ([itemAry[i] isEqualToString:@"+"]) {
            view.style = ItemViewStyleOnlyImage;

        } else if ([itemAry[i] isEqualToString:@"添加商品"]) {
            view.style = ItemViewStyleAddImage;

        } else {
            view.style = ItemViewStyleDefault;

        }
        CGFloat x =  JGGMinX + i % SPNum * (ItemWidth + SPspace);
        CGFloat y =  JGGMinY + i / SPNum * (ItemHeight + CXspace);
        view.frame = CGRectMake(x, y, ItemWidth, ItemHeight);
        view.numberLabel.text = [NSString stringWithFormat:@"1024.33633"];
        view.namelabel.text = itemAry[i];
        view.tag = i + 10000;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickItem:)];
        [view addGestureRecognizer:tap];
        [self.contentView addSubview:view];

    }

}

- (void)clickItem:(UITapGestureRecognizer *)tapgs {
    if (self.clickItemblock) {
        self.clickItemblock(self.itemAry[tapgs.view.tag - 10000]);
        
    }
    
}


#pragma mark --- 行高计算
- (CGFloat)cellHeight:(NSArray *)ary {
    CGFloat y = self.separationView.mj_y + 1;
    CGFloat hy = 0.0;
    if (ary.count % 3 > 0) {
       hy = (ary.count / 3 + 1) * ItemHeight;
        
    } else {
        hy =  ary.count / 3  * ItemHeight;
        
    }
    return  y + hy;
    
}

#pragma mark --- 控件初始化
- (void)storeMainCell_addSubViwe {
    [self.contentView addSubview:self.stotrTitleImageView];
    [self.contentView addSubview:self.stotrTitleLabel];
    [self.contentView addSubview:self.rightArrowImageView];
    [self.contentView addSubview:self.separationView];
}

- (UIImageView *)stotrTitleImageView {
    if (!_stotrTitleImageView) {
        _stotrTitleImageView = [[UIImageView alloc]init];
    }
    return _stotrTitleImageView;
}

- (UILabel *)stotrTitleLabel {
    if (!_stotrTitleLabel) {
        _stotrTitleLabel = [[UILabel alloc]init];
        _stotrTitleLabel.font = [UIFont systemFontOfSize:CellTiTLabelFont];
//        _stotrTitleLabel.text = @"模拟数据";
    }
    return _stotrTitleLabel;
}

- (UIImageView *)rightArrowImageView {
    if (!_rightArrowImageView) {
        _rightArrowImageView = [[UIImageView alloc]init];
        _rightArrowImageView.image = [UIImage imageNamed:@"store_rightArrow"];
    }
    return _rightArrowImageView;
}

- (UIView *)separationView {
    if (!_separationView) {
        _separationView = [[UIView alloc]init];
        _separationView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
    }
    return _separationView;
}

@end
