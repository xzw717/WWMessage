//
//  PerfectView.m
//  WuWuMap
//
//  Created by 姚 on 2019/9/23.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//
#define  ItemImageSize        WIDTH/4
#define  MaskHeight        150
#import "HQJShareView.h"
#import "UIView+RoundedCorners.h"
#import "ZGRelayoutButton.h"
@interface HQJShareView ()
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UIButton *cancelButton
;
@end

@implementation HQJShareView

- (instancetype)initWithTitleArray:(NSArray *)titleArray{
    self = [super initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    if (self) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.f];
//        UIImage *image = T_ImageNamed(@"icon_register_poster");
//        self.layer.contents = (id)image.CGImage;
        self.titleArray = titleArray;
        [self addTheSubViews];
    }
    return self;
}
+ (instancetype)showShareViewWithArray:(NSArray *)titleArray  {
    HQJShareView * view = [[self alloc]initWithTitleArray:titleArray];
    return view;
}
- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc]init];
        _maskView.backgroundColor = [UIColor whiteColor];
        [_maskView hqj_roundedCornersWithRoundedRect:CGRectMake(0, 0, WIDTH, MaskHeight) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:10.f];
        
    }
    return _maskView;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc]init];
        _cancelButton.backgroundColor = [UIColor whiteColor];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_cancelButton bk_addEventHandler:^(id sender) {
            if (self.cancel) {
                self.cancel();
            } else {
                [self removeFromSuperview];

            }
        } forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _cancelButton;
}

- (void)addTheSubViews{
    [self addSubview:self.maskView];
    [self addSubview:self.cancelButton];
    [self layoutTheSubviews];
    
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self removeFromSuperview];
//}
- (void)layoutTheSubviews{
    [self.maskView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[ZGRelayoutButton class]]) {
            [obj removeFromSuperview];
        }
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.mas_equalTo(60.f);
    }];
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.mas_equalTo(self.cancelButton.mas_top);
        make.height.mas_equalTo(MaskHeight);
    }];
    
    int SPNum =  4 ;//水平一行放几个
    CGFloat JGGMinX = S_RatioW(0);//起始x值
    CGFloat JGGMinY = S_RatioH(30);//起始y值
    CGFloat SPspace = S_RatioW(0);//水平距离
    CGFloat CXspace = S_RatioH(0);//垂直距离
    
    for (NSInteger i = 0; i <self.titleArray.count ; i ++) {
        CGFloat x =  JGGMinX + i % SPNum * (ItemImageSize + SPspace);
        CGFloat y =  JGGMinY + i / SPNum * (ItemImageSize + CXspace);
        NSArray *dataArray = self.titleArray[i];
        ZGRelayoutButton *button = [[ZGRelayoutButton alloc]initWithFrame:CGRectMake(x, y, ItemImageSize,ItemImageSize)];
        button.imageSize = CGSizeMake(NewProportion(168), NewProportion(168));
        button.offset = 10;
        button.type = ZGRelayoutButtonTypeBottom;
        button.tag = i + 1000;
        [button addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[ManagerEngine getColor:@"666666"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitle:dataArray[0] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:dataArray[1]] forState:UIControlStateNormal];
        [self.maskView addSubview:button];
        
    }
    
}
- (void)clickItem:(UIButton *)sender {
    if (self.clickItemblock) {
        self.clickItemblock(self.titleArray[sender.tag - 1000][0]);
    }
}

@end
