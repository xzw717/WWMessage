//
//  XDViewController.m
//  HQJBusiness
//
//  Created by mymac on 2020/5/17.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "XDViewController.h"
#import "XDTableViewCell.h"
#import "XDModel.h"
#import "XDDetailViewController.h"
#import "XDViewModel.h"
#import "XDModel.h"
@interface XDViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView   *xdTableView;
@property (nonatomic, strong) NSMutableArray <XDModel *>*modelAry;
@end

@implementation XDViewController

#pragma mark --
#pragma mark ---
- (void)viewDidLoad {
    [super viewDidLoad];
    self.zwBackButton.hidden = YES;
    self.zwNavView.backgroundColor = DefaultAPPColor;
    [self.view addSubview:self.xdTableView];
    [XDViewModel requstXDWithCompletion:^(NSArray<XDModel *> * _Nonnull modelArray) {
        self.modelAry = modelArray.mutableCopy;
        [self.xdTableView reloadData];
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelAry.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XDTableViewCell class]) forIndexPath:indexPath];
    cell.model = self.modelAry[indexPath.row];
    if (indexPath.row == self.modelAry.count - 1) {
        cell.lineView.hidden = YES;
    } else {
        cell.lineView.hidden = NO;
    }
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XDDetailViewController *dvc = [[XDDetailViewController alloc]initWithXDType:indexPath.row];
    [self.navigationController pushViewController:dvc animated:YES];
}
//- (NSMutableArray<XDModel *> *)modelAry {
//    if (!_modelAry) {
//        NSArray *ary = @[
//            @{@"imageName":@"icon_identification",@"titleName":@"标识企业",@"subTitleName":@"国物标识  产品赋码  扫码溯源"},
//            @{@"imageName":@"icon_different",@"titleName":@"异盟企业",@"subTitleName":@"国物标识牌照  活动营销"},
//            @{@"imageName":@"icon_benchmarking",@"titleName":@"标杆企业",@"subTitleName":@"营销助手  联合活动  【物物地图】系统"},
//            @{@"imageName":@"icon_brother",@"titleName":@"兄弟企业",@"subTitleName":@"视频直播  营销推广  数据防伪"},
//            @{@"imageName":@"icon_ecology",@"titleName":@"生态企业",@"subTitleName":@"社群经济  企业培训  产品溯源"}];
//        _modelAry = [XDModel mj_objectArrayWithKeyValuesArray:ary];
//    }
//    return _modelAry;
//}

- (UITableView *)xdTableView {
    if (!_xdTableView) {
        _xdTableView = [[UITableView alloc]init];
        _xdTableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight);
        _xdTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _xdTableView.delegate = self;
        _xdTableView.dataSource = self;
        _xdTableView.rowHeight = NewProportion(183);
        [_xdTableView registerClass:[XDTableViewCell class] forCellReuseIdentifier:NSStringFromClass([XDTableViewCell class])];
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, NewProportion(540))];
        view.image = [UIImage imageNamed:@"XD商家banner"];
//        view.backgroundColor = [UIColor blueColor];
        _xdTableView.tableHeaderView = view;
        _xdTableView.tableFooterView = [UIView new];
        _xdTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _xdTableView;
}
@end
