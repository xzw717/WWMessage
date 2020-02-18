//
//  GoodsCatalogueTopView.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/16.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "GoodsCatalogueTopView.h"
#import "GoodsCatalogueModel.h"

#define LeftRightSpacing (72 / 3)
#define TopBottomSpacing (60 / 3)

#define MainViewWidth WIDTH - LeftRightSpacing * 2
#define BtnOutsideLeftRightSpacing (34 / 3)
#define BtnInsideideTopBottomSpacing (26 / 3)
#define BtnOutsideTopBottomSpacing (50 / 3)

#define LabelFont (40 / 3)


@interface GoodsCatalogueTopView (){
    UIButton *shadowBtn;

}
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation GoodsCatalogueTopView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        NSArray *ary = @[@"热菜",@"小龙虾系列",@"特色菜",@"冷菜",@"粉面系列",@"早餐系列",@"神奇的无敌的厚爱啊什么的阿克苏的垃圾的垃圾的垃"];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(72 / 3.f);
            make.top.mas_equalTo(44 /3.f);
        }];
    }
    return self;
}

- (void)itemArray:(NSArray <GoodsCatalogueModel*>*)ary {
    for (NSInteger i = 0 ; i< ary.count ; i++) {
        GoodsCatalogueModel *model = ary[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:model.btnTit forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        btn.tag = i + 1001;
        btn.layer.cornerRadius = 45 / 3.f;
        btn.titleLabel.font = [UIFont systemFontOfSize:LabelFont];
        if (model.isSelect == YES) {
            btn.selected = YES;
            btn.backgroundColor = [ManagerEngine getColor:@"deeffc"];
            [btn setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
        } else {
            btn.backgroundColor = [ManagerEngine getColor:@"ececee"];
            [btn setTitleColor:[ManagerEngine getColor:@"626262"] forState:UIControlStateNormal];
        }
       
        [btn addTarget:self action:@selector(cliclItem:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat btnWidth = [self textWithObje:model.btnTit] +BtnOutsideTopBottomSpacing * 2 ;
//        CGFloat btnWidth = [self textWithObje:ary[i]]  ;

        if (btnWidth > WIDTH - LeftRightSpacing* 2) {
            btnWidth = WIDTH - LeftRightSpacing * 2;
        }
        CGFloat btnHeight = 16 + BtnInsideideTopBottomSpacing * 2;
        
        btn.mj_w = btnWidth;
        btn.mj_h = btnHeight;
        if (!shadowBtn) {
            btn.mj_x = LeftRightSpacing;
            btn.mj_y = (44 + 60 + 40) / 3.f ;
        } else {
            if (shadowBtn.mj_x + shadowBtn.mj_w <= MainViewWidth &&
                btnWidth <= MainViewWidth - shadowBtn.mj_x - shadowBtn.mj_w) { /// 同一行放得下
                
                btn.mj_x = shadowBtn.mj_x + shadowBtn.mj_w + BtnOutsideLeftRightSpacing;
                btn.mj_y = shadowBtn.mj_y;
            } else {   /// 同一行放不下就换行
                btn.mj_x = LeftRightSpacing;
                btn.mj_y = shadowBtn.mj_y + shadowBtn.mj_h + BtnOutsideTopBottomSpacing;
                
            }
        }
        
        shadowBtn = btn;
        [self addSubview:btn];
    }
}
- (void)addItem:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:LabelFont];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 45 / 3.f;
    btn.backgroundColor = [ManagerEngine getColor:@"ececee"];
    [btn setTitleColor:[ManagerEngine getColor:@"626262"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cliclItem:) forControlEvents:UIControlEventTouchUpInside];

    
    CGFloat btnWidth = [self textWithObje:title] +BtnOutsideTopBottomSpacing * 2 ;
    if (btnWidth > WIDTH - LeftRightSpacing* 2) {
        btnWidth = WIDTH - LeftRightSpacing * 2;
    }
    CGFloat btnHeight = 16 + BtnInsideideTopBottomSpacing * 2;
    
    btn.mj_w = btnWidth;
    btn.mj_h = btnHeight;
    
    if (shadowBtn.mj_x + shadowBtn.mj_w <= MainViewWidth &&
        btnWidth <= MainViewWidth - shadowBtn.mj_x - shadowBtn.mj_w) { /// 同一行放得下
        
        btn.mj_x = shadowBtn.mj_x + shadowBtn.mj_w + BtnOutsideLeftRightSpacing;
        btn.mj_y = shadowBtn.mj_y;
    } else {   /// 同一行放不下就换行
        btn.mj_x = LeftRightSpacing;
        btn.mj_y = shadowBtn.mj_y + shadowBtn.mj_h + BtnOutsideTopBottomSpacing;
        
    }
    shadowBtn = btn;
    [self addSubview:btn];

}
- (void)cliclItem:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (self.topViewdelegate && [self.topViewdelegate respondsToSelector:@selector(topViewWithItemTitle:)]) {
        [self.topViewdelegate topViewWithItemTitle:btn.currentTitle];
    }
    !self.itemtitleBolck ? : self.itemtitleBolck(btn.currentTitle);
    if (btn.selected == YES) {
        btn.backgroundColor = [ManagerEngine getColor:@"deeffc"];
        [btn setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
    } else {
        btn.backgroundColor = [ManagerEngine getColor:@"ececee"];
        [btn setTitleColor:[ManagerEngine getColor:@"626262"] forState:UIControlStateNormal];
    }
}

- (CGFloat)textWithObje:(NSString *)obje {
    CGFloat width1=[obje boundingRectWithSize:CGSizeMake(1000, LabelFont) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:LabelFont]} context:nil].size.width;
    return width1;
}



- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"已添加的商品目录";
        _titleLabel.textColor = [ManagerEngine getColor:@"909399"];
        _titleLabel.font = [UIFont systemFontOfSize:LabelFont];
    }
    return _titleLabel;
}


@end
