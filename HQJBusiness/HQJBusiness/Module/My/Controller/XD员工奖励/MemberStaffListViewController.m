//
//  MemberStaffListViewController.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/27.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MemberStaffListViewController.h"
#import "MemberStaffListSearchView.h"
#import "StaffDetailsViewController.h"
#import "MemberStaffListHeaderView.h"
#import "AddStaffViewController.h"

@interface MemberStaffListViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,ResultsListDelegate>
@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, strong) UILabel   *footerLabel;
@property (nonatomic, strong)UISearchBar *bar;
@property (nonatomic, strong) MemberStaffListSearchView *searchView;
@property (nonatomic, strong) MemberStaffListHeaderView *headerView;
@property (nonatomic, assign) listStyle style;

@end

@implementation MemberStaffListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, NavigationControllerHeight, WIDTH, 64)];
    self.bar.placeholder = @"员工66位";
    self.bar.searchBarStyle = UISearchBarStyleProminent;
    self.bar.delegate = self;
    self.bar.searchTextField.backgroundColor = [ManagerEngine getColor:@"ffffff"];
    self.bar.searchTextField.layer.masksToBounds = YES;
    self.bar.searchTextField.layer.cornerRadius = 18.f;
    self.bar.backgroundImage = [self imageWithColor:[ManagerEngine getColor:@"f5f5f5"] size:self.bar.frame.size];


//    bar.inputAccessoryView = [];
    [self.view addSubview:self.bar];
    [self.view addSubview:self.listView];  
    [self.view addSubview:self.searchView];
    self.listView.tableHeaderView = self.headerView;
    if (self.style == stafflistStyle) {
           self.zw_title = @"员工列表";
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setImage:[UIImage imageNamed:@"icon_Addemployee"] forState:UIControlStateNormal];
        rightBtn.bounds = CGRectMake(0, 0, 60, 44);
        [rightBtn addTarget:self action:@selector(addStaff) forControlEvents:UIControlEventTouchUpInside];
        self.zw_rightOneButton = rightBtn;;
       } else {
           self.zw_title = @"商家会员";
       }
}
- (void)addStaff {
    AddStaffViewController *vc = [[AddStaffViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (instancetype)initWithListStyle:(listStyle)style {
    self = [super init];
    if (self) {
        _style = style;
    }
    return self;
}
- (UIImage *)imageWithColor:(UIColor*)color size:(CGSize)size{
    CGRect rect =CGRectMake(0,0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/// 点击取消按钮时执行此方法
-(void)searchBarCancelButtonClicked:(UISearchBar*)searchBar {
    self.bar.text=@"";//把文字置空
    self.bar.showsCancelButton=NO;//隐藏取消按钮
    [self.bar resignFirstResponder];//退回键盘
    self.searchView.hidden = YES;
    [self.searchView.resultsArray removeAllObjects];
    [self.searchView reloadSearchList];

}

/// 搜索框开始编辑时调用
-(void)searchBarTextDidBeginEditing:(UISearchBar*)searchBar {
    self.bar.showsCancelButton=YES;//显示取消按钮
    self.searchView.hidden = NO;
}

/// 搜索框结束编辑时调用（例如可以在用户点击屏幕内其它地方时，让搜索框结束编辑）
- (void)searchBarTextDidEndEditing:(UISearchBar*)searchBar {
    if([searchBar.text isEqualToString:@""]) {//如果没有文字，才隐藏取消按钮
        self.bar.showsCancelButton=NO;
    }else{
        self.bar.showsCancelButton=YES;
    }
    self.searchView.hidden = !self.bar.showsCancelButton;

}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //    NSString * match = @"890";
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",searchText];
        NSArray * results = [[self listArray] filteredArrayUsingPredicate:predicate];
    self.searchView.resultsArray = results.mutableCopy;
    [self.searchView reloadSearchList];
//    NSLog(@"%@",results);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return [self listArray].count;
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [self listArray][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"headportrait"];
    cell.imageView.layer.masksToBounds =  YES;
    cell.imageView.layer.cornerRadius = NewProportion(120)/2.f;
    CGSize itemSize = CGSizeMake(NewProportion(120), NewProportion(120));
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return cell;
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        [self jumpDetails];
}
- (void)didSelectRowAtIndexPathWithName:(NSString *)name {
    [self searchBarCancelButtonClicked:self.bar];
    [self jumpDetails];
}
- (void)jumpDetails {
    StaffDetailsViewController *vc = [[StaffDetailsViewController alloc]initWithDetailsStyle:self.style];
    [self.navigationController pushViewController:vc animated:YES];
}
- (UITableView *)listView {
    if (!_listView) {
        _listView = [[UITableView alloc]init];
        _listView.frame = CGRectMake(0, NavigationControllerHeight + 64 , WIDTH, HEIGHT - NavigationControllerHeight - 64);
        _listView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _listView.delegate = self;
        _listView.dataSource = self;
        _listView.rowHeight = NewProportion(184);
        [_listView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _footerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, ToolBarHeight)];
        _footerLabel.backgroundColor = [ManagerEngine getColor:@"f2f2f2"];
        _footerLabel.textColor = [ManagerEngine getColor:@"333333"];
        _footerLabel.textAlignment = NSTextAlignmentCenter;
        _footerLabel.text = @"共有66位员工";
        _footerLabel.font = [UIFont systemFontOfSize:14.f];
        _listView.tableFooterView = _footerLabel;
        
    }
    return _listView;
}
- (MemberStaffListHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[MemberStaffListHeaderView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, NewProportion(308))];
    }
    return _headerView;
}
- (MemberStaffListSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[MemberStaffListSearchView alloc]init];
        _searchView.hidden = YES;
        _searchView.delegate = self;
    }
    return _searchView;
}
- (NSArray *)listArray {
    return @[@"慕芷琪",
             @"王雁凡",
             @"文悦欣",
             @"松书雪",
             @"龚云心",
             @"牛好洁",
             @"郗美芳",
             @"那燕岚",
             @"逯巧茹",
             @"禄冬亦",
             @"敖以旋",
             @"怀希蓉",
             @"温友卉",
             @"蔡慕夕",
             @"双敏丽",
             @"燕代亦",
             @"蒙倚云",
             @"邵雨南",
             @"苍天真",
             @"惠湛霞",
             @"麴宛菡",
             @"马凝蝶",
             @"师听枫",
             @"向欣艳",
             @"欧桐欣",
             @"鄂伯",
             @"程基",
             @"戌飚",
             @"欧亭",
             @"萧玄",
             @"龙凯",
             @"寇备",
             @"盖仝",
             @"傅征",
             @"师御",
             @"李穆",
             @"麴铖",
             @"叶之",
             @"那侪",
             @"温昌",
             @"阙珺",
             @"古辑",
             @"阙光",
             @"罗飞",
             @"谢超",
             @"吴沧",
             @"勾松",
             @"居基",
             @"班喆",
             @"孟群",
             @"飞轮海",
             @"非常可乐"];
}
@end
