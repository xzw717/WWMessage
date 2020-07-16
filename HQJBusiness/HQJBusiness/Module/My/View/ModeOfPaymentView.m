//
//  ModeOfPaymentView.m
//  HQJBusiness
//
//  Created by mymac on 2016/12/15.
//  Copyright © 2016年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ModeOfPaymentView.h"
#import "ModeOfPayCell.h"

/// table 的高度   60 * 2 + 45
static CGFloat const kTableHeight = 165.f;
@interface ModeOfPaymentView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView *backgroundView;

@property (nonatomic,retain) NSIndexPath *selectCellIndexPath;

@property (nonatomic, strong)  NSArray *payTitleArray;

@property (nonatomic, strong)  NSArray *payImageArray;

@property (nonatomic,strong) UITableView *table;
@end
@implementation ModeOfPaymentView
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        
        _backgroundView = [[UIView alloc]init];
        self.payImageArray = [NSArray array];
        self.payTitleArray = [NSArray array];
        _backgroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_backgroundView];
        _table = [[UITableView alloc]init];
        _table.delegate = self;
        _table.dataSource = self;
        _table.frame = CGRectMake(0, 0, WIDTH, kTableHeight);
        
        _table.scrollEnabled = NO;
        [_table registerClass:[ModeOfPayCell class] forCellReuseIdentifier:@"cellid"];
        _table.rowHeight = 60;
        [_backgroundView addSubview:_table];
        
    }
    return self;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view  = [[UIView alloc]init];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [cancelBtn setImage:[UIImage imageNamed:@"icon_close"]forState:UIControlStateNormal];
    
    [cancelBtn bk_addEventHandler:^(id  _Nonnull sender) {
        
        [self dismiss];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:cancelBtn];
    
    ZW_Label *titleLabel = [[ZW_Label alloc]initWithStr:@"选择支付方式" addSubView:view];
    
    titleLabel.font = [UIFont systemFontOfSize:18.0];
    
    cancelBtn.sd_layout.leftSpaceToView(view,15).topSpaceToView(view,(45 - 14) / 2).heightIs(14).widthIs(14);
    
    CGFloat titleWidth = [ManagerEngine setTextWidthStr:titleLabel.text andFont:[UIFont systemFontOfSize:18.0]];
    
    titleLabel.sd_layout.leftSpaceToView(view,(WIDTH - titleWidth) / 2).topSpaceToView(view,(45 - 18) / 2).heightIs(18).widthIs(titleWidth);
    
    UIView *lineView= [[UIView alloc]initWithFrame:CGRectMake(0, 45 - 0.5, WIDTH, 0.5)];
    
    lineView.backgroundColor = [ManagerEngine getColor:@"cccccc"];
    
    [view addSubview:lineView];
    
    return view;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 45;
    }else {
        return  0.001;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return 2;
    
}
-(ModeOfPayCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    
    ModeOfPayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    cell.isArrearage = _isArrearage;
    cell.textLabel.text = self.payTitleArray[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.payImageArray[indexPath.section][indexPath.row]];
    if ([self.payTitleArray[indexPath.section][indexPath.row] isEqualToString:@"积分支付(余额不足)"]) {
           
        cell.textLabel.textColor = [ManagerEngine getColor:@"999999"];
        cell.userInteractionEnabled = NO;
    }
//    cell.payModeStr = _payModeStr;
//    [cell setCellIndexPath:indexPath];
    if ( self.selectCellIndexPath == nil ) {
        if (_isArrearage) {
            if (indexPath.row == 3) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;

            }
        } else {
            if (indexPath.row == 0) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                
            }
        }
    } else {
        if ([self.selectCellIndexPath isEqual:indexPath]) {
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        } else {
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
    }
    
    
   
    return cell;
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectCellIndexPath) {
        ModeOfPayCell *cell = [tableView cellForRowAtIndexPath:self.selectCellIndexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    ModeOfPayCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.selectCellIndexPath = indexPath;
    
    [_table reloadData];
    if (self.cellSelectBlock) {
        self.cellSelectBlock(cell.textLabel.text);
        
    }
    
    [self dismiss];
    
}

-(void)showView {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:self];
    
    [_table reloadData];
    
    _backgroundView.frame = CGRectMake(0, HEIGHT, WIDTH, kTableHeight) ;
    
    [UIView animateWithDuration:0.5 animations:^{
        _backgroundView.frame = CGRectMake(0, HEIGHT - kTableHeight, WIDTH, kTableHeight);


    } completion:^(BOOL finished) {
       
      

    }];
    
}

- (void)setIsArrearage:(BOOL)isArrearage {
    //    @"微信支付",@"icon_wechat_pay_normal", @"银联支付",@"union_pay",  测试self-> 刘海燕说：让微信和银联不可选

    if (isArrearage) {
        self.payTitleArray= @[@[@"支付宝支付",
                                   @"积分支付(余额不足)"]];
        self.payImageArray = @[@[@"icon_alipay_normal",
                                       @"icon_integration_normal"]];
    } else {
        
//         @"微信支付",@"icon_wechat_pay_normal",@"银联支付" @"union_pay"
        self.payTitleArray = @[@[@"积分支付",
                                  @"支付宝支付"]];
        self.payImageArray = @[@[@"icon_integration_normal",
                                       @"icon_alipay_normal"]];
    }
 
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
//self.viewModel.titleLabelArray[self.selectCellIndexPath.row]
     
//     cell.accessoryType = UITableViewCellAccessoryCheckmark;
    if (self.cellSelectBlock) {
        self.cellSelectBlock(self.payTitleArray[self.selectCellIndexPath.section][self.selectCellIndexPath.row]);

    }

    [self dismiss];
}

-(void)dismiss {
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _backgroundView.frame = CGRectMake(0, HEIGHT , WIDTH, kTableHeight);

    } completion:^(BOOL finished) {
        
            [self removeFromSuperview];
      
        
    }];

   
}

@end
