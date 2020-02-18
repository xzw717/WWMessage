//
//  GoodsReleaseUploadPicturesCell.m
//  HQJBusiness
// 商品发布 上传图片 cell
//  Created by mymac on 2019/7/12.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "GoodsReleaseUploadPicturesCell.h"

@interface CustomImageView : UIImageView
@property (nonatomic, strong) UIImageView *closeImageView;
@end
@interface CustomImageView ()

@end

@implementation CustomImageView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.closeImageView];
    }
    return self;
}
- (void)setCustomImage:(NSString *)image {
    [self setImage:[UIImage imageNamed:image]];
}

- (UIImageView *)closeImageView {
    if (!_closeImageView) {
        _closeImageView = [[UIImageView alloc]init];
        _closeImageView.image = [UIImage imageNamed:@"goodsRelease_delete"];
    }
    return _closeImageView;
}
@end



@implementation GoodsReleaseUploadPicturesCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.cellContentView];
        [self.cellContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return self;
}
- (UploadImageContentView *)cellContentView {
    if (!_cellContentView) {
        _cellContentView = [[UploadImageContentView alloc]init];
        
    }
    return _cellContentView;
}
@end
