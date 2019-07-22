//
//  MessageDetailsView.m
//  HQJBusiness
//
//  Created by mymac on 2019/7/22.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MessageDetailsView.h"
@interface MessageDetailsView ()
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timerLabel;

@end
@implementation MessageDetailsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self messageDetailsView_addSubView];
        [self messageDetailsView_layoutSubView];
    }
    return self;
}

- (void)messageDetailsView_addSubView {
    [self addSubview:self.container];
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timerLabel];

}
- (void)messageDetailsView_layoutSubView {
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.equalTo(self);
        

    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(82 / 3.f);
        make.left.mas_equalTo(88 / 3.f);
        make.right.mas_equalTo(-88 / 3.f);

    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(78 / 3.f);
        make.left.mas_equalTo(88 / 3.f);
        make.right.mas_equalTo(-88 / 3.f);
        
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_offset(78 / 3.f);
        make.left.mas_equalTo(88 / 3.f);
        make.right.mas_equalTo(-88 / 3.f);
        
    }];
    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(30 / 3.f);
        make.left.mas_equalTo(88 / 3.f);
        make.right.mas_equalTo(-88 / 3.f);
        make.bottom.mas_equalTo(self.container.mas_bottom).mas_offset(-82 / 3.f);
        

    }];
}

- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc]init];
    }
    return _container;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [ManagerEngine getColor:@"333333"];
        _titleLabel.font = [UIFont systemFontOfSize:48 / 3.f];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 1;
        _titleLabel.text = @"系统维护";
    }
    return _titleLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = [ManagerEngine getColor:@"333333"];
        _contentLabel.font = [UIFont systemFontOfSize:48 / 3.f];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = @"【物物地图】平台将于2019年06月06日00:00--05:00，将对平台系统进行维护。期间将暂停服务，感谢您的理解与支持“夕阳红”打榜团前赴后继，送周杰伦上了微博超话榜首。中老年歌迷用一次行为艺术解构了数据与热度：流量不等于流行，榜单在网上更在心上，音乐品格终究由时间检验。过去的经典会过去，未来的流行还会来，老歌迷有自己的倔强，也希望：今天的中国音乐，有足够精彩供明日回响。最早在微博上支持崔老师，只会评论。是网友纷纷合合，建了一个群送给了我。告诉我有崔老师的超话，教我发头条文章，她是最早告诉我突击手品行不端不可靠。\n 老战友都还记得老师在微博时的日日夜夜，半夜不睡抢评论，各个群里热火朝天的转发和讨论。因为在微博没有经验，发言冲动，在支持老师的过程中，有两个微博号被销号，很多战友有同样的经历。但是大家锲而不舍，冲劲十足。有人着重打狗，有人着重写转基因，也有人着重于抨击华谊和饭凉凉，想当初怎一个热火朝天了得。因为老师转发了我的一篇文章，我的微博被无故禁言两个月。而在这个期间，老师的微博也被限制了。这个阶段，大家的热情其实还是非常高的，而且微博上询问关心老师情况也非常多。\n 从第一次的所谓抓黑开始，陆陆续续没完没了的内斗和互杠。真正的黑子抓住了几个？内讧所造成的影响远比黑子造成的影响要大多少倍。堡垒都是从内部攻破的。多少的战友伤心落泪的离开了微博。带着灰心与痛苦。现在内斗的火力之猛烈，已经超过了怼黑子。立场鲜明站队的才是自己人。能够超然事外的寥寥无几。劝和为贵的更是里外不是人。以至于黑子可以悠哉悠哉的坐山观虎斗了。即便是崔老师出来，估计也不能弥补这些裂痕。看到熟悉的朋友，他们的难过和纷争，止不住内心的一些心酸。\n当你所喜欢的朋友和你一朝翻脸，当你发现你喜爱的人，你在他心目中其实一文不值，这是怎样的感受？毛主席说过，人上100形形色色，党内无派，千奇百怪。也许是因为缺乏了明确的共同目标和话题，挺崔的这个大的队伍中本来是囊括了方面各个阶层不同观点的人们。在目前情况下，大家的观点上的分歧就显现出来了。\n人生苦短，为欢几何？不要把时间和精力浪费在你不喜欢的人和事身上。\n古语有云：君子之交淡有水，重理念轻私谊。\n古语又云：君子和而不同，我反对你的观点，但是我尊重你发言的权利。不要互相进行人格上的攻击。可以辩理，勿须攻人。\n不忘初心，砥砺前行。至于实在无法达成共识，那就各走各的阳关道，宁跟明白人打架，不跟糊涂人说话。秀才遇到兵，有理你也说不清，你再有理也没有办法封住别人的嘴，只能是无穷无尽的吵下去，有什么意义呢？\n生活虐我千万遍，我待生活如初恋。永不灰心，永远要相信未来一定属于光明的。祝崔老师和\n已经暂时退出及仍在微博上坚持为正义发声的朋友们喜乐平安，幸福如意。​​​​";
    }
    return _contentLabel;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [ManagerEngine getColor:@"333333"];
        _nameLabel.font = [UIFont systemFontOfSize:48 / 3.f];
        _nameLabel.textAlignment = NSTextAlignmentRight;
        _nameLabel.numberOfLines = 1;
        _nameLabel.text = @"技术服务部";

    }
    return _nameLabel;
}
- (UILabel *)timerLabel {
    if (!_timerLabel) {
        _timerLabel = [[UILabel alloc]init];
        _timerLabel.textAlignment = NSTextAlignmentRight;
        _timerLabel.textColor = [ManagerEngine getColor:@"333333"];
        _timerLabel.font = [UIFont systemFontOfSize:48 / 3.f];
        _timerLabel.numberOfLines = 1;
        _timerLabel.text = @"2019-06-06";

    }
    return _timerLabel;
}
@end
