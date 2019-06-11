//
//  ZW_TableViewController.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/20.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ZW_TableViewController.h"
#import "ToAuditViewModel.h"
#import "ZHSetTableViewCell.h"
#import "MyListTableViewCell.h"
#import "ZHSetModel.h"
@interface ZW_TableViewController ()<UITableViewDelegate,
UITableViewDataSource,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate>

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong) NSMutableArray *listArray;
//@property (nonatomic,strong) NSMutableArray *listArrayOne;
//@property (nonatomic,strong) NSMutableArray *listArrayTwo;
@property (nonatomic,strong) ZHSetModel* model;
@property (nonatomic,assign) NSInteger  page;
@end

@implementation ZW_TableViewController
-(UITableView *)tableView {
    if (!_tableView) {
//        NSInteger
        _tableView = [[UITableView alloc]init];
        _tableView.rowHeight = 70.0;
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.frame = CGRectMake(0, 44 , WIDTH, HEIGHT  - 44 - NavigationControllerHeight);
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
        [_tableView registerClass:[MyListTableViewCell class] forCellReuseIdentifier:@"listCell"];
     [_tableView registerClass:[ZHSetTableViewCell class] forCellReuseIdentifier:@"ZHSetCell"];
    }
    
    _tableView.contentInset = UIEdgeInsetsZero;
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [self requst];
        
        
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _page ++;
        [self requst];
    }];

    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    self.listArray = [NSMutableArray array];
//    self.listArrayOne = [NSMutableArray array];
//    self.listArrayTwo = [NSMutableArray array];
    _model =[[ZHSetModel alloc]init];
    _page = 1;
    
 
}



-(void) requst {
    

    [ToAuditViewModel toAuditRequstwithType:_RequstwithType page:_page andBlock:^(NSMutableArray *listBlock) {
        if (listBlock.count>0) {
            if (1 == _page ) {
                [self.listArray removeAllObjects];
            }
            NSArray *list = (NSArray *)listBlock;
            if(list.count>0){
                [self.listArray addObjectsFromArray:listBlock];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"没有更多数据了"];
        }
        

    } andCompletion:^{
        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
//        [self.tableView reloadData];
        [self endRefresh];

        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    id object = self.listArray[indexPath.row];
    if ([object isKindOfClass:[MyListModel class]]) {
        MyListModel *model = object;
        if (model.tradetype.integerValue == 9) {
            ZHSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZHSetCell" forIndexPath:indexPath];
            cell.model = object;
            return cell;
        }else{
            MyListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
            cell.model = object;
            return cell;
        }
        
    }else{
        ZHSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZHSetCell" forIndexPath:indexPath];
        cell.model = object;
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = self.listArray[indexPath.row];
    if ([object isKindOfClass:[MyListModel class]]) {
        MyListModel *model = object;
        if (model.tradetype.integerValue == 9) {
            if ([model.scoreRate floatValue] == 0 || [model.cashRate floatValue] == 0) {
                return 70;
            } else {
                return 140;
            }
        }else{
            return 70;
        }
    }else{
        ZHSetModel *model = object;
        if ([model.bonusZH floatValue] == 0 || [model.cashZH floatValue] == 0) {
            return 70;
        } else {
            return 140;
        }
    }
}

#pragma mark --
#pragma mark --- 绝对值
-(NSInteger)integets:(NSInteger)x {
    
    if (x < 0 ) {
        return x *(-1);
    } else {
        return x;
    }
    
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"brokenNetwork"];
}
//空白页点击事件
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    _page = 1;
    [self requst];
    
}
    
#pragma mark --- 停止刷新 并刷新表格
-(void)endRefresh {
    [self.tableView reloadData];
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
