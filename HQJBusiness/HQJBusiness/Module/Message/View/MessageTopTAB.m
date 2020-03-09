//
//  MessageTopTAB.m
//  HQJBusiness
//
//  Created by mymac on 2019/6/28.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//






#import "MessageTopTAB.h"
#import "NewMessageImageView.h"



#define backgroundCornerRadius (28 / 3.f)
#define numberCornerRadius (26 / 3.f)
#define numberFont (36 / 3.f)

#define redViewHeight (52 / 3.f)
#define redSuperViewHeight (56 / 3.f)

#define redViewTopEdge (2.5f)
#define redViewleftEdge (6.f)

#define topLabelFont (40 / 3.f)
#define topImageHeight (49.f)
#define topImageLabelSpacing (26 / 3.f)

//#define numberCornerRadius (26 / 3.f)
//#define numberCornerRadius (26 / 3.f)


//typedef NS_ENUM (NSInteger , redViewStyle){
//    redViewStyleDefault ,
//    redViewStyleNumber
//};
@interface MessageHintView : UIImageView

@end
@interface MessageHintView ()
//@property (nonatomic, strong) UIView *hintViewBackground; /// 数字红点白色背景
@property (nonatomic, strong) UILabel *numberLabel; /// 红色数字小红点
@property (nonatomic, assign) redViewStyle style; /// 红色数字小红点

@end
@implementation MessageHintView

- (instancetype)initWithHintStyle:(redViewStyle)style
{
    self = [super init];
    if (self) {
        self.style = style;
        [self addSubview:self.numberLabel];
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.left.mas_equalTo(self.mas_right).mas_offset(-backgroundCornerRadius);
            make.height.mas_equalTo(backgroundCornerRadius);
            make.width.mas_equalTo(numberFont);

        }];
        
    }
    return self;
}

#pragma mark --- 设置消息数量
-  (void)setNumbaer:(NSInteger)count {
    static NSString *counts;
    if (count > 99) {
        counts = @"99+";
    }else if (count >0) {
        counts = [NSString stringWithFormat:@"%ld",count];
    } else {
        
    }
    self.numberLabel.text = counts;
    [self messageHintView_needUpdateLayout];
}
- (void)hiddeRedView {
    self.numberLabel.hidden = YES;
}
- (void)aa {
    
}
- (void)setStyle:(redViewStyle)style {
    _style = style;
    if (style == redViewStyleDefault) {
        [self.numberLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(28 / 3);
            make.height.mas_equalTo(28 / 3);
            make.left.mas_equalTo(self.mas_right).mas_offset(- (28 / 3));
            
        }];

    } else {
        
    }
}
#pragma mark --- 更新约束
- (void)messageHintView_needUpdateLayout {
    NSInteger textCount = self.numberLabel.text.length;
    CGFloat numbaerWidth = 0.0f;
    CGFloat proportion = 0.0f;
    if (textCount > 1) {
     numbaerWidth = 8 * textCount;
        if (textCount > 2) {
            proportion = 1 / 2.f;
        } else {
            proportion = 2 / 3.f;

        }
    } else {
        proportion = 3 / 4.f;
     numbaerWidth = numberFont * textCount;
    }
    [self.numberLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(numbaerWidth + 13 / 3 * 2);
            make.height.mas_equalTo(numberFont + 13 / 3 * 2);
            make.left.mas_equalTo(self.mas_right).mas_offset(- (numbaerWidth + 13 / 3 * 2) * proportion);

    }];
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.text = @" ";
        _numberLabel.hidden = YES;
        _numberLabel.backgroundColor = [ManagerEngine getColor:@"ff494b"];;
        _numberLabel.layer.cornerRadius = backgroundCornerRadius;
        _numberLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        _numberLabel.layer.borderWidth = 1.f;
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.font = [UIFont systemFontOfSize:numberFont];
        
    }
    return _numberLabel;
}

@end


#pragma mark --- 自定义按钮
@interface MessageTopBtn : UIView


- (void)_selectTopBtn:(NSString *)btn_image;
- (void)_UnSelectTopBtn:(NSString *)btn_image;
@end
@interface MessageTopBtn ()
@property (nonatomic, strong) NewMessageImageView *top_img;
@property (nonatomic, strong) UILabel *top_lable;

//@property (nonatomic, strong) MessageHintView *messagRedView;

@end
@implementation MessageTopBtn

