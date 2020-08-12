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
#import "MemberStaffModel.h"
@interface StaffDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *staffDetailsTableView;
@property (nonatomic, strong) NSArray <NSString *>*modelArray;
@property (nonatomic, assign) listStyle style;
@property (nonatomic, strong) MemberStaffModel *model;

@end

@implementation StaffDetailsVC
- (instancetype)initWithDetalisStyle:(listStyle)style
                         detaliModel:(MemberStaffModel *)model {
    self = [super init];
    if (self) {
        self.style = style;
        self.model = model;
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
    NSString *contentStr ;
    if (indexPath.row == 0) {
        contentStr = self.style == stafflistStyle ? self.model.empNo : self.model.nickname;
    } else if (indexPath.row == 1) {
        contentStr = self.style == stafflistStyle ? self.model.nickname : self.model.mobile;

    } else if (indexPath.row == 2) {
        contentStr = self.style == stafflistStyle ? self.model.mobile : self.model.registerTime;

    } else if (indexPath.row == 3) {
        contentStr = self.model.roleName;

    } else if (indexPath.row == 4) {
        contentStr = [ManagerEngine zzReverseSwitchTimer:self.model.entryTime dateFormat:@"YYYY-MM-dd"];

    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@  %@",self.modelArray[indexPath.row],contentStr];
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
