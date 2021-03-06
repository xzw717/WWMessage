//
//  PersonInfoViewController.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/4.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "UploadImagesViewController.h"

//#define  LeftSpace            215/3.f
#define  ItemImageSize        215/3.f
#define  ItemHeight           265/3.f
#define  ItemWidth            215/3.f

@interface UploadImagesViewController ()

@property(nonatomic,strong)NSMutableArray *imageArray;

@property(nonatomic,strong)UIView *maskView;

@end


@implementation UploadImagesViewController


- (NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _imageArray;
}

- (UIView *)maskView{
    if (_maskView == nil) {
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 120)];
    }
    [self.view addSubview:_maskView];
    return _maskView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _isLogo ? @"店铺Logo":@"店铺主图";
    
    [self addSubViews];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navType = HQJNavigationBarBlue;
}
- (void)addSubViews{
    if (_isLogo) {
        UIButton *imageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, S_RatioH(16.f), S_RatioW(ItemImageSize), S_RatioW(ItemImageSize))];
        [imageButton setImage:[UIImage imageNamed:@"add_pictures"] forState:UIControlStateNormal];
        imageButton.centerX = self.maskView.centerX;
        [imageButton bk_addEventHandler:^(id  _Nonnull sender) {
        } forControlEvents:UIControlEventTouchUpInside];
        [self.maskView addSubview:imageButton];
        UIButton *seeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, S_RatioH(16.f) + S_RatioH(10.f) + S_RatioW(ItemImageSize), S_RatioW(ItemImageSize), S_RatioH(20.f))];
        [seeButton setTitle:@"查看示例" forState:UIControlStateNormal];
        [seeButton setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
        seeButton.centerX = self.maskView.centerX;
        seeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.maskView addSubview:seeButton];

    }else{
        int SPNum =  3 ;//水平一行放几个
        CGFloat JGGMinX = S_RatioW(170.f/3);//起始x值
        CGFloat JGGMinY = S_RatioH(16.f);//起始y值
        CGFloat SPspace = S_RatioW(70.f/3);//水平距离
        CGFloat CXspace = S_RatioH(10.f);//垂直距离
        
        for (NSInteger i = 0; i < SPNum; i ++) {
            CGFloat x =  JGGMinX + i % SPNum * (ItemWidth + SPspace);
            CGFloat y =  JGGMinY + i / SPNum * (ItemHeight + CXspace);
            UIButton *imageButton = [[UIButton alloc]initWithFrame:CGRectMake(x, y, S_RatioW(ItemImageSize), S_RatioW(ItemImageSize))];
            [imageButton setImage:[UIImage imageNamed:@"add_pictures"] forState:UIControlStateNormal];
            [imageButton bk_addEventHandler:^(id  _Nonnull sender) {
            } forControlEvents:UIControlEventTouchUpInside];
            [self.maskView  addSubview:imageButton];
            UIButton *seeButton = [[UIButton alloc]initWithFrame:CGRectMake(x, y + S_RatioW(ItemImageSize), S_RatioW(ItemImageSize), S_RatioW(ItemImageSize))];
            [seeButton setTitle:@"查看示例" forState:UIControlStateNormal];
            [seeButton setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
            seeButton.titleLabel.font = [UIFont systemFontOfSize:12];
            [self.maskView addSubview:seeButton];
            
        }
    }
    
}



// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