- (instancetype)init
{
    self = [super init];
    if (self) {
  
        [self messageTopBtn_addSubgView];
        [self messageTopBtn_SetViewLayout];
       
        [self.top_img setNumbaer:0];
    }
    return self;
}
- (void)messageTopBtn_addSubgView {
    [self addSubview:self.top_img];
    [self addSubview:self.top_lable];

}
- (void)_selectTopBtn:(NSString *)btn_image {
    self.top_img.image = [UIImage imageNamed:btn_image];
    self.top_lable.textColor = DefaultAPPColor;
}
- (void)_UnSelectTopBtn:(NSString *)btn_image {
    self.top_img.image = [UIImage imageNamed:btn_image];
    self.top_lable.textColor = [ManagerEngine getColor:@"939191"];

}
- (void)messageTopBtn_SetViewLayout {
    [self.top_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(5);
        make.size.mas_equalTo(CGSizeMake(topImageHeight, topImageHeight));

    }];
    [self.top_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.top_img.mas_bottom).mas_offset(13);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(topLabelFont);
        
    }];

}
- (NewMessageImageView *)top_img {
    if (!_top_img) {
        _top_img = [[NewMessageImageView alloc]initWithHintStyle:redViewStyleNumber];
        _top_img.image = [UIImage imageNamed:@"news-Important-on"];
    }
    return _top_img;
}
- (UILabel *)top_lable {
    if (!_top_lable) {
        _top_lable = [[UILabel alloc]init];
        _top_lable.font = [UIFont systemFontOfSize:topLabelFont];
        _top_lable.textAlignment = NSTextAlignmentCenter;
        _top_lable.textColor = [ManagerEngine getColor:@"939191"];
        _top_lable.text = @"订单通知";
    }
    return _top_lable;
}
//- (MessageHintView *)messagRedView {
//    if (!_messagRedView) {
//        _messagRedView = [[MessageHintView alloc]init];
//    }
//    return _messagRedView;
//}

@end

@interface MessageTopTAB ()
@property (nonatomic, strong) UIView *maskBackView;
//@property (nonatomic, strong) MessageTopBtn *messagRedView;

@end
@implementation MessageTopTAB

- (instancetype)init
{
    self = [super init];
    if (self) {
        for (NSInteger i = 0; i < [self titleName].count; i ++) {
            MessageTopBtn *messagRedView = [[MessageTopBtn alloc]init];
            messagRedView.userInteractionEnabled = YES;
            messagRedView.tag = i + 100;
            CGFloat tspacing = topImageHeight + 5 + 5 + topLabelFont + 5;
            CGFloat twidth = (WIDTH - 20 - tspacing * [self titleName].count ) / [self titleName].count +1;
            CGFloat xg = i % [self titleName].count;
            CGFloat tx = twidth + (twidth + tspacing) * xg;
            messagRedView.frame = CGRectMake(tx , (100 - tspacing) / 2, tspacing,tspacing);
            messagRedView.top_img.image = [UIImage imageNamed:i == 0 ? [self selectImageName][i] :[self unselectImageName][i]];
            messagRedView.top_lable.textColor = i == 0 ? DefaultAPPColor : [ManagerEngine getColor:@"939191"];
            messagRedView.top_lable.text = [self titleName][i];
            [self addSubview:messagRedView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(messageBtn:)];
            [messagRedView addGestureRecognizer:tap];
        }
    }
    return self;
}

#pragma mark --- 点击方法
- (void)messageBtn:(UITapGestureRecognizer *)tap {
    MessageTopBtn *messagRedView =  [self viewWithTag:tap.view.tag];
    MessageTopBtn *firstMessagRedView ;
//    MessageTopBtn *lastMessagRedView ;
    NSInteger tags = tap.view.tag - 100;
    !self.topViewSelectBlock ? : self.topViewSelectBlock(tags);
    if (tags == 0) {
        firstMessagRedView   =  [self viewWithTag:101];
//        lastMessagRedView   =  [self viewWithTag:102];
    }
    if (tags == 1) {
        firstMessagRedView   =  [self viewWithTag:100];
//        lastMessagRedView   =  [self viewWithTag:102];
    }
//    if (tags == 2) {
//        firstMessagRedView   =  [self viewWithTag:100];
//        lastMessagRedView   =  [self viewWithTag:101];
//    }
    [messagRedView _selectTopBtn:[self selectImageName][messagRedView.tag - 100]];
    [firstMessagRedView _UnSelectTopBtn:[self unselectImageName][firstMessagRedView.tag - 100]];
//    [lastMessagRedView _U nSelectTopBtn:[self unselectImageName][lastMessagRedView.tag - 100]];
   
}


#pragma mark --- 通知项目及数量
- (void)addMessageNotice:(NSInteger)tag
            messageCount:(NSInteger)count {
    MessageTopBtn *messagRedView =  [self viewWithTag:tag + 100];
    [messagRedView.top_img setNumbaer:count];
}

- (NSArray *)titleName {
    return @[@"重要通知",@"其他通知"];
}
- (NSArray *)selectImageName {
    return @[@"news-Important-on",@"news-Other-on"];
}
- (NSArray *)unselectImageName {
    return @[@"news-Important",@"news-Other"];
}
@end
