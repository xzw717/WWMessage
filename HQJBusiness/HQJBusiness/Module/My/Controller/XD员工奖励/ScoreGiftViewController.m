//
//  ScoreGiftViewController.m
//  HQJBusiness
//
//  Created by 姚志中 on 2020/9/15.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ScoreGiftViewController.h"
#import "ScoreGiftView.h"
#import "ScoreGiftViewModel.h"
@interface ScoreGiftViewController ()
@property (nonatomic,strong) ScoreGiftView *contentView;
@property (nonatomic,strong) ScoreGiftViewModel * viewModel;
@end

@implementation ScoreGiftViewController
- (ScoreGiftView *)contentView {
    if (_contentView == nil) {
        _contentView = [[ScoreGiftView alloc]initWithFrame:CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT)];
    }
    return _contentView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DefaultBackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.zwNavView.backgroundColor = [UIColor whiteColor];
    self.zw_title = @"积分赠送";
    [self.view addSubview:self.contentView];
    // Do any additional setup after loading the view.
}    

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
