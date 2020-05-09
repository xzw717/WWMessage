//
//  CertificationViewController.m
//  HQJBusiness
//   主播认证
//  Created by mymac on 2020/4/1.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "CertificationViewController.h"

@interface CertificationViewController ()<UITextViewDelegate>
@property (nonatomic, assign) BOOL isAgree;
@property (nonatomic, strong) UIButton *nextBtn;
@end

@implementation CertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.zw_title = @"播主身份认证";
    [self setUI];
    self.isAgree = NO;

}

- (void)setUI {
    UILabel *titLabel = [[UILabel alloc]init];
    titLabel.text = @"上传身份证照片";
    titLabel.font = [UIFont systemFontOfSize:15.f weight:UIFontWeightBold];
    [self.view addSubview:titLabel];
    [titLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.zwNavView.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(10);
    }];

    UILabel *instructionsOneLabel = [[UILabel alloc]init];
    instructionsOneLabel.numberOfLines = 0;
    instructionsOneLabel.text = @"1、为保证账号信息真实有效，请上传法人身份证照片\n2、确保照片清晰，边框完整";
    instructionsOneLabel.font = [UIFont systemFontOfSize:14.f];
    [self.view addSubview:instructionsOneLabel];
    [instructionsOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titLabel.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(titLabel);
    }];
    
    UIImageView *frontImageView = [[UIImageView alloc]init];
    frontImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:frontImageView];
    [frontImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(instructionsOneLabel.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(WIDTH / 3);
        make.height.mas_equalTo(frontImageView.mas_width).multipliedBy(0.629);
    }];
    UIImageView *reverseImageView = [[UIImageView alloc]init];
    reverseImageView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:reverseImageView];
    [reverseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.mas_equalTo(frontImageView.mas_bottom).mas_offset(20);
          make.centerX.mas_equalTo(frontImageView);
          make.width.mas_equalTo(WIDTH / 3);
          make.height.mas_equalTo(reverseImageView.mas_width).multipliedBy(0.629);
    }];
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:13];
    nameLabel.text = @"真实姓名*";
    [self.view addSubview:nameLabel];
    [nameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(reverseImageView.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(instructionsOneLabel);

    }];
    
    
    UITextField *nameTextField = [[UITextField alloc]init];
    nameTextField.placeholder = @"请输入营业执照法人姓名";
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    nameTextField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nameTextField];
    [nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(nameLabel);
        make.left.mas_equalTo(nameLabel.mas_right).mas_offset(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *numberLabel = [[UILabel alloc]init];
    numberLabel.font = [UIFont systemFontOfSize:13];
    numberLabel.text = @"证件号码*";
    numberLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:numberLabel];
    [numberLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLabel.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(nameLabel);
      }];

     
    UITextField *numberTextField = [[UITextField alloc]init];
    numberTextField.placeholder = @"请输入营业执照法人姓名";
    numberTextField.textAlignment = NSTextAlignmentCenter;
    numberTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:numberTextField];
    [numberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerY.mas_equalTo(numberLabel);
          make.left.mas_equalTo(numberLabel.mas_right).mas_offset(10);
          make.right.mas_equalTo(-10);
          make.height.mas_equalTo(40);
    }];

    UIButton *protocolBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    protocolBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:protocolBtn];
    [protocolBtn addTarget:self action:@selector(clickProtocolBtn:) forControlEvents:UIControlEventTouchUpInside];
    [protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(numberLabel.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(instructionsOneLabel);
    }];
    
    UILabel *protocolOneLabel = [[UILabel alloc]init];
    protocolOneLabel.text = @"同意接受";
    protocolOneLabel.font = [UIFont systemFontOfSize:14.f];
    [self.view addSubview:protocolOneLabel];
    [protocolOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(protocolBtn.mas_right);
        make.centerY.mas_equalTo(protocolBtn);
    }];
    
    UILabel *protocolTwoLabel = [[UILabel alloc] init];
    protocolTwoLabel.font = [UIFont systemFontOfSize:14.f];
    protocolTwoLabel.text = @"《物物地图平台视频直播协议》";
    protocolTwoLabel.textColor = [UIColor cyanColor];
    protocolTwoLabel.userInteractionEnabled = YES;
    [self.view addSubview:protocolTwoLabel];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickProtocolTwoLabel:)];
    [protocolTwoLabel addGestureRecognizer:tap];
    [protocolTwoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(protocolOneLabel.mas_right);
        make.centerY.mas_equalTo(protocolOneLabel);
    }];
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.nextBtn.layer.masksToBounds = YES;
    self.nextBtn.layer.cornerRadius = 10.f;
    [self.nextBtn setBackgroundColor:[UIColor grayColor]];
    [self.nextBtn addTarget:self action:@selector(clickNext:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(protocolTwoLabel.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(40);
    }];
     NSString *str1 = @"4000591081";
    NSString *str = [NSString stringWithFormat:@"以上信息仅用直播身份认证,【物物地图】平台对您的个人信息严格保密。如需帮助，请联系客服%@",str1];
     NSRange range1 = [str rangeOfString:str1];
    UITextView *textView = [[UITextView alloc] init];
    textView.editable = NO;
    textView.delegate = self;
    textView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:textView];
    NSMutableAttributedString *mastring = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.5f]}];
    [mastring addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:range1];
    NSString *valueString1 = [[NSString stringWithFormat:@"firstPerson://%@",str1] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [mastring addAttribute:NSLinkAttributeName value:valueString1 range:range1];
    textView.attributedText = mastring;
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nextBtn.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
    }];
}

- (void)clickProtocolTwoLabel:(UIGestureRecognizer *)tap{
        HQJLog(@"点击了协议");
}

- (void)clickProtocolBtn:(UIButton *)btn {
    self.isAgree = !self.isAgree;
    btn.backgroundColor =self.isAgree ? [UIColor blueColor] : [UIColor yellowColor];
    [self.nextBtn setBackgroundColor:self.isAgree ? [UIColor blueColor] : [UIColor grayColor]];
    HQJLog(@"点击了%@",self.isAgree ? @"同意":@"不同意");
}

- (void)clickNext:(UIButton *)btn {
     HQJLog(@"点击了下一步");
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"firstPerson"]) {
    NSString *titleString = [NSString stringWithFormat:@"你点击了第一个文字:%@",[URL host]];
//    [self clickLinkTitle:titleString];
    return NO;
    } else if ([[URL scheme] isEqualToString:@"secondPerson"]) {
    NSString *titleString = [NSString stringWithFormat:@"你点击了第二个文字:%@",[URL host]];
//    [self clickLinkTitle:titleString];
    return NO;
    }
    return YES;
}
@end
