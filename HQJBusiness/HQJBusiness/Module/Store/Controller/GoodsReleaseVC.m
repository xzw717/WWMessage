//
//  GoodsReleaseVC.m
//  HQJBusiness
//  商品发布
//  Created by mymac on 2019/7/11.
//  Copyright © 2019 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "GoodsReleaseVC.h"
#import "GoodsReleaseUploadPicturesCell.h"
#import "HQJTZImagePickerController.h"
#import "GoodsReleaseMainCell.h"
#import "GoodsManageAlertView.h"
#import "CatalogueVC.h"

#define SectionHeaderHeight (40/ 3.f)
typedef NS_ENUM(NSInteger , uploadImageStatus){
    ///  没有选择图片
    NoChoiceImageState = 0,
    
    /// 图片上传中
    UploadImageIngState,
    
    /// 图片上传完成
    UploadImageCompleteState
};

@interface GoodsReleaseVC ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,ReleaseButtonViewDelegate>
@property (nonatomic, strong) UITableView  *goodsReleaseTableView;
@property (nonatomic, assign) uploadImageStatus uploadState;
@property (nonatomic, strong) GoodsReleaseViewModel *viewModel;
@property (nonatomic, strong) ReleaseButtonView *releaseView;
@property (nonatomic, assign) ReleaseButtonStyle style;
@property (nonatomic, strong) NSString *vcTitle;
@end

@implementation GoodsReleaseVC
- (instancetype)initWithNavType:(HQJNavigationBarColor)type buttonStyle:(ReleaseButtonStyle)style controllerTitle:(NSString *)title {
    self = [super initWithNavType:type];
    if (self) {
        _style = style;
        _vcTitle = title;
        
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self setNavType:HQJNavigationBarWhite];
    if ([self.vcTitle containsString:@"编辑"]) {
        self.fd_interactivePopDisabled = YES;
        @weakify(self);
        [self setBackBlock:^{
            @strongify(self);
            [GoodsManageAlertView alertViewInitWithTitle:@"是否放弃本次编辑" cancelButtonTitle:@"保存草稿" otherButtonTitles:@{AlertViewTitle:@"放弃",AlertViewTitleColor:DefaultAPPColor} Complete:^{
                [self.navigationController popViewControllerAnimated:YES];

            } negative:^{
                HQJLog(@"保存并退出");
                [self.navigationController popViewControllerAnimated:YES];
            }];

        }];
    }
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.vcTitle;
    self.view.backgroundColor = DefaultBackgroundColor;
    [self setSubView];

}

- (void)setSubView {
    [self.view addSubview:self.goodsReleaseTableView];
    [self.view addSubview:self.releaseView];
    [self.goodsReleaseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.releaseView.mas_top);
    }];
    [self.releaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(306 / 3.f);
    }];
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitleColor:RedColor forState:UIControlStateNormal];
    [addButton setTitle:@"发布规则" forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:40 /3.f];
    addButton.layer.masksToBounds = YES;
//    addButton.layer.cornerRadius = 41 / 3.f;
//    addButton.backgroundColor = DefaultAPPColor;
    addButton.frame = CGRectMake(0, 0, 164 / 3.f, 82 / 3.f);
    //    @weakify(self);
    [addButton addTarget:self.viewModel action:@selector(clickRulesbutton) forControlEvents:UIControlEventTouchUpInside];
    //    [addButton bk_addEventHandler:^(id  _Nonnull sender) {
    //        @strongify(self);
    ////        [self.viewModel navMenu:sender];
    //
    //    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barRightItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItem = barRightItem;
}

#pragma mark --- UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SectionHeaderHeight;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 340 / 3.f;
    } else {
        if ([self.viewModel.keyAry[indexPath.section][indexPath.row] isEqualToString:@"商品介绍"]) {
            return 430 / 3.f;

        } else {
            return 140 / 3.f;

        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 0) {
        CatalogueVC *vc = [[CatalogueVC alloc]initWithNavType:HQJNavigationBarWhite];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark --- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.viewModel.keyAry.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.keyAry[section].count;
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        GoodsReleaseUploadPicturesCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GoodsReleaseUploadPicturesCell class]) forIndexPath:indexPath];
        @weakify(self);
        [cell.cellContentView setGoPhotoAlbumBlock:^{
            @strongify(self);
//            [self addPotho2:cell.cellContentView];
            self.uploadState = UploadImageIngState;
        }];
        return cell;

    } else {
        GoodsReleaseMainCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GoodsReleaseMainCell class]) forIndexPath:indexPath];
        NSString *tit = self.viewModel.keyAry[indexPath.section][indexPath.row];
        NSString *pla = self.viewModel.placeholderAry[indexPath.section][indexPath.row];
        @weakify(self);
        [cell setCellUpdata:^ {
            @strongify(self);
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:2];
            [self.goodsReleaseTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        [cell mainDataWithTitle:tit countPlaceholder:pla];
        return cell;
    }

}



#pragma mark --- initView
- (UITableView *)goodsReleaseTableView {
    if (!_goodsReleaseTableView) {
        _goodsReleaseTableView = [[UITableView alloc]init];
        _goodsReleaseTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _goodsReleaseTableView.showsVerticalScrollIndicator = NO;
        _goodsReleaseTableView.rowHeight = 530 / 3.f;
        _goodsReleaseTableView.delegate = self;
        _goodsReleaseTableView.dataSource = self;
        [_goodsReleaseTableView registerClass:[GoodsReleaseUploadPicturesCell class] forCellReuseIdentifier:NSStringFromClass([GoodsReleaseUploadPicturesCell class])];
        [_goodsReleaseTableView registerClass:[GoodsReleaseMainCell class] forCellReuseIdentifier:NSStringFromClass([GoodsReleaseMainCell class])];
        
        _goodsReleaseTableView.tableFooterView = [UIView new];
        
    }
    return _goodsReleaseTableView;
}
- (GoodsReleaseViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[GoodsReleaseViewModel alloc]init];
    }
    return _viewModel;
}
- (ReleaseButtonView *)releaseView {
    if (!_releaseView) {
        _releaseView = [[ReleaseButtonView alloc]initWithReleaseButtonStyle:_style];
        _releaseView.backgroundColor = DefaultBackgroundColor;
        _releaseView.releaseButtonDelegate = self.viewModel;
    }
    return _releaseView;
}
@end
