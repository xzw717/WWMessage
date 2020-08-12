//
//  StaffRoleViewController.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/31.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

@interface CustomFlowLayout : UICollectionViewFlowLayout

@end
@interface CustomFlowLayout ()
@property (nonatomic) CGFloat maximumInteritemSpacing;
@end
@implementation CustomFlowLayout
- (instancetype)init{
    if (self = [super init]) {
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = 10;
        self.maximumInteritemSpacing = 10;
        self.sectionInset = UIEdgeInsetsMake(0 , NewProportion(50), 0, NewProportion(50));
    }
    return self;
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //使用系统帮我们计算好的结果。
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    //第0个cell没有上一个cell，所以从1开始
    for(int i = 1; i < [attributes count]; ++i) {
        //这里 UICollectionViewLayoutAttributes 的排列总是按照 indexPath的顺序来的。
        UICollectionViewLayoutAttributes *curAttr = attributes[i];
        UICollectionViewLayoutAttributes *preAttr = attributes[i-1];
        
        NSInteger origin = CGRectGetMaxX(preAttr.frame);
        //根据  maximumInteritemSpacing 计算出的新的 x 位置
        CGFloat targetX = origin + _maximumInteritemSpacing;
        // 只有系统计算的间距大于  maximumInteritemSpacing 时才进行调整
        if (CGRectGetMinX(curAttr.frame) > targetX) {
            // 换行时不用调整
            if (targetX + CGRectGetWidth(curAttr.frame) < self.collectionViewContentSize.width) {
                CGRect frame = curAttr.frame;
                frame.origin.x = targetX;
                curAttr.frame = frame;
            }
        }
    }
    return attributes;
}

@end
#import "StaffRoleViewController.h"
#import "StaffRoleItem.h"
#import "HintView.h"
#import "StaffAddRoleTextField.h"
#import "AddStaffViewModel.h"
#import "RoleListModel.h"
@interface StaffRoleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,AddRoleDelegate>
@property (nonatomic, strong) StaffAddRoleTextField *roleTextField;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray <RoleListModel *>*itemDataSource;

@property (nonatomic, strong) UILabel *existingRoleTitleLabel;

@end

@implementation StaffRoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zw_title = @"员工角色";
  
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.roleTextField];
    [self.view addSubview:self.existingRoleTitleLabel];
    [self.roleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(NavigationControllerHeight);
        make.height.mas_equalTo(60);
    }];
    [self.existingRoleTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NewProportion(50));
        make.top.mas_equalTo(self.roleTextField.mas_bottom).mas_offset(NewProportion(50));
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.existingRoleTitleLabel.mas_bottom).mas_offset(NewProportion(50));
        make.left.bottom.right.mas_equalTo(0);
    }];
    self.itemDataSource = [NSMutableArray array];
    [self getRole];
}
- (void)getRole {
    [AddStaffViewModel getTitlesWithCompletion:^(NSArray<RoleListModel *> * _Nonnull modelArray) {
        self.itemDataSource = [modelArray mutableCopy];
        [self.collectionView reloadData];
    }];
}

- (void)roleAction:(BOOL)isAdd nameWithID:(NSString *)nameID {
    dispatch_group_t downloadGroup = dispatch_group_create();
     dispatch_group_enter(downloadGroup);
    if (isAdd) {
        [AddStaffViewModel addRoleNameWithName:nameID completion:^{
                dispatch_group_leave(downloadGroup);
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];

            }];
    } else {
        [AddStaffViewModel removeRoleNameWithRoleID:nameID completion:^{
            dispatch_group_leave(downloadGroup);
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];

        }];
    }
    
     dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self getRole];

         });
     });
}


- (void)addRoleWithTile:(NSString *)role {
//    [self.itemDataSource addObject:role];
    [self roleAction:YES nameWithID:role];
    HQJLog(@"保存的角色是：%@",role);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat textWidth = [ManagerEngine setTextWidthStr:self.itemDataSource[indexPath.row].roleName andFont:[UIFont systemFontOfSize:14.f]];
    CGFloat w = textWidth > 50.f ? textWidth : 50.f ;
    return  CGSizeMake(w + NewProportion(50) * 2  , 44);

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.itemDataSource.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StaffRoleItem *cell = (StaffRoleItem *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([StaffRoleItem class]) forIndexPath:indexPath];
    cell.roleTitle = self.itemDataSource[indexPath.row].roleName;
    cell.backgroundColor = [UIColor whiteColor];
    @weakify(self);
    [cell setClickDelete:^(NSString *title) {
        @strongify(self);
        [HintView enrichSubviews:[NSString stringWithFormat:@"确定删除“%@”吗",title] andSureTitle:@"确定" cancelTitle:@"取消" sureAction:^{
              [self roleAction:NO nameWithID:self.itemDataSource[indexPath.row].nid];

        }];
    
    }];
    return cell;

   
   
}
- (StaffAddRoleTextField *)roleTextField {
    if (!_roleTextField) {
        _roleTextField = [[StaffAddRoleTextField alloc]init];
        _roleTextField.delegate = self;
    }
    return _roleTextField;
}
- (UILabel *)existingRoleTitleLabel {
    if (!_existingRoleTitleLabel) {
        _existingRoleTitleLabel = [[UILabel alloc]init];
        _existingRoleTitleLabel.text = @"已有角色";
        _existingRoleTitleLabel.font = [UIFont systemFontOfSize:15.f];
        _existingRoleTitleLabel.textColor = [UIColor blackColor];
    }
    return _existingRoleTitleLabel;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CustomFlowLayout *flowLayout = [[CustomFlowLayout alloc] init];
//        flowLayout.minimumInteritemSpacing = 10;
//        flowLayout.minimumLineSpacing = 10;
//        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = self.view.backgroundColor;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        // 注册 cell
        [_collectionView registerClass:[StaffRoleItem class] forCellWithReuseIdentifier:NSStringFromClass([StaffRoleItem class])];
        
    }
    return _collectionView;
}

-(NSArray *)itemArray {
    return @[@"角色一",@"角色2",@"角色③",@"亮",@"一二三四五六七八九十十一十二三",@"角色肆",@"臣本布衣",@"诸葛孔明"];
}

@end
