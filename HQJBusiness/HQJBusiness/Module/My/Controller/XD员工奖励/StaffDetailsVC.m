//
//  StaffDetailsVC.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/28.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "StaffDetailsVC.h"
#import "StaffDetailsViewModel.h"
#import "StaffDetailsModel.h"
@interface StaffDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *staffDetailsTableView;
@property (nonatomic, strong) NSArray <NSString *>*modelArray;
@property (nonatomic, assign) listStyle style;

@end

@implementation StaffDetailsVC
- (instancetype)initWithDetalisStyle:(listStyle)style {
    self = [super init];
    if (self) {
        _style = style;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.modelArray = [[[StaffDetailsViewModel alloc]init] setModeArrayWithType:self.style];
    [self.view addSubview:self.staffDetailsTableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return  self.modelArray.count;
 
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = self.modelArray[indexPath.row];
    return cell;
   
}

- (UITableView *)staffDetailsTableView {
    if (!_staffDetailsTableView) {
        _staffDetailsTableView = [[UITableView alloc]init];
        _staffDetailsTableView.frame = CGRectMake(0, 45, self.view.mj_w, self.view.mj_h - NavigationControllerHeight - NewProportion(710) - 45);
        _staffDetailsTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _staffDetailsTableView.delegate = self;
        _staffDetailsTableView.dataSource = self;
        [_staffDetailsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _staffDetailsTableView.tableFooterView = [UIView new];
        
    }
    return _staffDetailsTableView;
}
@end
