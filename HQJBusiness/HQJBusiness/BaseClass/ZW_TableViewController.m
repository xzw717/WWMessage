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
@property (nonatomic,strong) NSMutableArray *listArrayOne;
@property (nonatomic,strong) NSMutableArray *listArrayTwo;
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
        _tableView.frame = CGRectMake(0, 44 , WIDTH, HEIGHT  - 44 - 64);
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
        [_tableView registerClass:[MyListTableViewCell class] forCellReuseIdentifier:@"listCell"];
     [_tableView registerClass:[ZHSetTableViewCell class] forCellReuseIdentifier:@"ZHSetCell"];
    }
    
    _tableView.contentInset = UIEdgeInsetsZero;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self requst];
        
        
    }];

    _tableView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    self.listArray = [NSMutableArray array];
    self.listArrayOne = [NSMutableArray array];
    self.listArrayTwo = [NSMutableArray array];
    _model =[[ZHSetModel alloc]init];
    _page = 1;
    
 
}



-(void) requst {
    

    [ToAuditViewModel toAuditRequstwithType:_RequstwithType andBlock:^(id listBlock) {
        if (1 == _page ) {
            [self.listArrayOne removeAllObjects];
        }
        [self.listArrayOne addObjectsFromArray:listBlock];
        
        
    } andZHsetBlock:^(id zhBlock) {
        if (1 == _page ) {
            [self.listArrayTwo removeAllObjects];
        }
        [self.listArrayTwo addObjectsFromArray:zhBlock];
        
    } andCompletion:^{
        if (1 == _page ) {
            [self.listArray removeAllObjects];
        }
        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
        [self.listArray addObjectsFromArray:self.listArrayOne];
        [self.listArray addObjectsFromArray:self.listArrayTwo];
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];

        
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
    
    
    if (self.listArrayOne.count != 0) {
        if (indexPath.row <=self.listArrayOne.count - 1) {
            MyListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell" forIndexPath:indexPath];
            cell.model = self.listArrayOne[indexPath.row];
            return cell;
            
        } else{
            
            ZHSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZHSetCell" forIndexPath:indexPath];
            NSInteger i = self.listArrayOne.count - indexPath.row;

           
            cell.model = self.listArrayTwo[[self integets:i]];
            return cell;
            
        }

    } else {
        ZHSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZHSetCell" forIndexPath:indexPath];
        
        _model = self.listArrayTwo[indexPath.row];
        
        cell.model = _model;
   

        
        
        
        
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (self.listArrayOne.count != 0) {
        
        if (indexPath.row <= self.listArrayOne.count - 1) {
            return 70;
        } else {
            
            NSInteger i = self.listArrayOne.count - indexPath.row;
            
            _model = self.listArrayTwo[[self integets:i]];
            if ([_model.bonusZH floatValue] == 0 || [_model.cashZH floatValue] == 0) {
                return 70;
            } else {
                return 140;
            }
            
        }

    } else {
        _model = self.listArrayTwo[ indexPath.row];
        if ([_model.bonusZH floatValue] == 0 || [_model.cashZH floatValue] == 0) {
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
    [self requst];
    
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
