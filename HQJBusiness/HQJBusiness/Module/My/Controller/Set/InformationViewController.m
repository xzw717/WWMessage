//
//  InformationViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/21.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "InformationViewController.h"

#import "InformationViewModel.h"

#import "informationModel.h"

#import "InformationCell.h"

#import "AddressDetailsViewController.h"

@interface InformationViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *informationTableView;
@property (nonatomic,strong)informationModel *model;
@end

@implementation InformationViewController

-(UITableView *)informationTableView {
    
    if ( _informationTableView == nil ) {
        
        _informationTableView = [[UITableView alloc]init];
        _informationTableView.frame = CGRectMake(0, NavigationControllerHeight, WIDTH, HEIGHT - NavigationControllerHeight);
        _informationTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _informationTableView.delegate = self;
        _informationTableView.dataSource = self;
        _informationTableView.sectionFooterHeight = 2;
        _informationTableView.sectionHeaderHeight = 2;
        [_informationTableView registerClass:[InformationCell class] forCellReuseIdentifier:NSStringFromClass([InformationCell class])];
        _informationTableView.tableFooterView = [UIView new];
        UIView *backgroundView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 195)];
        ZW_imageView *headerView = [[ZW_imageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 180)];
        headerView.zw_image = @"infoBackground";
        [backgroundView addSubview:headerView];
        _informationTableView.tableHeaderView = backgroundView;
    }
    
    return _informationTableView;
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

        
        return 7;
        
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    
    InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([InformationCell class]) forIndexPath:indexPath];
    [cell setModel:_model andindexPath:indexPath];
    if (indexPath.row == 6) {
        CellLine(cell);

    }
    return cell;
    
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2) {
        AddressDetailsViewController *addVC =[[AddressDetailsViewController alloc]init];
        addVC.addressStr = _model.address;
        [self.navigationController pushViewController:addVC animated:YES];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.zw_title =@"个人信息";
    
    _model = [[informationModel alloc]init];
    
    [InformationViewModel informationRequstBlock:^(id infoBlock) {
        _model = infoBlock;
        [self.view addSubview:self.informationTableView];

    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
