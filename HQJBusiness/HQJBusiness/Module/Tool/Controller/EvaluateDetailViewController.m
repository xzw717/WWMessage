//
//  MessageVC.m
//  HQJBusiness
//
//  Created by mymac on 2019/6/24.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "EvaluateDetailViewController.h"



#define LeftSpace 20.f

#define TopSpace 40.f/3

#define LabelTopSpace 40.f/3

#define LabelHeight 20.f

#define ImageSize 242.f/3
@interface EvaluateDetailViewController ()
@property(nonatomic,strong) UIView *maskView;
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *orderLabel;
@property(nonatomic,strong) UILabel *contentLabel;
@property(nonatomic,strong) NSMutableArray *imageArray;
@property(nonatomic,strong) UILabel *timeLabel;
@end

@implementation EvaluateDetailViewController
#pragma mark lazy_load

- (UIView *)maskView{
    if (_maskView == nil) {
        _maskView = [[UIView alloc]init];
        _maskView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_maskView];
    }
    return _maskView;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:17.f];
        _nameLabel.textColor = [ManagerEngine getColor:@"464648"];
        _nameLabel.text = @"陈哈哈";
        [self.maskView addSubview:_nameLabel];
    }
    return _nameLabel;
}
- (UILabel *)orderLabel{
    if (_orderLabel == nil) {
        _orderLabel = [[UILabel alloc]init];
        _orderLabel.font = [UIFont systemFontOfSize:40.f/3];
        _orderLabel.textColor = [ManagerEngine getColor:@"909399"];
        _orderLabel.text = @"2019-7-22 3:35";
        [self.maskView addSubview:_orderLabel];
    }
    return _orderLabel;
}
- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:16.f];
        _contentLabel.textColor = [ManagerEngine getColor:@"464648"];
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = @"这是一条精彩的评价和萨里就会更快拉上公开啦还是废弃物 i 哦好烦 i 完全ahfkaslhklgsahghas恢复 i 完全恢复 i 完全恢复 i 温泉后 if 国庆晚会";
        [self.maskView addSubview:_contentLabel];
    }
    return _contentLabel;
}
- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:40.f/3];
        _timeLabel.textColor = [ManagerEngine getColor:@"909399"];
        _timeLabel.text = @"2019-7-22 3:35";
        [self.maskView addSubview:_timeLabel];
    }
    return _timeLabel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价详情";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self layoutTheSubviews];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navType = HQJNavigationBarWhite;
    self.isHideShadowLine = YES;
}
- (void)layoutTheSubviews{
    float height = [ManagerEngine heightForString:@"这是一条精彩的评价和萨里就会更快拉上公开啦还是废弃物 i 哦好烦 i 完全ahfkaslhklgsahghas恢复 i 完全恢复 i 完全恢复 i 温泉后 if 国庆晚会" fontSize:16.f andWidth:WIDTH - 2 * LeftSpace];
    float totalHeight = LabelTopSpace * 5 + LabelTopSpace * 3 + height + 10 + ImageSize;
    
    self.maskView.frame = CGRectMake(0, TopSpace, WIDTH, totalHeight);
    self.nameLabel.frame = CGRectMake(LeftSpace, LabelTopSpace, WIDTH - 2 * LeftSpace, LabelHeight);
    self.orderLabel.frame = CGRectMake(LeftSpace, LabelTopSpace + 10 + LabelHeight, WIDTH - 2 * LeftSpace, LabelHeight);
    self.contentLabel.frame = CGRectMake(LeftSpace, LabelTopSpace * 2 + 10 + LabelHeight * 2, WIDTH - 2 * LeftSpace, height);
    CGFloat JGGMinX = 20;//起始x值
    CGFloat JGGMinY = LabelTopSpace * 3 + 10 + LabelHeight * 2 + height;//起始y值
    CGFloat SPspace = 10;//水平距离
    
    for (NSInteger i = 0; i < 3; i ++) {
        CGFloat x =  JGGMinX + i % 3 * (ImageSize + SPspace);
        CGFloat y =  JGGMinY + i / 3* ImageSize;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, ImageSize, ImageSize)];
        imageView.image = [UIImage imageNamed:@"tool_icon_recommend"];
        [self.maskView addSubview:imageView];
    }
    self.timeLabel.frame = CGRectMake(LeftSpace, LabelTopSpace * 4 + LabelTopSpace * 2 + height + 10 + ImageSize, WIDTH - 2, LabelHeight);
    
}


@end
