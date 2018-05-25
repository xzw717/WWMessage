//
//  MessageNotificationCell.m
//  HQJBusiness
//
//  Created by mymac on 2017/4/17.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageNotificationCell.h"
@interface MessageNotificationCell ()
@property (nonatomic, strong) UILabel     *timerLabel;
@property (nonatomic, strong) UIView      *backGroundView;
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel     *titlelabel;
@property (nonatomic, strong) UILabel     *contentLabel;




@end
@implementation MessageNotificationCell

- (UILabel *)timerLabel {
    if (_timerLabel == nil) {
        _timerLabel = [[UILabel alloc]init];
        _timerLabel.backgroundColor = [ManagerEngine getColor:@"bbbaba"];
        _timerLabel.textColor = [UIColor whiteColor];
        _timerLabel.layer.masksToBounds = YES;
        _timerLabel.layer.cornerRadius = 2;
        _timerLabel.font = [UIFont systemFontOfSize:12];
        _timerLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timerLabel;
}

- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc]init];
        _backGroundView.backgroundColor = [UIColor whiteColor];
    }
    return _backGroundView;
}


-(UIImageView *)titleImageView {
    if (_titleImageView == nil) {
        _titleImageView = [[UIImageView alloc]init];
        _titleImageView.image = [UIImage imageNamed:@"icon_notice"];
    }
    return _titleImageView;
}

- (UILabel *)titlelabel {
    if (_titlelabel == nil) {
        _titlelabel = [[UILabel alloc]init];
    }
    return _titlelabel;
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        [self.contentView sd_addSubviews:@[self.timerLabel,self.backGroundView]];
        [self.backGroundView sd_addSubviews:@[self.titleImageView,self.titlelabel,self.contentLabel]];
        [self.titlelabel setSingleLineAutoResizeWithMaxWidth:self.backGroundView.mj_w - 30 - 17 - 15];
        [self upLayout];
        [self setupAutoHeightWithBottomView:self.backGroundView bottomMargin:0];

    }
    return self;
}

- (void)upLayout {

    self.timerLabel.sd_layout.topSpaceToView(self.contentView,19).heightIs(24).centerXEqualToView(self.contentView);
    
    self.backGroundView.sd_layout.leftSpaceToView(self.contentView,15).topSpaceToView(self.timerLabel,15).widthIs(WIDTH - 30).autoHeightRatio(0);
    self.titleImageView.sd_layout.leftSpaceToView(self.backGroundView,15).topSpaceToView(self.backGroundView,21).widthIs(17).heightIs(17);
    
    self.titlelabel.sd_layout.leftSpaceToView(self.titleImageView,15).topEqualToView(self.titleImageView).heightIs(17);
    
    self.contentLabel.sd_layout.leftEqualToView(self.titleImageView).topSpaceToView(self.titlelabel,14).rightSpaceToView(self.backGroundView,15).autoHeightRatio(0);
    
    [self.backGroundView setupAutoHeightWithBottomView:self.contentLabel bottomMargin:30];



}

- (void)setMessageModel:(MessageNotificationModel *)messageModel {
    _messageModel = messageModel;
    self.titlelabel.text = messageModel.title;
    self.contentLabel.text = messageModel.content;
    self.timerLabel.text = [ManagerEngine reverseSwitchTimer:messageModel.time];
    self.timerLabel.sd_layout.widthIs([ManagerEngine setTextWidthStr:self.timerLabel.text andFont:[UIFont systemFontOfSize:12.5]] + 10);
}
@end
