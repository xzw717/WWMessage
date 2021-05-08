//
//  ZWActionSheetView.m
//  WuWuMap
//
//  Created by mymac on 2018/2/26.
//  Copyright © 2018年 Fujian first time iot technology investment co., LTD. All rights reserved.
//
@interface ZWActionSheetCell : UITableViewCell

@end
@interface ZWActionSheetCell ()
/// 选项内容
@property (nonatomic, strong) UILabel *zWTitleLabel;
@end
@implementation ZWActionSheetCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.preservesSuperviewLayoutMargins = NO;
        self.separatorInset = UIEdgeInsetsZero;
        self.layoutMargins = UIEdgeInsetsZero;
        [self.contentView addSubview:self.zWTitleLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.zWTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
    }
    return self;
}

- (UILabel *)zWTitleLabel {
    if (!_zWTitleLabel) {
        _zWTitleLabel = [[UILabel alloc]init];
        _zWTitleLabel.textColor = [UIColor blackColor];
        _zWTitleLabel.font = [UIFont systemFontOfSize:S_RatioW(15.f)];
    }
    return _zWTitleLabel;
}

@end




#import "ZWActionSheetView.h"
@interface ZWActionSheetView ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_titleArray;
    CGFloat _tableViewHeight;
    NSString * _actionTitle;
    CGFloat _tebleViewY; /// 表格的y
    CGFloat  _titleHeight; /// 标题的高
    NSString * _destructiveTitle; /// 破坏性的文字
}
/// 取消按钮
@property (nonatomic, strong) UIButton *cancleButton;

/// 选项表格
@property (nonatomic, strong) UITableView *actionSheetTableView;

/// 标题内容
@property (nonatomic, strong) UILabel *titleLabel;

/// 单元格高度
#define CellHeight   S_RatioW(50.f)
@end

/// 动画时间
static NSTimeInterval const kAnimateTime = 0.25f;

/// 取消按钮与表的间距
static CGFloat const kSpacing     = 10.f;



/// 背景的透明度
static CGFloat const kAlpha  = 0.7f;


@implementation ZWActionSheetView
- (instancetype)initWithActionTitle:(NSString *)title action:(NSArray<NSString *> *)titleArray {
    self = [super initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    if (self) {
        _actionTitle = title;
        _titleArray = titleArray;
       CGFloat actionTitleHeight = [title boundingRectWithSize:CGSizeMake(WIDTH - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15.f]} context:nil].size.height;
        _titleHeight = actionTitleHeight > CellHeight ? actionTitleHeight : CellHeight;
        _tableViewHeight = _titleArray.count > 4 ? 4 * CellHeight : _titleArray.count * CellHeight;
        _tebleViewY = _actionTitle && ![_actionTitle isEqualToString:@""] ? HEIGHT + _titleHeight + 0.5 : HEIGHT;
        self.actionSheetTableView.scrollEnabled = _titleArray.count > 4 ? YES : NO;
        self.titleLabel.hidden = _actionTitle && ![_actionTitle isEqualToString:@""] ? NO : YES;
        
        
        [self addSubview:self.cancleButton];
        [self addSubview:self.actionSheetTableView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

#pragma mark --- 点击消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event  {
    [self hiddenActionSheet];
}


#pragma mark --- 显示
- (void)showActionSheet {
//    UIWindow *window = [self lastWindow];
    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
//    window.windowLevel = UIWindowLevelStatusBar;
    [window addSubview:self];
    self.titleLabel.text = _actionTitle;
    [UIView animateWithDuration:kAnimateTime animations:^{
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:kAlpha];
        self.actionSheetTableView.frame = CGRectMake(0, HEIGHT - CellHeight - kSpacing - _tableViewHeight, WIDTH, _tableViewHeight);
        self.cancleButton.frame = CGRectMake(0, HEIGHT - CellHeight, WIDTH, CellHeight);
        self.titleLabel.frame = CGRectMake(0, HEIGHT  - CellHeight - kSpacing  - _tableViewHeight - 0.5 - _titleHeight, WIDTH, _titleHeight);
    }];
}


#pragma mark --- 消失
- (void)hiddenActionSheet {
    [UIView animateWithDuration:kAnimateTime animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.actionSheetTableView.frame = CGRectMake(0, _tebleViewY, WIDTH,_tableViewHeight);
        self.cancleButton.frame = CGRectMake(0, _tebleViewY + kSpacing + _tableViewHeight, WIDTH, CellHeight);
        self.titleLabel.frame = CGRectMake(0, HEIGHT, WIDTH, _titleHeight);

    } completion:^(BOOL finished) {
        for (UIView *childView in self.subviews) {
            [childView removeFromSuperview];
        }
        [self removeFromSuperview];
//        UIWindow *window = [self lastWindow];
//        window.windowLevel = UIWindowLevelNormal;
    }];
}

- (UIWindow *)lastWindow {
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            
            return window;
    }
    
    return [UIApplication sharedApplication].keyWindow;
}

#pragma mark --- 具有破坏性的按钮
-(void)ActionStyleDestructive:(NSString *)destructiveTitle {
    if ([destructiveTitle isEqualToString:@"取消"]) {
        [self.cancleButton setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
    } else {
        _destructiveTitle = destructiveTitle;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZWActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWActionSheetCell class])];
    cell.zWTitleLabel.text = _titleArray[indexPath.row];

    if ([_titleArray[indexPath.row] isEqualToString:_destructiveTitle]) {
        cell.zWTitleLabel.textColor = [UIColor redColor];

    } else {
        cell.zWTitleLabel.textColor = [UIColor blackColor];

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_titleArray[indexPath.row] containsString:@"年"]) {
        NSArray *ary = [_titleArray[indexPath.row] componentsSeparatedByString:@"年"];
        !self.optionBlock ? : self.optionBlock(ary[0],indexPath.row);
    } else {
        !self.optionBlock ? : self.optionBlock(_titleArray[indexPath.row],indexPath.row);

    }

    [self hiddenActionSheet];
}


- (UIButton *)cancleButton {
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.frame = CGRectMake(0, _tebleViewY + kSpacing + _tableViewHeight, WIDTH, CellHeight);
        _cancleButton.backgroundColor = [UIColor whiteColor];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:S_RatioW(15.f)];
        [_cancleButton addTarget:self action:@selector(hiddenActionSheet) forControlEvents:UIControlEventTouchUpInside];
        [_cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _cancleButton;
}

- (UITableView *)actionSheetTableView {
    if (!_actionSheetTableView) {
        _actionSheetTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, _tebleViewY, WIDTH,_tableViewHeight) style:UITableViewStylePlain];
        _actionSheetTableView.delegate = self;
        _actionSheetTableView.dataSource = self;
        _actionSheetTableView.rowHeight = CellHeight;
        _actionSheetTableView.tableFooterView = [UIView new];
        [_actionSheetTableView registerClass:[ZWActionSheetCell class] forCellReuseIdentifier:NSStringFromClass([ZWActionSheetCell class])];
    }
    return _actionSheetTableView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT, WIDTH, _titleHeight)];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:15.f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
