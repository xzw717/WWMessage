//
//  pickerView.m
//  HQJFacilitator
//
//  Created by mymac on 2016/10/12.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "pickerView.h"

@interface pickerView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *pickTableView;
@property (nonatomic,strong)NSArray *ListArray;
@property (nonatomic,strong)UIView *backgroudView;
@property (nonatomic,assign)CGRect backCGRct;
@end
@implementation pickerView
-(instancetype)initWithFrame:(CGRect)frame andTitleAry:(NSMutableArray *)ary {
    self = [super initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    if (self) {
        _ListArray = ary;
        _backCGRct = frame;
        self.backgroundColor = [UIColor clearColor];

       self.backgroudView = [[UIView alloc]initWithFrame:frame];
        self.backgroudView.layer.masksToBounds = YES;
        self.backgroudView.layer.cornerRadius = 5;
       self.backgroudView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backgroudView];
        [self.backgroudView addSubview:self.pickTableView];

    }
    
    return self;
}
-(UITableView *)pickTableView {
    if (!_pickTableView) {
        _pickTableView = [[UITableView alloc]init];
//        _pickTableView.backgroundColor = [UIColor redColor];
        _pickTableView.frame = CGRectMake(0, 0, _backCGRct.size.width, _ListArray.count * 45 > HEIGHT/2 ?HEIGHT/2 : _ListArray.count * 45);
        _pickTableView.delegate = self;
        _pickTableView.dataSource = self;
        _pickTableView.rowHeight = 45;
        [_pickTableView setTableFooterView:[UIView new]];
        [_pickTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _pickTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        

    }
    
    
    
    return _pickTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _ListArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    
    cell.textLabel.text = _ListArray[indexPath.row];
    
    return cell;
    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    _senderBlock([NSString stringWithFormat:@"%ld",(long)indexPath.row]);
    [self hiddenView];
}


#pragma mark --
#pragma mark ---刷新数据
-(void)refreshData {
    [self.pickTableView reloadData];
    
}
-(void)showView {

    UIWindow *windowView = [UIApplication sharedApplication].keyWindow;
    [windowView addSubview:self];
    
}
-(void)hiddenView {
    
    /**
     *  删除 在backGroundView 上的子控件
     */
    NSArray *results = [self.backgroudView subviews];
    
    for (UIView *view in results) {
        
        [view removeFromSuperview];
        
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        //
        self.backgroudView.frame = CGRectMake(_backCGRct.origin.x, _backCGRct.origin.y, _backCGRct.size.width, 0);
//        self.pickTableView.frame =CGRectMake(_backCGRct.origin.x, _backCGRct.origin.y, _backCGRct.size.width, 0);

    } completion:^(BOOL finished) {
        //
        [self removeFromSuperview];
    }];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (![[touches anyObject].view isEqual:self.backgroudView]) {
        
        [self hiddenView];
        
    }
    
    
    
}

@end
