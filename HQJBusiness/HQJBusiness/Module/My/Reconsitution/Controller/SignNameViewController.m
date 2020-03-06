//
//  SetUpViewController.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/3.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "SignNameViewController.h"
#import "UITextView+YLTextView.h"

@interface SignNameViewController () <UITextViewDelegate>
@property (nonatomic,strong)UITextView *textView;
@end

@implementation SignNameViewController

- (UITextView *)textView{
    if ( _textView == nil ) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, WIDTH - 20, 110)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.textColor = [UIColor blackColor];
        _textView.delegate = self;
        _textView.keyboardType = UIKeyboardTypeDefault;
        //    textView.text = @"请写在自定义属性前面，如果长度大于limitLength设置长度会被自动截断。";
        _textView.limitLength = @50;
        _textView.placeholdColor = [ManagerEngine getColor:@"909399"];
        _textView.limitPlaceColor = [ManagerEngine getColor:@"909399"];
        _textView.placeholdFont = [UIFont systemFontOfSize:16];
        _textView.limitPlaceFont = [UIFont systemFontOfSize:16];
        //    textView.autoHeight = @1;
        //    textView.limitLines = @4;//行数限制优先级低于字数限制
        _textView.infoBlock = ^(NSString *text, CGSize textViewSize) {
            NSLog(@"当前文字: %@   当前高度:%lf",text,textViewSize.height);
        };
        
    }
    return _textView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.textView];
    self.view.backgroundColor = [ManagerEngine getColor:@"f5f5f5"];
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame = CGRectMake(0, 0, 50, 30);
    saveButton.backgroundColor = [UIColor whiteColor];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.layer.masksToBounds = YES;
    saveButton.layer.cornerRadius = 15.f;
    [saveButton setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont boldSystemFontOfSize:40.f/3];
    @weakify(self);
    [saveButton bk_addEventHandler:^(id  _Nonnull sender) {
        @strongify(self);
        [self saveSignName];

    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barRightItem = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = barRightItem;
    self.title = @"个性签名";
    self.navType = HQJNavigationBarBlue;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navType = HQJNavigationBarBlue;

    
}
- (void)saveSignName{
//    http://shoptest.heqijia.net/newShopApi/saveSignName.action?shopid=3b0bd904d3ff4d8ba319b9070573d6b0&signName=hahah
    NSMutableDictionary *dict = @{@"shopid":MmberidStr,@"signName":self.textView.text}.mutableCopy;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HQJBBounsOrder,HQJBSaveSignNameInterface];
    HQJLog(@"地址：%@",urlStr);
    if (MmberidStr) {
        [RequestEngine HQJBusinessPOSTRequestDetailsUrl:urlStr parameters:dict complete:^(NSDictionary *dic) {
            [SVProgressHUD showInfoWithStatus:dic[@"msg"]];
        } andError:^(NSError *error) {
        
        } ShowHUD:YES];
    }
}



@end
