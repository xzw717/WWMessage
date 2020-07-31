//
//  MemberStaffListSearchView.m
//  HQJBusiness
//
//  Created by mymac on 2020/7/27. CGRectMake(0, 0, WIDTH, HEIGHT - NavigationControllerHeight - 64
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "MemberStaffListSearchView.h"
@interface MemberStaffListSearchView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *resultsList;
@end
@implementation MemberStaffListSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 64 + NavigationControllerHeight, WIDTH, HEIGHT - 64 - NavigationControllerHeight)];
    if (self) {
        [self addSubview:self.resultsList];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return self.resultsArray.count;
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = self.resultsArray[indexPath.row];
    return cell;
  
}
 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectRowAtIndexPathWithName:)]) {
        [self.delegate didSelectRowAtIndexPathWithName:self.resultsArray[indexPath.row]];
    }
}
- (void)reloadSearchList {
    [self.resultsList reloadData];
}
- (UITableView *)resultsList {
    if (!_resultsList) {
        _resultsList = [[UITableView alloc]init];
        _resultsList.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _resultsList.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _resultsList.delegate = self;
        _resultsList.dataSource = self;
        [_resultsList registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 0.01)];
        _resultsList.tableFooterView = view;
        
    }
    return _resultsList;
}
@end
