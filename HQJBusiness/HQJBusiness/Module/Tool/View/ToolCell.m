//
//  ToolCell.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/1.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ToolCell.h"

#define  ItemSplitWidth  .5f
#define  ItemNameFont  38/3.f
#define  ItemImageViewTopSpacing  70/3.f
#define  ItemNameTopSpacing  46/3.f
#define  ItemNameBottomSpacing  70/3.f
#define  ItemImageSize 76/3.f
#define  ItemHeight           WIDTH/4.f
#define  ItemWidth            WIDTH/4.f

@interface ToolItemView ()
@property (nonatomic, strong) UIView *splitView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *imageView;
@end
@implementation ToolItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self toolItemView_addSubView];
        [self toolItemView_LayoutView];
        self.userInteractionEnabled = YES;
        
    }
    return self;
}
- (void)toolItemView_LayoutView {
    self.splitView.sd_layout.topEqualToView(self).rightEqualToView(self).bottomEqualToView(self).widthIs(ItemSplitWidth);
    self.imageView.sd_layout.topSpaceToView(self,ItemImageViewTopSpacing).centerXEqualToView(self).heightIs(ItemImageSize).widthIs(ItemImageSize);
    self.nameLabel.sd_layout.topSpaceToView(self.imageView,ItemNameTopSpacing).bottomSpaceToView(self, ItemNameBottomSpacing).centerXEqualToView(self).widthIs(self.width - 20);
    
}



- (void)toolItemView_addSubView {
    [self addSubview:self.splitView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.imageView];
}
- (UIView *)splitView{
    if (!_splitView) {
        _splitView = [[UIView alloc]init];
        _splitView.backgroundColor = [ManagerEngine getColor:@"e7e5e5"];
        
    }
    return _splitView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:ItemNameFont];
        _nameLabel.textColor = [ManagerEngine getColor:@"606266"];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _nameLabel;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}
@end





@interface ToolCell ()
@property (nonatomic, strong) ToolItemView *ToolItemView;
@end

@implementation ToolCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self updateConstraintsIfNeeded];
    }
    return self;
}


- (void)setItemAry:(NSMutableArray *)itemAry{
    _itemAry = itemAry;
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[ToolItemView class]]) {
            [obj removeFromSuperview];
        }
    }];
    NSLog(@"itemAry  = %@",itemAry);
    for (NSInteger i = 0; i < itemAry.count; i ++) {
        ToolItemView * view = [[ToolItemView alloc]initWithFrame:CGRectMake(i *ItemWidth, 0, ItemWidth, ItemWidth)];
        NSArray *data = itemAry[i];
        view.nameLabel.text = data[0];
        view.imageView.image = [UIImage imageNamed:data[1]];
        view.tag = i + 1000;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickItem:)];
        [view addGestureRecognizer:tap];
        [self.contentView addSubview:view];
    }

}
- (void)clickItem:(UITapGestureRecognizer *)tapgs {
    if (self.clickItemblock) {
        self.clickItemblock(self.itemAry[tapgs.view.tag - 1000][0]);
    }
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
