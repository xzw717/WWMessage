//
//  PersonInfoViewController.m
//  HQJBusiness
//
//  Created by 姚 on 2019/7/4.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "UploadImagesViewController.h"
#import "ZWActionSheetView.h"
#import "UploadImageViewModel.h"

#define  ItemImageSize        (WIDTH - 120)/3
#define  DelBtnWidth          62/3.f

@interface UploadImagesViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic,strong)UploadImageViewModel *uploadViewModel;

@property(nonatomic,strong)NSMutableArray *imageArray;

@property(nonatomic,strong)UIView *maskView;

@property(nonatomic,strong)UIImage *selectImage;
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
        _maskView = [[UIView alloc]init];
        _maskView.backgroundColor = [UIColor whiteColor];
    }
    return _maskView;
}
- (UploadImageViewModel *)uploadViewModel {
    if (!_uploadViewModel) {
        _uploadViewModel = [[UploadImageViewModel alloc]init];
    }
    return _uploadViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _isLogo ? @"店铺Logo":@"店铺主图";
    self.view.backgroundColor = [ManagerEngine getColor:@"f5f5f5"];
    self.maskView.frame = CGRectMake(0, 0, WIDTH, _isLogo ? 100 + ItemImageSize : 130 + ItemImageSize * 2);
    [self.view addSubview:self.maskView];
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
        [self saveImages];

    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barRightItem = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = barRightItem;
    [self addSubViews];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navType = HQJNavigationBarBlue;
}
- (void)addSubViews{
    if (_isLogo) {
        
        UIButton *imageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 30, ItemImageSize,ItemImageSize)];
        [imageButton setImage:[UIImage imageNamed:@"add_pictures"] forState:UIControlStateNormal];
        imageButton.contentMode = UIViewContentModeScaleToFill;
        imageButton.centerX = self.maskView.centerX;
        @weakify(self);
        [imageButton bk_addEventHandler:^(id  _Nonnull sender) {
            @strongify(self);
            [self.uploadViewModel uploadImageWithImageType:self completion:^(UIImage * image) {
                [imageButton setImage:image forState:UIControlStateNormal];
                [self.imageArray addObject:image];
            }];

        } forControlEvents:UIControlEventTouchUpInside];
        [self.maskView addSubview:imageButton];
        UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(imageButton.mj_x + ItemImageSize - DelBtnWidth/2,imageButton.mj_y - DelBtnWidth/2, DelBtnWidth, DelBtnWidth)];
        [deleteButton setImage:[UIImage imageNamed:@"icon_delete_img"] forState:UIControlStateNormal];
        [deleteButton bk_addEventHandler:^(id  _Nonnull sender) {
            [imageButton setImage:[UIImage imageNamed:@"add_pictures"] forState:UIControlStateNormal];
            [self.imageArray removeAllObjects];
        } forControlEvents:UIControlEventTouchUpInside];
        [self.maskView addSubview:deleteButton];
        UIButton *seeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 30 + 10.f + ItemImageSize,ItemImageSize, 20.f)];
        [seeButton setTitle:@"查看示例" forState:UIControlStateNormal];
        [seeButton setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
        seeButton.centerX = self.maskView.centerX;
        seeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.maskView addSubview:seeButton];

    }else{
        
        int SPNum =  3 ;//水平一行放几个
        CGFloat JGGMinX = 30;//起始x值
        CGFloat JGGMinY = 30;//起始y值
        CGFloat SPspace = 30;//水平距离
        CGFloat CXspace = 30;//垂直距离
        @weakify(self);
        for (NSInteger i = 0; i < 5; i ++) {
            CGFloat x =  JGGMinX + i % SPNum * (ItemImageSize + SPspace);
            CGFloat y =  JGGMinY + i / SPNum * (ItemImageSize + CXspace);
            UIButton *imageButton = [[UIButton alloc]initWithFrame:CGRectMake(x, y, ItemImageSize, ItemImageSize)];
            [imageButton setImage:[UIImage imageNamed:@"add_pictures"] forState:UIControlStateNormal];
            imageButton.backgroundColor = [UIColor greenColor];
            imageButton.contentMode = UIViewContentModeScaleToFill;
            imageButton.tag = i + 100;
            [imageButton bk_addEventHandler:^(id  _Nonnull sender) {
                @strongify(self);
                [self.uploadViewModel uploadImageWithImageType:self completion:^(UIImage * image) {
                    [imageButton setImage:image forState:UIControlStateNormal];
                    [self.imageArray addObject:image];
                }];

            } forControlEvents:UIControlEventTouchUpInside];
            [self.maskView  addSubview:imageButton];
            UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(x + ItemImageSize-DelBtnWidth/2, y - DelBtnWidth/2, DelBtnWidth, DelBtnWidth)];
            deleteButton.tag = i + 200;
            [deleteButton setImage:[UIImage imageNamed:@"icon_delete_img"] forState:UIControlStateNormal];
            [deleteButton bk_addEventHandler:^(UIButton *sender) {
                UIButton *imageBtn = [self.maskView viewWithTag:sender.tag-100];
                if ([self.imageArray containsObject:imageBtn.currentImage]) {
                    [self.imageArray removeObject:imageBtn.currentImage];
                    [imageButton setImage:[UIImage imageNamed:@"add_pictures"] forState:UIControlStateNormal];
                }
            } forControlEvents:UIControlEventTouchUpInside];
            [self.maskView addSubview:deleteButton];
        }
        UIButton *seeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ItemImageSize, ItemImageSize)];
        seeButton.centerX = self.maskView.centerX;
        seeButton.bottom = self.maskView.bottom;
        [seeButton setTitle:@"查看示例" forState:UIControlStateNormal];
        [seeButton setTitleColor:DefaultAPPColor forState:UIControlStateNormal];
        seeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.maskView addSubview:seeButton];
    }
    
}

- (void)saveImages{
    NSLog(@"imageArr = %@",self.imageArray);
//    [self.uploadViewModel uploadImages:self.imageArray andImageType:self.isLogo?1:2 uploadResultBlock:^(NSInteger successNum, NSInteger failNum) {
//
//    }];
}
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
